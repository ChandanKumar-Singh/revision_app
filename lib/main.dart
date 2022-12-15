import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:revision/FCM/fcmMethods.dart';
import 'package:revision/constants/app.dart';
import 'package:revision/providers/AuthProvider.dart';
import 'package:revision/providers/PaymentsHistoryProvider.dart';
import 'package:revision/providers/ThemeProvider.dart';
import 'package:revision/providers/UserProvider.dart';
import 'package:revision/providers/myIncomeProvider.dart';
import 'package:revision/providers/paidPaymentsProvider.dart';
import 'package:revision/providers/teamCcontroller.dart';
import 'package:revision/screens/auth/launchScreen.dart';
import 'package:revision/screens/pages/Notification/NotificationsPage.dart';

import 'functions.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  await FCM().showNotification(message);
  // debugPrint(message.toString());
  // debugPrint(
  //     "--------------------- On Message ${message.data.toString()} --------------");
  // debugPrint(
  //     "OnMessage: ${message.notification?.title}/${message.notification?.body}");
  // if (message.data['pageInfo'] != null) {
  //   var payLoadTitle =
  //   PayloadTitle.fromJson(jsonDecode(message.data['pageInfo']));
  //   if (payLoadTitle.message!.text
  //       .contains('https://firebasestorage.googleapis.com/')) {
  //     payLoadTitle.message!.text = '📷 Image';
  //   }
  //   await DatabaseHelper.db();
  //   await DatabaseHelper.createItem(jsonEncode(payLoadTitle.toJson()));
  //   var items = await DatabaseHelper.getItems();
  //   debugPrint(items.last);
  // } else {
  // }
  debugPrint('Handling a background message ${message.messageId}');
  debugPrint('Notification Message: ${message.data}');
}

Future<void> onMessageOpenedApp(RemoteMessage message) async {
  await FCM().initFCM();
  Get.to(const NotificationsPage());

  // if (message.data['is_redirect'] == 'Admin') {
  //   Get.to(NotificationPage());
  // } else {
  //   var payLoadTitle =
  //   PayloadTitle.fromJson(jsonDecode(message.data['pageInfo']));
  //   if (payLoadTitle.message!.text
  //       .contains('https://firebasestorage.googleapis.com/')) {
  //     payLoadTitle.message!.text = '📷 Image';
  //   }
  //   await DatabaseHelper.db();
  //   await DatabaseHelper.createItem(jsonEncode(payLoadTitle.toJson()));
  //   Get.to(ChatPage(
  //     student: payLoadTitle.student!,
  //   ));
  // }
  debugPrint(
      "--------------------- onMessageOpenedApp ${message.data.toString()} --------------");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FCM().getToken();
  await FCM().initFCM();
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (initialMessage != null) {
    firebaseMessagingBackgroundHandler(initialMessage);
  }
  FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedApp);

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
        ChangeNotifierProvider(create: (context) => PaidPaymentsProvider()),
        ChangeNotifierProvider(create: (context) => PaymentsHistoryProvider()),
        ChangeNotifierProvider(create: (context) => MyIncomeProvider()),
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
                    headline6: GoogleFonts.aBeeZee(),
                    headline5: GoogleFonts.aBeeZee(),
                    headline4: GoogleFonts.aBeeZee(),
                    headline3: GoogleFonts.aBeeZee(),
                    headline2: GoogleFonts.aBeeZee(),
                    headline1: GoogleFonts.aBeeZee(),
                    bodyText2: GoogleFonts.aBeeZee(),
                    bodyText1: GoogleFonts.aBeeZee(),
                    caption: GoogleFonts.aBeeZee(),
                    // caption: GoogleFonts.actor(),
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
                    headline6: GoogleFonts.aBeeZee(),
                    headline5: GoogleFonts.aBeeZee(),
                    headline4: GoogleFonts.aBeeZee(),
                    headline3: GoogleFonts.aBeeZee(),
                    headline2: GoogleFonts.aBeeZee(),
                    headline1: GoogleFonts.aBeeZee(),
                    bodyText2: GoogleFonts.aBeeZee(),
                    bodyText1: GoogleFonts.aBeeZee(),
                    caption: GoogleFonts.aBeeZee(),
                    // caption: GoogleFonts.actor(),
                  ),
                  primarySwatch: MaterialColor(
                    App.swatchCode2,
                    {
                      50: const Color(App.swatchCode2).withOpacity(0.1),
                      100: const Color(App.swatchCode2).withOpacity(0.2),
                      200: const Color(App.swatchCode2).withOpacity(0.3),
                      300: const Color(App.swatchCode2).withOpacity(0.4),
                      400: const Color(App.swatchCode2).withOpacity(0.5),
                      500: const Color(App.swatchCode2).withOpacity(0.6),
                      600: const Color(App.swatchCode2).withOpacity(0.7),
                      700: const Color(App.swatchCode2).withOpacity(0.8),
                      800: const Color(App.swatchCode2).withOpacity(0.9),
                      900: const Color(App.swatchCode2).withOpacity(1),
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
