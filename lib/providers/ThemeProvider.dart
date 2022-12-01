import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../constants/app.dart';
import '../functions.dart';

class ThemeProvider extends ChangeNotifier {
  String tag = 'ThemeProvider';
  Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
  ThemeMode themeMode = ThemeMode.system;
  int? colorCode;
  void checkBrightness() async {
    var brt;
    var theme;
    brt = prefs.getString('brightness');
    theme = prefs.getString('theme');
    if (brt != null&&theme!=null) {
      if (brt == SchedulerBinding.instance.window.platformBrightness.name) {
        brightness = SchedulerBinding.instance.window.platformBrightness;
        notifyListeners();
      } else {
        brightness = brt == 'dark' ? Brightness.dark : Brightness.light;
        themeMode = brt == 'dark' ? ThemeMode.dark : ThemeMode.light;

        notifyListeners();
      }
    }
    print('$tag brt $brt');
    print('$tag brightness $brightness');
  }

  toogleBrt() async {
    brightness =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    themeMode = themeMode.name == ThemeMode.dark.name
        ? ThemeMode.light
        : ThemeMode.dark;
    themeMode == ThemeMode.dark ? colorCode = 0xFF7344c8 : 0xFF343448;
    notifyListeners();
    await prefs.setString('brightness', brightness.name);
    await prefs.setString('theme', themeMode.name);
  }
}
