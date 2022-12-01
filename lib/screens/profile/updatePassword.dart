import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/app.dart';
import '../../constants/widgets.dart';
import '../../providers/AuthProvider.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key, required this.callBack}) : super(key: key);
  final void Function(String pass) callBack;
  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  bool showMatchError = false;
  TextEditingController passController = TextEditingController();
  TextEditingController conPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  h5Text(
                    'Change Password',
                    // color: const Color(App.swatchCode),
                  ),
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

              Column(
                children: [
                  SizedBox(height: Get.height * 0.03),
                  Container(
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(10),
                    //   color: Get.theme.cardColor,
                    // ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                h6Text(
                                  'Enter Password',
                                  // color: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: passController,
                            ),
                            if (showMatchError)
                              Column(
                                children: [
                                  const SizedBox(height: 2),
                                  capText(
                                    '* Password did not match ',
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                h6Text(
                                  'Confirm Password',
                                  // color: Colors.white,
                                ),
                                b1Text(
                                  ' (should be same as above )',
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: conPassController,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (passController.text != conPassController.text) {
                    setState(() {
                      showMatchError = true;
                    });
                  } else {
                    setState(() {
                      showMatchError = false;
                    });
                     widget.callBack(passController.text);

                    // passController.clear();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    h6Text(
                      'Confirm & Update',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
