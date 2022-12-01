import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

import '../../constants/app.dart';
import '../../constants/widgets.dart';
import '../../functions.dart';
import '../../providers/AuthProvider.dart';
import '../../providers/UserProvider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool showFirstNameError = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context,listen: false).initRecommendedBio();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, up, _) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight / 1.5),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                ],
              ),
              Row(
                children: [
                  h6Text(
                    'Change Your Profile ',
                    // color: Colors.white,
                  ),

                ],
              ),
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
                                  backgroundImage: up.associate.data!.image !=
                                              null &&
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
                                    duration:
                                        const Duration(milliseconds: 2000),
                                  ),
                                ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                await pickImageDialog(up);
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color(0xF0EA284C).withOpacity(0.3),
                                radius: 25,
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color(0xF0EA284C).withOpacity(1),
                                  radius: 20,
                                  child: const Icon(Icons.edit,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
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
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      b1Text(
                                        'First Name ',
                                        // color: Colors.white,
                                      ),
                                      b1Text(
                                        '(Required)',
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  TextFormField(
                                    controller: up.recommendedBio[0],
                                  ),
                                  if (showFirstNameError)
                                    Column(
                                      children: [
                                        const SizedBox(height: 2),
                                        capText(
                                          '* First Name is required ',
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      b1Text(
                                        'Last Name ',
                                        // color: Colors.white,
                                      ),
                                      b1Text(
                                        '(Optional)',
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  TextFormField(
                                    controller: up.lastNameController,
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      b1Text(
                                        'Email ',
                                        // color: Colors.white,
                                      ),
                                      b1Text(
                                        '(Recommended)',
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  TextFormField(
                                    controller: up.recommendedBio[1],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      b1Text(
                                        'Phone ',
                                        // color: Colors.white,
                                      ),
                                      b1Text(
                                        '(Recommended)',
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: up.recommendedBio[2],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      b1Text(
                                        'Address ',
                                        // color: Colors.white,
                                      ),
                                      b1Text(
                                        '(Recommended)',
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  TextFormField(
                                    controller: up.recommendedBio[3],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              ElevatedButton(
                onPressed: () async {
                  if (up.recommendedBio[0].text.isEmpty) {
                    setState(() {
                      showFirstNameError = true;
                    });
                  } else {
                    setState(() {
                      showFirstNameError = false;
                    });
                    await up.updateProfile();
                    // .then((value) => up.initRecommendedBio());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    h6Text(
                      'Update',
                      color:  Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      );
    });
  }
}
