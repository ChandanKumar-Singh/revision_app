import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/providers/UserProvider.dart';

import '../../functions.dart';
import '../home/homePage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, up, _) {
      print(up.associate.data!.image);
      print('${App.imageBase}${up.associate.data!.image}');
      return Scaffold(
        backgroundColor: Get.theme.colorScheme.primary.withOpacity(0.5),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: kTextTabBarHeight),
              SizedBox(
                height: Get.height - 2 * kToolbarHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: kTextTabBarHeight * 3),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Get.theme.cardColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          const SizedBox(
                                              height: kTextTabBarHeight * 3),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              h5Text('Hi,'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: h5Text(
                                                up.associate.data!.fullName ??
                                                    '',
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: kTextTabBarHeight * 1),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: h5Text(
                                                'Welcome to our team.\nThanks for joining us',
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        slideLeftRoute(
                                                            const HomePage(),
                                                            current:const LandingPage(),
                                                            effect:
                                                                PageTransitionType
                                                                    .rightToLeftJoined),
                                                        (route) => false,
                                                    );
                                                  },
                                                  child: h5Text(
                                                      'Get Started     ➡',
                                                      color: Colors.white)))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          top: kToolbarHeight,
                          left: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: kToolbarHeight * 3 / 2 + 10,
                            child: CircleAvatar(
                              radius: kToolbarHeight * 3 / 2,
                              backgroundColor: Get.theme.cardColor,
                              backgroundImage: up.associate.data!.image !=
                                          null &&
                                      up.associate.data!.image != ''
                                  ? FileImage(File(
                                  '$appTempPath/${up.associate.data!.image!.split('/').last}'))
                                  : const AssetImage('assets/user.png')
                                      as ImageProvider,
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
