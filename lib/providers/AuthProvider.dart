import 'dart:async';
import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/models/AssociateModel.dart';
import 'package:revision/providers/UserProvider.dart';
import 'package:revision/screens/auth/forgotPassword.dart';
import 'package:revision/screens/auth/loginScreen.dart';
import 'package:revision/screens/onBoarding/onBoarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../functions.dart';
import '../screens/auth/passwordScreen.dart';
import 'package:http/http.dart' as http;

import '../screens/profile/profile.dart';
import '../screens/profile/updatePassword.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoadingEmail = false;
  TextEditingController username = TextEditingController();
  TextEditingController passController = TextEditingController();
  PageController pageController = PageController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool otpSent = false;
  int otpSentCount = 0;
  final int resendTimeOut = 10;
  int resendTimer = 10;
  late Timer timer;

  String verificationId = '';
  Future<void> loadEmail() async {
    Navigator.push(
        Get.context!,
        slideLeftRoute(const PasswordScreen(),
            effect: PageTransitionType.rightToLeft));
  }

  Future<void> sendForgotOtp() async {
    if (isOnline) {
      try {
        var url = App.baseUrl + App.forgetPassword;
        var headers = {'Content-Type': 'application/json'};
        var body = {"input": username.text};
        hoverLoadingDialog(true);
        var res = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            print(jsonDecode(res.body)['response']);
            username.text = jsonDecode(res.body)['response']['username'];
            notifyListeners();
            await auth
                .verifyPhoneNumber(
                    phoneNumber:
                        '+91${jsonDecode(res.body)['response']['phone']}',
                    timeout: Duration(seconds: resendTimeOut),
                    verificationCompleted: (credentials) {},
                    verificationFailed: (exception) {
                      verificationId = '';
                      Fluttertoast.showToast(msg: exception.message!);
                    },
                    codeSent: (message, newToken) {
                      verificationId = message;
                      Fluttertoast.showToast(
                          msg:
                              'A OTP has sent to your registered mobile number');
                      otpSentCount++;
                      runResendTimer();
                      otpSent = true;
                      notifyListeners();
                    },
                    codeAutoRetrievalTimeout: (reason) {
                      Fluttertoast.showToast(
                          msg: 'Time out for otp verification');
                    })
                .then((value) {});
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
          hoverLoadingDialog(false);
        } else {
          hoverLoadingDialog(false);

          debugPrint(res.body.toString());
        }
        // hoverLoadingDialog(false);
      } on FirebaseAuthException catch (e) {
        debugPrint(e.toString());
        hoverLoadingDialog(false);
      }
    } else {
      showNetWorkToast(msg: 'You are offline. Please connect to network');
    }
    debugPrint('otp count $otpSentCount  otp sent $otpSent');
  }

  Future<void> forgotPassOtpVerification() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpController.text);
    if (isOnline) {
      try {
        if (verificationId.isEmpty) {
          Fluttertoast.showToast(msg: 'Otp has not send yet.');
        } else if (otpController.text.isEmpty) {
          Fluttertoast.showToast(msg: 'Please enter otp');
        } else {
          var user = await auth.signInWithCredential(credential);
          if (user.user != null) {
            otpController.clear();
            verificationId = '';
            Navigator.push(
                Get.context!,
                slideLeftRoute(UpdatePassword(callBack: (pass) async {
                  await changePassword(pass, username.text);
                }),
                    effect: PageTransitionType.rightToLeftJoined,
                    current: const ForgotPasswordScreen()));
            auth.signOut();
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'session-expired') {
          Fluttertoast.showToast(msg: e.message!);
        } else if (e.code == 'invalid-verification-code') {
          Fluttertoast.showToast(msg: e.message!);
        }
        print(e);
      }
    } else {
      showNetWorkToast(msg: 'You are offline. Please connect to network');
    }
    print('otp count $otpSentCount  otp sent $otpSent');
  }

  Future<void> changePassword(String pass, String id) async {
    try {
      hoverLoadingDialog(true);
      if (isOnline) {
        var url = App.baseUrl + App.updatePassword;
        var headers = {'Accept': '*/*'};
        var body = {
          "new_password": pass,
          "confirm_password": pass,
          "username": id
        };
        var res = await http.post(Uri.parse(url), headers: headers, body: body);
        debugPrint(res.body);
        debugPrint(res.statusCode.toString());
        debugPrint(body.toString());
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            await prefs.setString('password', pass);
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);

            Future.delayed(const Duration(seconds: 1), () {
              username.clear();
              otpSentCount = 0;
              Get.offAll(const LoginScreen());
            });
          } else {
            Fluttertoast.showToast(
                msg: jsonDecode(res.body)['error']['new_password'][0]);
          }
        } else {
          Fluttertoast.showToast(msg: 'Something went wrong');
        }
      } else {
        showNetWorkToast(msg: 'You are offline. Please connect to network');
      }
    } catch (e) {
      print('e e e e e e e   e  ee e  e ---> $e');
    }
    hoverLoadingDialog(false);
  }

  void runResendTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer > 0) {
        resendTimer--;
        notifyListeners();
      } else {
        resendTimer = 10;

        notifyListeners();
        timer.cancel();
      }
    });
  }

  Future<dynamic> login({bool? imLogging}) async {
    var response;

    try {
      bool cacheExist = await APICacheManager().isAPICacheKeyExist('login');
      hoverLoadingDialog(true);

      if (isOnline) {
        var url = App.baseUrl + App.login;
        var headers = {'Content-Type': 'application/json'};
        var body = {
          "username": username.text,
          "password": passController.text,
          'device_token': deviceToken
        };
        print('login parameters $body');
        var res = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['status'] == 200) {
            var cacheModel = APICacheDBModel(key: 'login', syncData: res.body);
            await APICacheManager().addCacheData(cacheModel);
            response = jsonDecode(res.body);
            await saveTokenToDB(
                deviceToken, response['results']['data']['username']);

            if (response['results']['data']['image'] != null &&
                response['results']['data']['image'] != '') {
              await downloadAndSaveProfileImage(
                  App.imageBase + response['results']['data']['image'],
                  '$appTempPath/${response['results']['data']['image'].split('/').last}');
            }
            await prefs.setString('username', username.text);
            await prefs.setString('password', passController.text);
            passController.clear();
            username.clear();
            // [firebase_auth/invalid-verification-code] The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user.
            // I/flutter ( 9434): invalid-verification-code
          } else {
            Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
          }
        }
        print("it's url Hit ${response['results']['data']}");
      } else {
        showNetWorkToast();
        if (cacheExist) {
          response = jsonDecode(
              (await APICacheManager().getCacheData('login')).syncData);
          print("it's cache Hit");
          print("it's cache Hit ${response['results']['data']}");
        }
      }

      if (response != null) {
        messaging.onTokenRefresh.listen((fcmToken) async {
          deviceToken=fcmToken;
          await saveTokenToDB(
              deviceToken, response['results']['data']['username']);
        }).onError((err) {
          debugPrint('e e e e e e e messaging.onTokenRefresh.listen  -> $err');
        });
        print(response);
        Provider.of<UserProvider>(Get.context!, listen: false).associate =
            AssociateModel.fromJson(response['results']);
        prefs = await SharedPreferences.getInstance();
        Provider.of<UserProvider>(Get.context!, listen: false)
            .initRecommendedBio();
        await prefs.setString('token', response['results']['token']);
      }
    } catch (e) {
      debugPrint('e e e e e e e -> $e');
    }
    if (imLogging != null && !isOnline) {
      response = null;
    }
    // print('testing login ------ > $imLogging    $response');
    hoverLoadingDialog(false);
    return response;
  }

  Future<void> phoneVerification(String phone) async {
    try {
      if (phoneController.text.length != 10) {
        Fluttertoast.showToast(msg: 'Please enter a valid phone number');
      } else if (phoneController.text != phone) {
        Fluttertoast.showToast(
            msg: 'Please enter your registered phone number');
      } else {
        auth.verifyPhoneNumber(
            phoneNumber: '+91${phoneController.text}',
            timeout: const Duration(seconds: 120),
            verificationCompleted: (credentials) {},
            verificationFailed: (exception) {
              Fluttertoast.showToast(msg: exception.message!);
            },
            codeSent: (message, newToken) {
              verificationId = message;
              pageController.jumpToPage(1);

              notifyListeners();
            },
            codeAutoRetrievalTimeout: (reason) {
              Fluttertoast.showToast(msg: 'Time out for phone verification');
            });
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> signInFromNumber() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpController.text);
    try {
      if (verificationId.isEmpty) {
        Fluttertoast.showToast(msg: 'Otp has not send yet.');
      } else if (otpController.text.isEmpty) {
        Fluttertoast.showToast(msg: 'Please enter otp');
      } else {
        var user = await auth.signInWithCredential(credential);
        if (user.user != null) {
          phoneController.clear();
          otpController.clear();
          verificationId = '';
          Get.back();
          Navigator.push(
              Get.context!,
              slideLeftRoute(UpdatePassword(callBack: (pass) async {
                await changeProfilePassword(
                  passController.text,
                  prefs.getString('token')!,
                );
              }),
                  effect: PageTransitionType.rightToLeftJoined,
                  current: const ProfilePage()));
          auth.signOut();
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'session-expired') {
        Fluttertoast.showToast(msg: e.message!);
      } else if (e.code == 'invalid-verification-code') {
        Fluttertoast.showToast(msg: e.message!);
      }
      print(e);
    }
  }

  Future<void> changeProfilePassword(String pass, String token) async {
    try {
      hoverLoadingDialog(true);
      if (isOnline) {
        var url = App.baseUrl + App.profileUpdatePassword;
        var headers = {'Accept': '*/*', 'Authorization': 'Bearer $token'};
        var body = {
          "password": pass,
        };
        var res = await http.post(Uri.parse(url), headers: headers, body: body);
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)['success'] == 200) {
            await prefs.setString('password', pass);
            Future.delayed(const Duration(seconds: 2), () {
              Get.back();
            });
          }
          Fluttertoast.showToast(msg: jsonDecode(res.body)['message']);
        }
      } else {
        showNetWorkToast(msg: 'You are offline. Please connect to network');
      }
    } catch (e) {
      print('e e e e e e e   e  ee e  e ---> $e');
    }
    hoverLoadingDialog(false);
  }

  Future<void> logOut() async {
    hoverLoadingDialog(true);
    try {
      AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.question,
          title: "Are you sure to log out?",
          btnCancelOnPress: () {
            hoverLoadingDialog(false);
          },
          btnCancelText: 'No',
          btnOkText: 'Yes sure!',
          btnOkOnPress: () async {
            prefs.remove('token');
            Future.delayed(const Duration(seconds: 2), () {
              hoverLoadingDialog(false);
              Get.offAll(const OnBoarding());
            });
          }).show();
    } catch (e) {
      hoverLoadingDialog(false);
      debugPrint('logout error ---> $e');
    }
  }
}
