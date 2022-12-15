import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/providers/UserProvider.dart';
import 'package:revision/screens/home/DrawerList.dart';
import 'package:revision/screens/profile/profile.dart';

import '../../functions.dart';
import '../../providers/ThemeProvider.dart';
import '../pages/Notification/NotificationsPage.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required this.height,
    required this.onChangeTheme,
    required this.up,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final double height;
  final UserProvider up;
  final VoidCallback onChangeTheme;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Drawer(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(1),
                  ),
                  height: kToolbarHeight * 2.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget._scaffoldKey.currentState!.closeDrawer();
                                Get.to(const ProfilePage());
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white30,
                                radius: kToolbarHeight - 26,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white10,
                                  radius: kToolbarHeight - 28,
                                  backgroundImage: widget
                                                  .up.associate.data!.image !=
                                              null &&
                                          widget.up.associate.data!.image != ''
                                      ? FileImage(File(
                                          '$appTempPath/${widget.up.associate.data!.image!.split('/').last}'))
                                      : const AssetImage('assets/user.png')
                                          as ImageProvider,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h6Text(
                                      '${widget.up.associate.data!.fullName}',
                                      maxLine: 2,
                                      color: Colors.white),
                                  b1Text(widget.up.associate.data!.email ?? '',
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                Positioned(
                    // top: Get.statusBarHeight + 10,
                    right: 10,
                    child: SafeArea(
                      child: IconButton(
                          splashColor: Colors.white,
                          onPressed: () {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toogleBrt();
                            widget.onChangeTheme();
                          },
                          icon: Icon(
                            Theme.of(context).brightness == Brightness.dark
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: Colors.white,
                          )),
                    ))
              ],
            ),
            // SizedBox(
            //   height: widget.height * 0.13,
            //   // decoration: BoxDecoration(
            //   //   // color: Theme.of(context).cardColor,
            //   //   color: Colors.transparent,
            //   // ),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 8.0),
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       padding: const EdgeInsets.symmetric(horizontal: 10),
            //       children: [
            //         GestureDetector(
            //           onTap: () {
            //             Get.to(const NotificationsPage());
            //           },
            //           child: Container(
            //             height: widget.height * 0.13,
            //             width: widget.height * 0.13,
            //             color: Colors.transparent,
            //             margin: const EdgeInsets.symmetric(horizontal: 3),
            //             child: Column(
            //               children: [
            //                 SizedBox(height: widget.height * 0.02),
            //                 Expanded(
            //                     child: Image.asset('assets/drawer/notice.png')),
            //                 SizedBox(height: widget.height * 0.02),
            //                 Row(
            //                   children: [
            //                     Expanded(
            //                         child: b1Text('Notice',
            //                             textAlign: TextAlign.center,
            //                             maxLine: 1)),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         GestureDetector(
            //           onTap: () {},
            //           child: Container(
            //             height: widget.height * 0.13,
            //             width: widget.height * 0.13,
            //             // color: Colors.white,
            //             margin: const EdgeInsets.symmetric(horizontal: 3),
            //
            //             child: Column(
            //               children: [
            //                 SizedBox(height: widget.height * 0.02),
            //                 Expanded(
            //                     child: Image.asset('assets/drawer/notice.png')),
            //                 SizedBox(height: widget.height * 0.02),
            //                 Row(
            //                   children: [
            //                     Expanded(
            //                         child: b1Text('Activities',
            //                             textAlign: TextAlign.center,
            //                             maxLine: 1)),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         GestureDetector(
            //           onTap: () {},
            //           child: Container(
            //             height: widget.height * 0.13,
            //             width: widget.height * 0.13,
            //             // color: Colors.white,
            //             margin: const EdgeInsets.symmetric(horizontal: 3),
            //
            //             child: Column(
            //               children: [
            //                 SizedBox(height: widget.height * 0.02),
            //                 Expanded(
            //                     child: Image.asset('assets/drawer/notice.png')),
            //                 SizedBox(height: widget.height * 0.02),
            //                 Row(
            //                   children: [
            //                     Expanded(
            //                         child: b1Text('Notice',
            //                             textAlign: TextAlign.center,
            //                             maxLine: 1)),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
            // GestureDetector(
            //   onTap: () {},
            //   child: Card(
            //     elevation: 1,
            //     margin: const EdgeInsets.all(0),
            //     child: SizedBox(
            //       height: height * 0.1,
            //       child: Row(
            //         children: [
            //           SizedBox(
            //               height: height * 0.1,
            //               child: Image.asset('assets/drawer/quick_guide.jpg',
            //                   fit: BoxFit.fill)),
            //           Expanded(
            //               child: SizedBox(
            //                 height: height * 0.1,
            //                 child: Center(
            //                     child: h5Text('Quick Start Guide',
            //                         textAlign: TextAlign.center)),
            //               )),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            const Expanded(child: DrawerList()),
          ],
        ),
      ),
    );
  }
}
