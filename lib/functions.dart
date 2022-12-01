import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/models/AssociateModel.dart';
import 'package:revision/providers/AuthProvider.dart';
import 'package:revision/providers/UserProvider.dart';
import 'package:revision/screens/home/homePage.dart';
import 'package:revision/screens/onBoarding/onBoarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import 'constants/widgets.dart';

Route slideUpRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route slideLeftRoute(
  Widget page, {
  PageTransitionType? effect,
  int? period,
  Widget? current,
}) {
  return PageTransition(
      childCurrent: current,
      type: effect ?? PageTransitionType.fade,
      child: page,
      duration: Duration(milliseconds: period ?? 500));
}

bool isOnline = false;
bool isLogin = false;
late SharedPreferences prefs;
var downloadedProfileImagePath = '';
late String appTempPath;
FirebaseAuth auth = FirebaseAuth.instance;


void connectionSetup() async {
  var connection = await Connectivity().checkConnectivity();
  isOnline = connection != ConnectivityResult.none;
  Connectivity().onConnectivityChanged.listen((event) {
    isOnline = event != ConnectivityResult.none;
    debugPrint(' now we are online $isOnline');
    showNetWorkToast();
  });
}

void checkLogin() async {
  prefs = await SharedPreferences.getInstance();
  appTempPath = (await getTemporaryDirectory()).path;

  var token = prefs.getString('token');
  if (token != null) {
    isLogin = true;
  }
  Timer(const Duration(seconds: 5), () async {
    if (!isLogin) {
      Get.offAll(const OnBoarding());
    } else {
      await initiateUserOffline().then((value) => Get.offAll(const HomePage()));
    }
  });
}

Future<XFile?> pickImage(ImageSource source) async {
  var image = await ImagePicker().pickImage(source: source);
  return image;
}

Future<void> initiateUserOffline({String? id, String? pass}) async {
  Provider.of<AuthProvider>(Get.context!, listen: false).username.text =
      id ?? prefs.getString('username')!;
  Provider.of<AuthProvider>(Get.context!, listen: false).passController.text =
      pass ?? prefs.getString('password')!;
  await Provider.of<AuthProvider>(Get.context!, listen: false).login();
}

Future downloadAndSaveProfileImage(String url, String savePath) async {
  try {
    var response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
      ),
    );
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
  } catch (e) {
    debugPrint('downloadAndSaveProfileImage error ---> $e');
  }
}

void showNetWorkToast({String? msg}) {
  Fluttertoast.showToast(
      msg: msg ??
          " ${isOnline ? "👍" : "🤦‍♂️"} You are  ${isOnline ? "Online back" : "Offline now"}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: isOnline
          ? Colors.green.withOpacity(0.5)
          : Colors.red.withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 16.0);
}

void hoverLoadingDialog(loading) async {
  if (loading) {
    await showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: Get.width / 2 - 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(
                    // color: Colors.white,
                    ),
              ),
            ),
          );
        });
  } else {
    Get.back();
  }
}

void showShortSheetActions(
    {required double width,
    required double height,
    double? radius,
    Color? color,
    Widget? child,
    EdgeInsetsGeometry? padding}) async {
  await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: Get.context!,
      isDismissible: false,
      builder: (context) {
        return Container(
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 10),
            boxShadow: [
              BoxShadow(
                color: Get.theme.primaryColor.withOpacity(0.6),
                // color:Colors.red,
                offset: Offset(1, 1),
                blurRadius: 15,
                spreadRadius: 10
              ),
            ],
            color:
                color ?? Color(Get.theme.indicatorColor.value).withOpacity(0.7),
          ),
          margin: EdgeInsets.only(
            left: (Get.width - width) / 2,
            right: (Get.width - width) / 2,
            bottom: (Get.height - height) / 2,
          ),
          child: child,
        );
      });
}

Future<void> pickImageDialog(UserProvider up) async {
  return showShortSheetActions(
    width: Get.width * 0.4,
    height: 100,
    color: Get.theme.colorScheme.primary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () async {
            Get.back();
            var image = await pickImage(ImageSource.camera);
            if (image != null) {
              up.imageFile = image;
              await up.updateImage();
            }
            print('${up.imageFile} this is picked image');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.camera,
                color: Colors.white,
                size: 50,
              ),
              Row(
                children: [
                  b1Text('Camera',
                      color: Colors.white, textAlign: TextAlign.center),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () async {
            Get.back();
            var image = await pickImage(ImageSource.gallery);
            if (image != null) {
              up.imageFile = image;
              await up.updateImage();
            }
            print('${up.imageFile} this is picked image');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.photo_library_sharp,
                color: Colors.white,
                size: 50,
              ),
              Row(
                children: [
                  b1Text('Gallery',
                      color: Colors.white, textAlign: TextAlign.center),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(
    context: Get.context!, barrierDimisable: false);

void showLoadingDialog(Future<void> function) async {
  _dialog.show(
    message: 'Loading...',
  );
  await function;
  _dialog.hide();
}
