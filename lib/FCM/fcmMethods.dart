import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../constants/app.dart';
import '../functions.dart';
import '../screens/pages/Notification/NotificationsPage.dart';

class FCM {
  Future<void> requestPermission() async {
    messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted NotificationSettings permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted NotificationSettings provisional permission');
    } else {
      print(
          'User declined or has not accepted NotificationSettings permission');
    }
  }

  Future<void> getToken() async {
    await messaging.getToken().then((token) {
      deviceToken = token;
      print("My device FCM token is $deviceToken");
    });
  }

  Future<void> initFCM() async {
    await requestPermission();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    // AndroidInitializationSettings(AppInfo.appLogo);
    var iOSInitialize = const DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iOSInitialize,
    );
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    ///select notification action

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      Get.to(const NotificationsPage());
    });
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    // onSelectNotification: (String? payload) async {
    /*
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


    */
    // print('this is init messaging info from FCM');

    ///select notification action

    FirebaseMessaging.onMessage.listen((message) async {
      print("--------------------- On Message --------------");
      print(
          "--------------------- On Message ${message.data.toString()} --------------");
      await showNotification(message);

      // if (message.data['is_redirect'] == 'Admin') {
      //   print('Listening admin-teacher side  messages');
      // } else {
      //   var payLoadTitle =
      //       PayloadTitle.fromJson(jsonDecode(message.data['pageInfo']));
      //   if (payLoadTitle.message!.text
      //       .contains('https://firebasestorage.googleapis.com/')) {
      //     payLoadTitle.message!.text = '📷 Image';
      //   }
      //   Provider.of<FCMNotificationsProvider>(Get.context!, listen: false)
      //       .getPayloadsSQl();
      // }
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
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
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
      App.appname,
      App.appname,
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('.mp3') for custom sound  --- put mp3 file in  main/res/raw/   folder
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      !message.notification!.body!
              .contains('https://firebasestorage.googleapis.com/')
          ? message.notification!.body.toString()
          : "📷 Image",
      notificationDetails,
      // payload: message.data['pageInfo'] ?? message.data['is_redirect'],
    );
    await FirebaseFirestore.instance
        .collection(App.appname)
        .doc('10')
        .collection('notifications')
        .doc(DateTime.now().toString())
        .set({
          'header': 'Hiii , This is header',
          'description': 'THis is description',
          'isRead': false,
          'timestamp': DateTime.now().toString()
        })
        .then((value) => debugPrint('Notification saved to Firestore at id 10'))
        .onError((error, stackTrace) => print(
            ' Could not save the notification on firestore at id 10 ---> $error'));
  }

  // void sendPushMessage(
  //     String? token, String body, String title, String pageInfo) async {
  //   if (body.contains('https://firebasestorage.googleapis.com/')) {
  //     body = '📷 Image';
  //   }
  //   var url = 'https://fcm.googleapis.com/fcm/send';
  //   var cloudMessagingServerKey = AppInfo.cloudMessagingServerKey;
  //   var header = <String, String>{
  //     'Content-Type': 'application/json',
  //     'Authorization': 'key=$cloudMessagingServerKey',
  //   };
  //   var urlBody = <String, dynamic>{
  //     'priority': 'high',
  //
  //     //to go to a page or action {if not mentioned , no action will perform }
  //     'data': <String, dynamic>{
  //       'click-action': 'FLUTTER_NOTIFICATION_CLICK',
  //       'status': 'done',
  //       'pageInfo': pageInfo,
  //       'body': body,
  //       'title': title,
  //     },
  //
  //     //this will show in notification
  //     'notification': <String, dynamic>{
  //       'title': title,
  //       'body': body,
  //       'android_channel_id': AppInfo
  //           .appName, //also add the same name in manifest file channel id
  //     },
  //     'to': token,
  //   };
  //   try {
  //     await http.post(
  //       Uri.parse(url),
  //       headers: header,
  //       body: jsonEncode(urlBody),
  //     );
  //     print('notification sent');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> saveTokenToLaravel(
  //     {required String type,
  //     required String id,
  //     required String fcmToken}) async {
  //   TeacherModel teacher = TeacherModel();
  //   var prefs = await SharedPreferences.getInstance();
  //   teacher = TeacherModel.fromJson(jsonDecode(prefs.getString('teacher')!));
  //   var url = AppInfo.commonUrl + AuthApis.updateDeviceToken;
  //   // print(
  //   //     'FCM token to laravel======   11111111==================================================');
  //
  //   var header = {'Accept': '*/*'};
  //
  //   var body = {"type": type, "id": id, "device_token": fcmToken};
  //   try {
  //     // print('FCM token to laravel Parameters ===$url ---  $body');
  //     var response = await http.post(Uri.parse(url),
  //         headers: header, body: jsonEncode(body));
  //     // print('FCM token to laravel response === ${jsonEncode(response.body)}');
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: 'FCM token to laravel Failed');
  //     print(e);
  //   }
  // }
}
