import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/functions.dart';
import 'package:revision/screens/auth/loginScreen.dart';
import 'package:revision/screens/home/homePage.dart';

import '../onBoarding/onBoarding.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionSetup();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.primary,
      // backgroundColor: Color(App.swatchCode2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Container(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  // Image.asset(App.applogo),
                  Image.asset(
                    'assets/app/logo1.png',
                    width: Get.width / 2,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: h2Text(
                          '${App.appname.split(' ').first}\n${App.appname.substring(App.appname.split(' ').first.length, App.appname.length)}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoSerif().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
