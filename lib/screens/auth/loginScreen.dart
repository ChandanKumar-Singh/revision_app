import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/providers/AuthProvider.dart';
import 'package:revision/screens/auth/forgotPassword.dart';
import 'package:revision/screens/auth/passwordScreen.dart';
import 'package:revision/screens/onBoarding/onBoarding.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool agreedTerms = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, ap, _) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SizedBox(
              // height: animation.value,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.offAll(const OnBoarding());
                                  },
                                  icon: const Icon(
                                    Icons.clear,
                                    size: 32,
                                  )),
                            ],
                          ),
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
                              h3Text('Sign In'),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              b1Text('Enter your username'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: ap.username,
                                decoration:
                                    const InputDecoration(hintText: 'username'),
                              )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      Get.context!,
                                      slideLeftRoute(
                                          const ForgotPasswordScreen(),
                                          effect:
                                              PageTransitionType.rightToLeft));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: h6Text(
                                    'Forgot password?',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                              value: agreedTerms,
                              onChanged: (val) {
                                setState(() {
                                  agreedTerms = !agreedTerms;
                                });
                              }),
                          Expanded(
                            child: b1Text(
                                ' agree to the terms and conditions as set out by the user agreement.'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              launchUrl(Uri.parse(
                                  'https://www.termsfeed.com/legal/terms-of-use/'));
                            },
                            child: const Text(
                              'terms and conditions',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (ap.username.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: 'Please enter username');
                                    } else {
                                      ap.loadEmail();
                                    }
                                  },
                                  child: const Text('Confirm & Proceed')))
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
