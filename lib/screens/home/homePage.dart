import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/constants/widgets.dart';
import 'package:revision/providers/ThemeProvider.dart';
import 'package:revision/providers/UserProvider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:revision/screens/profile/profile.dart';

import '../../functions.dart';
import 'HomeDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, up, _) {
      double heignt = Get.height;
      double weight = Get.width;

      return Consumer<ThemeProvider>(builder: (context, tp, _) {
        print(tp.themeMode);
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(),
          drawer: HomeDrawer(
              scaffoldKey: _scaffoldKey,
              height: heignt,
              up: up,
              onChangeTheme: () {
                Timer(const Duration(milliseconds: 500), () {
                  setState(() {});
                });
              }),
          body: SingleChildScrollView(
            child: Column(
              children: [
                h3Text(
                  'This is home Page',
                ),  Text(
                  'This is home Page',
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
