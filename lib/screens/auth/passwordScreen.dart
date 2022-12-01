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

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen>
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

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, ap, _) {
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
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                slideLeftRoute(const LoginScreen(),
                                    effect: PageTransitionType.leftToRight,
                                    period: 500),
                                (route) => false);
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
                      h4Text('Password'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      b1Text('Enter your password'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: ap.passController,
                        obscureText: !showPass,
                        decoration: InputDecoration(
                          hintText: 'password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPass = !showPass;
                              });
                            },
                            icon: Icon(!showPass
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      )),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (ap.passController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'Please enter your password');
                                } else {
                                  await ap.login(imLogging: true).then((value) {
                                    if (value != null) {
                                      Navigator.pushAndRemoveUntil(
                                          Get.context!,
                                          slideLeftRoute(const LandingPage(),
                                              effect: PageTransitionType
                                                  .rightToLeft),
                                          (r) => false);
                                    }
                                  });
                                }
                              },
                              child: const Text('Confirm & Login')))
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
