import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/functions.dart';
import 'package:revision/screens/auth/loginScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController pageController;
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0);
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.floor();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              reverse: false,
              children: [
                Scaffold(
                  body: Column(
                    children: [
                      Expanded(
                        child: Image.asset('assets/onboarding/1.png'),
                      ),
                      Container(
                        height: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        // color: Colors.grey,
                        child: Column(
                          children: [
                            h4Text(
                              'Welcome',
                              textAlign: TextAlign.center,
                              color: App.themecolor,
                            ),
                            h5Text(
                              'Make your own bussiness with us',
                              textAlign: TextAlign.center,
                              color: App.themecolor5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Scaffold(
                  body: Column(
                    children: [
                      Expanded(
                        child: Image.asset('assets/onboarding/3.png'),
                      ),
                      Container(
                          height: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 20),

                          // color: Colors.grey,
                          child: h5Text(
                              'The main focus is on recruiting and selling as much as you can to earn more commission.',
                              textAlign: TextAlign.center,
                              color: App.themecolor5.withOpacity(1))),
                    ],
                  ),
                ),
                Scaffold(
                  body: Column(
                    children: [
                      Expanded(
                        child: Image.asset('assets/onboarding/4.png'),
                      ),
                      Container(
                          height: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 20),

                          // color: Colors.grey,
                          child: Column(
                            children: [
                              h4Text(
                                'System Of Hierarchy ',
                                textAlign: TextAlign.center,
                                color: Get.theme.textTheme.headline6!.color,
                              ),
                              h5Text(
                                'Participants are also the consumers of the network.',
                                textAlign: TextAlign.center,
                                color: App.themecolor5.withOpacity(1),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        pageController.jumpToPage(2);
                        // duration: const Duration(milliseconds: 500),
                        // curve: Curves.easeIn);
                      },
                      child: const Text('Skip')),
                  const Spacer(),
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        axisDirection: Axis.vertical,
                        effect: const ExpandingDotsEffect()),
                  ),
                  const Spacer(),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        if (currentIndex < 2) {
                          setState(() {
                            pageController.animateToPage(currentIndex + 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          });
                        } else {
                          Navigator.pushReplacement(
                              context, slideUpRoute(const LoginScreen()));
                          // Get.to(const LoginScreen());
                        }
                      },
                      child: Text(currentIndex < 2 ? 'Next' : 'Login'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
