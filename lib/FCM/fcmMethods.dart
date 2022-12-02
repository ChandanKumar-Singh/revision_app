import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cq_school/FCM/SqlDbHelper.dart';
import 'package:cq_school/Models/FCMNotificationPayload/payloadModel.dart';
import 'package:cq_school/Models/TeacherModel.dart';
import 'package:cq_school/notificationsFromFCM.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiManager/AuthApis.dart';
import '../AppGlobalConstants/AppInfo.dart';
import 'package:http/http.dart' as http;

import '../Providers/FCMNotifications/FCMNotificationsProvider.dart';
import '../Screens/DrawerPages/NotificationPage.dart';
import '../Screens/DrawerPages/chatPage/ChatScreen.dart';

enum tokenUpdateUserType { student, teacher }

class FCM {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var deviceToken;
  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      deviceToken = token;
      print("My device FCM token is $deviceToken");
    });
    await saveTokenToDB(deviceToken)
        .then((value) => print('FCM token saved for this user'));
  }

  Future<void> saveTokenToDB(String token) async {
    var prefs = await SharedPreferences.getInstance();
    TeacherModel teacher =
        TeacherModel.fromJson(jsonDecode(prefs.getString('teacher')!));

    await FirebaseFirestore.instance
        .collection('CQ-SCHOOL')
        .doc('admin')
        .collection('teachers')
        .doc('conversations')
        .collection('tokens')
        .doc(teacher.data!.userId!)
        .set({'token': token})
        .then((value) => saveTokenToLaravel(
            type: 'teacher', id: teacher.data!.userId!, fcmToken: token))
        .then((value) => print('Token saved to both DB'));
  }

  Future<void> initInfo() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    // AndroidInitializationSettings(AppInfo.appLogo);
    var iOSInitialize = const IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iOSInitialize,
    );

    ///select notification action
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      try {
        if (payload != null && payload.isNotEmpty) {
          print('This is payload from notification $payload');
          if (payload == 'Admin') {
            Get.to(NotificationPage());
          } else {
            var payLoadTitle = PayloadTitle.fromJson(jsonDecode(payload));
            if (payLoadTitle.message!.text
                .contains('https://firebasestorage.googleapis.com/')) {
              payLoadTitle.message!.text = '📷 Image';
            }
            // print(
            //     'Payload message after editing 0000000000000000000 ${payLoadTitle.message!.text}');
            // print(
            //     'Payload message after editing 1111111111111111111 ${payLoadTitle.message!.text.contains('https://firebasestorage.googleapis.com/')}');
            Get.to(ChatPage(
              student: payLoadTitle.student!,
            ));
            //
            // Provider.of<FCMNotificationsProvider>(Get.context!, listen: false)
            //     .addPayloadToLocal(payLoadTitle);
            // Provider.of<FCMNotificationsProvider>(Get.context!, listen: false)
            //     .getPayloads();
          }
        } else {}
      } catch (e) {}
      return;
    });

    // print('this is init messaging info from FCM');

    ///select notification action

    FirebaseMessaging.onMessage.listen((message) async {
      // print("--------------------- On Message --------------");
      // print(
      //     "--------------------- On Message ${message.data.toString()} --------------");

      if (message.data['is_redirect'] == 'Admin') {
        print('Listening admin-teacher side  messages');
      } else {
        var payLoadTitle =
            PayloadTitle.fromJson(jsonDecode(message.data['pageInfo']));
        if (payLoadTitle.message!.text
            .contains('https://firebasestorage.googleapis.com/')) {
          payLoadTitle.message!.text = '📷 Image';
        }
        Provider.of<FCMNotificationsProvider>(Get.context!, listen: false)
            .getPayloadsSQl();
      }
      // print(
      //     "OnMessage: ${message.notification?.title}/${message.notification?.body}");
      // var payLoadTitle =
      //     PayloadTitle.fromJson(jsonDecode(message.data['pageInfo']));
      // if (payLoadTitle.message!.text
      //     .contains('https://firebasestorage.googleapis.com/')) {
      //   payLoadTitle.message!.text = '📷 Image';
      // }
      // print(
      //     'Payload message after editing 0000000000000000000 ${payLoadTitle.message!.text}');
      // print(
      //     'Payload message after editing 1111111111111111111 ${payLoadTitle.message!.text.contains('https://firebasestorage.googleapis.com/')}');

      // Provider.of<FCMNotificationsProvider>(Get.context!, listen: false)
      //     .addPayloadToLocal(payLoadTitle);
      // Provider.of<FCMNotificationsProvider>(Get.context!, listen: false)
      //     .addPayloadToLocalSql(payLoadTitle);
      // Provider.of<FCMNotificationsProvider>(Get.context!, listen: false)
      //     .getPayloads();

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          !message.notification!.body!
                  .contains('https://firebasestorage.googleapis.com/')
              ? message.notification!.body.toString()
              : "📷 Image",
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true);
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        AppInfo.appName,
        AppInfo.appName,
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
        playSound: true,
        // sound: RawResourceAndroidNotificationSound('.mp3') for custom sound  --- put mp3 file in  main/res/raw/   folder
      );
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: IOSNotificationDetails(),
      );
      await flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          !message.notification!.body!
                  .contains('https://firebasestorage.googleapis.com/')
              ? message.notification!.body.toString()
              : "📷 Image",
          notificationDetails,
          payload: message.data['pageInfo'] ?? message.data['is_redirect']);
    });
  }

  void sendPushMessage(
      String? token, String body, String title, String pageInfo) async {
    if (body.contains('https://firebasestorage.googleapis.com/')) {
      body = '📷 Image';
    }
    var url = 'https://fcm.googleapis.com/fcm/send';
    var cloudMessagingServerKey = AppInfo.cloudMessagingServerKey;
    var header = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$cloudMessagingServerKey',
    };
    var urlBody = <String, dynamic>{
      'priority': 'high',

      //to go to a page or action {if not mentioned , no action will perform }
      'data': <String, dynamic>{
        'click-action': 'FLUTTER_NOTIFICATION_CLICK',
        'status': 'done',
        'pageInfo': pageInfo,
        'body': body,
        'title': title,
      },

      //this will show in notification
      'notification': <String, dynamic>{
        'title': title,
        'body': body,
        'android_channel_id': AppInfo
            .appName, //also add the same name in manifest file channel id
      },
      'to': token,
    };
    try {
      await http.post(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(urlBody),
      );
      print('notification sent');
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveTokenToLaravel(
      {required String type,
      required String id,
      required String fcmToken}) async {
    TeacherModel teacher = TeacherModel();
    var prefs = await SharedPreferences.getInstance();
    teacher = TeacherModel.fromJson(jsonDecode(prefs.getString('teacher')!));
    var url = AppInfo.commonUrl + AuthApis.updateDeviceToken;
    // print(
    //     'FCM token to laravel======   11111111==================================================');

    var header = {'Accept': '*/*'};

    var body = {"type": type, "id": id, "device_token": fcmToken};
    try {
      // print('FCM token to laravel Parameters ===$url ---  $body');
      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(body));
      // print('FCM token to laravel response === ${jsonEncode(response.body)}');
    } catch (e) {
      Fluttertoast.showToast(msg: 'FCM token to laravel Failed');
      print(e);
    }
  }
}
