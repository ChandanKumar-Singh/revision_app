import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/providers/AuthProvider.dart';
import 'package:revision/providers/ThemeProvider.dart';
import 'package:revision/providers/UserProvider.dart';
import 'package:revision/providers/teamCcontroller.dart';
import 'package:revision/screens/auth/launchScreen.dart';

import 'functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TeamProvider()),
      ],
      child: ScreenUtilInit(
          designSize: Size(Get.width, Get.height),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return Consumer<ThemeProvider>(builder: (context, tp, _) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Revision Infra-estate',
                themeMode: tp.themeMode,
                theme: ThemeData(
                  textTheme: TextTheme(
                    headline6: GoogleFonts.actor(),
                    headline5: GoogleFonts.actor(),
                    headline4: GoogleFonts.actor(),
                    headline3: GoogleFonts.actor(),
                    headline2: GoogleFonts.actor(),
                    headline1: GoogleFonts.actor(),
                    bodyText2: GoogleFonts.actor(),
                    bodyText1: GoogleFonts.actor(),
                    caption: GoogleFonts.actor(),
                  ),
                  primarySwatch: MaterialColor(
                    App.swatchCode,
                    {
                      50: const Color(App.swatchCode).withOpacity(0.1),
                      100: const Color(App.swatchCode).withOpacity(0.2),
                      200: const Color(App.swatchCode).withOpacity(0.3),
                      300: const Color(App.swatchCode).withOpacity(0.4),
                      400: const Color(App.swatchCode).withOpacity(0.5),
                      500: const Color(App.swatchCode).withOpacity(0.6),
                      600: const Color(App.swatchCode).withOpacity(0.7),
                      700: const Color(App.swatchCode).withOpacity(0.8),
                      800: const Color(App.swatchCode).withOpacity(0.9),
                      900: const Color(App.swatchCode).withOpacity(1),
                    },
                  ),
                  brightness: Brightness.light,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                darkTheme: ThemeData(
                  textTheme: TextTheme(
                    headline6: GoogleFonts.actor(),
                    headline5: GoogleFonts.actor(),
                    headline4: GoogleFonts.actor(),
                    headline3: GoogleFonts.actor(),
                    headline2: GoogleFonts.actor(),
                    headline1: GoogleFonts.actor(),
                    bodyText2: GoogleFonts.actor(),
                    bodyText1: GoogleFonts.actor(),
                    caption: GoogleFonts.actor(),
                  ),
                  primarySwatch: MaterialColor(
                    App.swatchCode3,
                    {
                      50: const Color(App.swatchCode3).withOpacity(0.1),
                      100: const Color(App.swatchCode3).withOpacity(0.2),
                      200: const Color(App.swatchCode3).withOpacity(0.3),
                      300: const Color(App.swatchCode3).withOpacity(0.4),
                      400: const Color(App.swatchCode3).withOpacity(0.5),
                      500: const Color(App.swatchCode3).withOpacity(0.6),
                      600: const Color(App.swatchCode3).withOpacity(0.7),
                      700: const Color(App.swatchCode3).withOpacity(0.8),
                      800: const Color(App.swatchCode3).withOpacity(0.9),
                      900: const Color(App.swatchCode3).withOpacity(1),
                    },
                  ),
                  brightness: Brightness.dark,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                home: const LaunchScreen(),
              );
            });
          }),
    );
  }
}
