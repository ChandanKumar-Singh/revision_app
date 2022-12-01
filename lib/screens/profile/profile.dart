import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/functions.dart';
import 'package:revision/providers/AuthProvider.dart';
import 'package:revision/providers/ThemeProvider.dart';
import 'package:revision/providers/UserProvider.dart';
import 'package:revision/screens/profile/editProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, up, _) {
      print(Get.theme.textTheme.headline6!.fontFamily);
      double profileValue =
          (up.recommendedBio.where((element) => element.text != '').length /
              up.recommendedBio.length);
      print(MediaQuery.of(context).viewInsets.bottom);

      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Column(children: [
                const SizedBox(height: kToolbarHeight / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    IconButton(
                        onPressed: () {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toogleBrt();
                          Timer(const Duration(milliseconds: 500), () {
                            setState(() {});
                          });
                        },
                        icon: const Icon(Icons.settings_outlined)),
                  ],
                ),
              ],),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                     
                      Stack(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Get.theme.colorScheme.primary,
                                radius: kToolbarHeight,
                                child: CircleAvatar(
                                  backgroundColor: Get.theme.primaryColor,
                                  radius: kToolbarHeight - 2,
                                  backgroundImage: up.associate.data!.image != null &&
                                          up.associate.data!.image != ''
                                      ? FileImage(File(
                                          '$appTempPath/${up.associate.data!.image!.split('/').last}'))
                                      : const AssetImage('assets/user.png')
                                          as ImageProvider,
                                ),
                              ),
                              if (up.uploadingImage)
                                Positioned.fill(
                                  child: LoadingBouncingGrid.square(
                                    borderColor: Get.theme.colorScheme.primary,
                                    borderSize: 3.0,
                                    size: 30.0,
                                    inverted: false,
                                    backgroundColor: Colors.white,
                                    duration: const Duration(milliseconds: 2000),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.03),
                      GestureDetector(
                        onTap: () async {
                          await pickImageDialog(up);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: App.themecolor4.withOpacity(0.8),
                              color: Get.theme.cardColor,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                h6Text(
                                  'Change profile pic',
                                  // color: const Color(App.swatchCode),
                                ),
                                Icon(
                                  Icons.edit_outlined,
                                  color: Get.theme.colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Get.theme.cardColor,
                          ),
                          padding:
                              const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: h5Text(
                                              up.associate.data!.fullName ?? '',
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  h6Text(
                                      'Email : ${up.associate.data!.email ?? 'N/A'}'),
                                  SizedBox(height: Get.height * 0.01),
                                  h6Text(
                                      'Phone : ${up.associate.data!.phone ?? 'N/A'}'),
                                  SizedBox(height: Get.height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          h6Text(
                                            'Status : ',
                                            // color: Colors.white,
                                          ),
                                          h6Text(
                                            (up.associate.data!.status ?? '')
                                                .capitalize!,
                                            // color: Colors.white,
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          h6Text(
                                            'Plot Area : ',
                                            // color: Colors.white,
                                          ),
                                          h6Text(
                                            (up.associate.data!.plotArea ?? '')
                                                .capitalize!,
                                            // color: Colors.white,
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          h6Text(
                                            'Plot No. : ',
                                            // color: Colors.white,
                                          ),
                                          h6Text(
                                            (up.associate.data!.plotNo ?? '')
                                                .capitalize!,
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          h6Text(
                                            'Sponsor Id : ',
                                            // color: Colors.white,
                                          ),
                                          h6Text(
                                            (up.associate.data!.sponsorId ?? '')
                                                .capitalize!,
                                            // color: Colors.white,
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          h6Text('Address : '),
                                        ],
                                      ),
                                      Expanded(
                                        child:
                                            h6Text(up.associate.data!.address ?? 'N/A'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        minHeight: 15,
                                        value: profileValue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      h6Text(
                                        'Profile',
                                        // color: Colors.white,
                                      ),
                                      b1Text(
                                        '  ${profileValue == 1 ? '✅' : "${(profileValue * 100).floor()}%"}   Completed',
                                        // color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          slideLeftRoute(const EditProfile(),
                                              effect:
                                                  PageTransitionType.rightToLeftJoined,
                                              current: const ProfilePage()));
                                    },
                                    child: h6Text(
                                      'Edit',
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),
                      GestureDetector(
                        onTap: () async {
                          if (up.associate.data!.phone == null ||
                              up.associate.data!.phone == '') {
                            Fluttertoast.showToast(
                                msg: 'Your phone number is not registered');
                          } else {
                            Provider.of<AuthProvider>(context, listen: false)
                                .phoneController
                                .text = up.associate.data!.phone!;
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const PhoneVerificationSheet();
                                });
                          }
                          // showShortSheetActions(
                          //     width: Get.width * 0.8,
                          //     color: Colors.white,
                          //     height: 250+MediaQuery.of(context).viewInsets.bottom,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: SingleChildScrollView(
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 Expanded(
                          //                     child: h6Text(
                          //                         'Please verify your identity',
                          //                         color: Colors.redAccent)),
                          //               ],
                          //             ),
                          //             const SizedBox(height: 5),
                          //             Row(
                          //               children: [
                          //                 Expanded(
                          //                   child: b1Text(
                          //                       'Enter your registered phone number'),
                          //                 ),
                          //               ],
                          //             ),
                          //             const SizedBox(height: 3),
                          //             Row(
                          //               children: const [
                          //                 Expanded(
                          //                     child: TextField(
                          //                   keyboardType: TextInputType.number,
                          //                 )),
                          //               ],
                          //             ),
                          //             const SizedBox(height: 5),
                          //             Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceAround,
                          //               children: [
                          //                 ElevatedButton(
                          //                   onPressed: () {
                          //                     Get.back();
                          //                   },
                          //                   child: const Text('Cancel'),
                          //                 ),
                          //                 ElevatedButton(
                          //                   onPressed: () {
                          //                     Get.back();
                          //                   },
                          //                   child: const Text('Submit'),
                          //                 ),
                          //               ],
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     ));
                          ///
                          // await Provider.of<AuthProvider>(context, listen: false)
                          //     .phoneVerification('+919135324545');
                          // Navigator.push(
                          //     context,
                          //     slideLeftRoute(const UpdatePassword(),
                          //         effect: PageTransitionType.rightToLeftJoined,
                          //         current: const ProfilePage()));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.theme.cardColor,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.key,
                                ),
                                SizedBox(width: Get.width * 0.1),
                                h6Text('Change Password'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),
                      GestureDetector(
                        onTap: () async {
                          await Provider.of<AuthProvider>(context, listen: false)
                              .logOut();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              SizedBox(width: Get.width * 0.1),
                              h6Text('Logout', color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.03),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class PhoneVerificationSheet extends StatelessWidget {
  const PhoneVerificationSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        enableDrag: false,
        builder: (context) {
          return Consumer<AuthProvider>(builder: (context, ap, _) {
            print(ap.phoneController.text);
            return Container(
              height: Get.height * 0.6,
              padding: const EdgeInsets.all(8.0),
              child: PageView(
                controller: ap.pageController,
                allowImplicitScrolling: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: h6Text('Please verify your identity',
                                    color: Colors.redAccent)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child:
                                  b1Text('Enter your registered phone number'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            SizedBox(width: Get.width * 0.05),
                            Expanded(
                                flex: 2,
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: '+91',
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10)),
                                  keyboardType: TextInputType.number,
                                )),
                            const SizedBox(width: 10),
                            Expanded(
                                flex: 8,
                                child: TextField(
                                  controller: ap.phoneController,
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10)),
                                  keyboardType: TextInputType.number,
                                )),
                            SizedBox(width: Get.width * 0.1),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await ap.phoneVerification(
                                    Provider.of<UserProvider>(context,
                                                listen: false)
                                            .associate
                                            .data!
                                            .phone ??
                                        '');
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: h6Text('Otp has been sent',
                                    color: Colors.redAccent)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: b1Text('Enter the otp below'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: ap.otpController,
                              decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10)),
                              keyboardType: TextInputType.number,
                            )),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await ap.signInFromNumber();
                                // await auth.signOut();
                              },
                              child: const Text('Verify'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}

//
// class PinputExample extends StatefulWidget {
//   const PinputExample({Key? key}) : super(key: key);
//
//
//   @override
//   State<PinputExample> createState() => _PinputExampleState();
// }
//
// class _PinputExampleState extends State<PinputExample> {
//   final pinController = TextEditingController();
//   final focusNode = FocusNode();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     print(pinController.length);
//   }
//   @override
//   void dispose() {
//     pinController.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
//     const fillColor = Color.fromRGBO(243, 246, 249, 0);
//     const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
//
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//         fontSize: 22,
//         color: Color.fromRGBO(30, 60, 87, 1),
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(19),
//         border: Border.all(color: borderColor),
//       ),
//     );
//     return Consumer<AuthProvider>(
//       builder: (context,ap,_) {
//         return Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Directionality(
//                 textDirection: TextDirection.ltr,
//                 child: Pinput(
//                   controller: pinController,
//                   focusNode: focusNode,
//                   androidSmsAutofillMethod:
//                       AndroidSmsAutofillMethod.smsUserConsentApi,
//                   listenForMultipleSmsOnAndroid: true,
//                   defaultPinTheme: defaultPinTheme,
//                   // validator: (value) {
//                   //   return value == 0000.toString()? null : 'Pin is incorrect';
//                   // },
//                   onClipboardFound: (value) {
//                     debugPrint('onClipboardFound: $value');
//                     pinController.setText(value);
//                   },
//                   hapticFeedbackType: HapticFeedbackType.lightImpact,
//                   onCompleted: (pin) {
//                     debugPrint('onCompleted: $pin');
//                   },
//                   onChanged: (value) {
//                     debugPrint('onChanged: $value');
//                   },
//                   cursor: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(bottom: 9),
//                         width: 22,
//                         height: 1,
//                         color: focusedBorderColor,
//                       ),
//                     ],
//                   ),
//                   focusedPinTheme: defaultPinTheme.copyWith(
//                     decoration: defaultPinTheme.decoration!.copyWith(
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: focusedBorderColor),
//                     ),
//                   ),
//                   submittedPinTheme: defaultPinTheme.copyWith(
//                     decoration: defaultPinTheme.decoration!.copyWith(
//                       color: fillColor,
//                       borderRadius: BorderRadius.circular(19),
//                       border: Border.all(color: focusedBorderColor),
//                     ),
//                   ),
//                   errorPinTheme: defaultPinTheme.copyBorderWith(
//                     border: Border.all(color: Colors.redAccent),
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () => formKey.currentState!.validate(),
//                 child: const Text('Validate'),
//               ),
//             ],
//           ),
//         );
//       }
//     );
//   }
// }
