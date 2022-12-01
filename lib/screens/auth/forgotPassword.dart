import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:revision/functions.dart';
import 'package:revision/screens/auth/loginScreen.dart';

import '../../constants/app.dart';
import '../../constants/widgets.dart';
import '../../providers/AuthProvider.dart';
import '../landing/landingPage.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  bool showPass = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> willPop() async {
    var ap = Provider.of<AuthProvider>(context, listen: false);
    ap.otpSent = false;
    ap.otpSentCount = 0;
    ap.username.clear();
    ap.phoneController.clear();
    ap.otpController.clear();
    if (ap.otpSentCount == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willBack = await willPop();

        return willBack;
      },
      child: Consumer<AuthProvider>(builder: (context, ap, _) {
        // print(ap.otpSentCount);
        // ap.otpSentCount=0;
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        IconButton(
                            onPressed: () async {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  slideLeftRoute(const LoginScreen(),
                                      effect: PageTransitionType.leftToRight,
                                      period: 500),
                                  (route) => false);
                              await willPop();
                            },
                            icon: const Icon(
                              Icons.clear,
                              size: 32,
                            )),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          App.applogo,
                          width: Get.width / 4,
                        )
                      ],
                    ),
                    const SizedBox(height: 30),

                    Row(
                      children: [
                        h4Text('Reset Password'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    if (ap.otpSentCount == 0)
                      Column(
                        children: [
                          Row(
                            children: [
                              b1Text('Enter your username or phone'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: ap.username,
                                  readOnly: ap.resendTimer != 10,
                                  enabled: ap.resendTimer == 10,
                                  decoration: InputDecoration(
                                    hintText: 'username or phone',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),
                    if (ap.otpSentCount > 0)
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: b1Text(
                                      'A otp sent to your registered mobile number')),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: ap.otpController,
                                decoration: const InputDecoration(
                                  hintText: 'ex:123456',
                                ),
                              )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(height: 5),
                              if (ap.resendTimer != 10)
                                b1Text(' ${ap.resendTimer} sec'),
                              TextButton(
                                onPressed: ap.resendTimer < ap.resendTimeOut
                                    ? null
                                    : () async {
                                        if (ap.username.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Please enter your username');
                                        } else {
                                          // await ap.login(imLogging: true).then((value) {
                                          //   if (value != null) {
                                          //     Navigator.pushAndRemoveUntil(
                                          //         Get.context!,
                                          //         slideLeftRoute(const LandingPage(),
                                          //             effect: PageTransitionType
                                          //                 .rightToLeft),
                                          //             (r) => false);
                                          //   }
                                          // });
                                          await ap.sendForgotOtp();
                                        }
                                      },
                                child: Text('Resend Otp'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (ap.otpSent) {
                                    if (ap.otpController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'Please enter your otp');
                                    } else {
                                      await ap.forgotPassOtpVerification();
                                    }
                                  } else {
                                    if (ap.username.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'Please enter your username');
                                    } else {
                                      await ap.sendForgotOtp();
                                    }
                                  }
                                },
                                child: Text(
                                    ap.otpSent ? 'Verify OTP' : 'Send OTP')))
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
