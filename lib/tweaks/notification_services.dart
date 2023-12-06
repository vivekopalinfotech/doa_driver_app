import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../firebase_options.dart';

var globalCheckNavitaion = 0;
late RemoteMessage? initialMessage1;


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // print("Handling a background message");
}

// class PushNotificationService {
//
//
//
//   // Future<void> setupInteractedMessage() async {
//   //   await Firebase.initializeApp();
//   //
//   //   print("ejvkkhxoilchxoidcxikbcixkjbcd");
//   //
//   //
//   //
//   //   FirebaseMessaging.instance.getInitialMessage().then((value) => {
//   //         if (value != null)
//   //           {
//   //             print("ContentAvailable : " + value.contentAvailable.toString()),
//   //             globalCheckNavitaion = 1
//   //           }
//   //       });
//   //
//   //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//   //
//   //     print("push notification");
//   //
//   //     Navigator.push(navigatorKey.currentContext!,
//   //         MaterialPageRoute(builder: (_) =>  HomeScreen()));
//   //   });
//   //
//   //   await enableIOSNotifications();
//   //   await registerNotificationListeners();
//   // }
//
//
//   Future<void> setupInteractedMessage(BuildContext context) async {
//
//     await Firebase.initializeApp(
//       name: 'mystery-shopping-ba0b5',
//       options: DefaultFirebaseOptions.currentPlatform,
//     ).whenComplete(() => {
//       print("Complete")
//     });
//     print("Hello 1");
//
//     // NewArrivalProductIddata = "";
//
//     // Firebasedata =  "";
//     // // Get any messages which caused the application to open from
//     // // a terminated state.
//     // // RemoteMessage? initialMessage =
//     // // await FirebaseMessaging.instance.getInitialMessage();
//     //
//     // // If the message also contains a data property with a "type" of "chat",
//     // // navigate to a chat screen
//     // // if (initialMessage != null) {
//     // //   _handleMessage(initialMessage);
//     // // }
//     //
//     // // Also handle any interaction when the app is in the background via a
//     // // Stream listener
//     //
//     // FirebaseMessaging messaging = FirebaseMessaging.instance;
//     // AndroidNotificationChannel channel;
//     //
//     // NotificationSettings settings = await messaging.requestPermission(
//     //   alert: true,
//     //   announcement: false,
//     //   badge: true,
//     //   carPlay: false,
//     //   criticalAlert: false,
//     //   provisional: false,
//     //   sound: true,
//     // );
//     //
//     //
//     // await FirebaseMessaging.instance
//     //     .setForegroundNotificationPresentationOptions(
//     //   alert: true, // Required to display a heads up notification
//     //   badge: true,
//     //   sound: true,
//     // );
//     //
//     // FirebaseMessaging.instance.getInitialMessage().then((value) => {
//     //   if (value != null)
//     //     {
//     //       print("ContentAvailable : " + value.contentAvailable.toString()),
//     //       globalCheckNavitaion = 1
//     //     }
//     // });
//     //
//     //
//     //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     //
//     //     Navigator.push(context, MaterialPageRoute(builder: (context) => SimilarProductDetails()));
//     //   });
//     try {
//       // Wait for Firebase to initialize and set `_initialized` state to true
//       await Firebase.initializeApp(
//         name: 'mystery-shopping-ba0b5',
//         options: DefaultFirebaseOptions.currentPlatform,
//       ).whenComplete(() => {
//         print("Complete")
//       });
//
//       FirebaseMessaging messaging = FirebaseMessaging.instance;
//       AndroidNotificationChannel channel;
//
//       NotificationSettings settings = await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//
//       print('User granted permission: ${settings.authorizationStatus}');
//
//       var fcmToken = await messaging.getToken();
//       print('Messaging Token: $fcmToken');
//
//       await FirebaseMessaging.instance
//           .setForegroundNotificationPresentationOptions(
//         alert: true, // Required to display a heads up notification
//         badge: true,
//         sound: true,
//       );
//
//       channel = const AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'High Importance Notifications', // title
//         description:
//         'This channel is used for important notifications.', // description
//         importance: Importance.max,
//       );
//
//       final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//       var initializationSettingsAndroid =
//       const AndroidInitializationSettings("mipmap/ic_launcher");
//
//       var initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
//
//       flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//           ?.createNotificationChannel(channel);
//
//
//
//       RemoteMessage? initialMessage =
//       await FirebaseMessaging.instance.getInitialMessage();
//
//       if (initialMessage != null) {
//         print("initialMessage");
//         _handleMessage(initialMessage , context);
//       }
//
//       // inline function
//
//       // Also handle any interaction when the app is in the background via a
//       // Stream listener
//       FirebaseMessaging.onMessageOpenedApp.listen((msg) {
//         print("onMessageOpenedApp");
//         _handleMessage(msg , context);
//       });
//     } catch (e) {
//       //   // Set `_error` state to true if Firebase initialization fails
//       //   // setState(() {
//       //   //   _error = true;
//       //   // });
//     }
//
//     await enableIOSNotifications();
//     await registerNotificationListeners(context);
//
//
//
//
//   }
//
//
//   registerNotificationListeners(BuildContext context1) async {
//     AndroidNotificationChannel channel = androidNotificationChannel();
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     var androidSettings =
//     const AndroidInitializationSettings('@drawable/ic_android_2_1');
//     const DarwinInitializationSettings iOSSettings =
//     DarwinInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );
//     var initSetttings =
//     InitializationSettings(android: androidSettings, iOS: iOSSettings);
//     flutterLocalNotificationsPlugin.initialize(initSetttings,
//         onDidReceiveNotificationResponse: (NotificationResponse details) async {
//
//
//           if(initialMessage1?.data['type'] =="PRODUCT_DETAIL" ) {
//             print("hello click push selected ");
//             print("${initialMessage1?.data['itemId']}");
//
//             // NewArrivalProductId =  initialMessage1?.data['itemId'];
//
//             print("Firebase data" + Firebasedata);
//
//             // Navigator.push(context1, MaterialPageRoute(builder: (context1) => SimilarProductDetails()));
//
//
//           } else {
//             // Navigator.push(context1,
//             //     MaterialPageRoute(builder: (_) =>  HomeScreen()));
//           }
//
//
//         });
//
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
//       print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//       print(message);
//
//       initialMessage1 = message;
//
//
//       RemoteNotification? notification = message!.notification;
//       AndroidNotification? android = message.notification?.android;
//
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               icon: android.smallIcon,
//               playSound: true,
//             ),
//           ),
//         );
//       }
//
//       if (initialMessage1 != null) {
//         print("initialMessage");
//         print(initialMessage1?.data);
//         _handleMessage(initialMessage1 , context1);
//       }else{
//         print("no initialMessage");
//       }
//
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       print("onMessageOpenedApp: $message");
//       Navigator.push(context1, MaterialPageRoute(builder: (context1) => PaymentDashboard()));
//     });
//
//
//
//
//   }
//
//   enableIOSNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   androidNotificationChannel() => const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//
//     importance: Importance.max,
//   );
//
//
//   Future<void> invokeTimer() async {
//     Timer(const Duration(seconds: 3), () async {
//       Navigator.push(navigatorKey.currentContext!,
//           MaterialPageRoute(builder: (_) =>  PaymentDashboard()));
//     });
//   }
//
//
//
//   void _handleMessage(RemoteMessage? initialMessage1 , BuildContext context) {
//     print("jdgewgj");
//     print(initialMessage1?.data);
//
//     Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentDashboard()));
//
//
//     if (initialMessage1?.data['type'] == "PRODUCT_DETAIL") {
//       print("hello click push");
//
//
//
//
//       print("hello click push selected ");
//       print("${initialMessage1?.data['itemId']}");
//
//       // NewArrivalProductId =  initialMessage1?.data['itemId'];
//       //
//       //
//       // NewArrivalProductIddata = NewArrivalProductId;
//
//
//       print("Firebase data" + Firebasedata);
//
//       // Navigator.push(context, MaterialPageRoute(builder: (context) => SimilarProductDetails()));
//
//
//     } else {
//       // Navigator.push(context,
//       //     MaterialPageRoute(builder: (_) =>  HomeScreen()));
//     }
//
//
//     // Navigator.push(context, MaterialPageRoute(builder: (context1) => SimilarProductDetails()));
//
//
//     // Navigator.push(navigatorKey.currentContext!,
//     //     MaterialPageRoute(builder: (_) =>  SimilarProductDetails()));
//
//   }
//
// }



class PushNotificationService {


// It is assumed that all messages contain a data field with the key 'type'
/*
  Future<void> setupInteractedMessage(context) async {
    await Firebase.initializeApp(
      name: 'vkind-cbe0c',
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    AndroidNotificationChannel channel;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    var fcmToken = await messaging.getToken();
    print('Messaging Token: $fcmToken');

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    // var initializationSettingsAndroid =
    // const AndroidInitializationSettings("mipmap/ic_launcher");
    //
    // var initializationSettings =
    // InitializationSettings(android: initializationSettingsAndroid);
    //
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);
    //
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //     AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);



    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      // Get.toNamed(NOTIFICATIONS_ROUTE);

      print("Hello done");

      log("notification type  " +message.data.toString());

      if (message.data['type'] == 'Admin') {
        // SurveyInvitationId = message.data['itemId'];
        // Navigator.push(context, MaterialPageRoute(builder: (context) => AdminReviewComments()));
      } else if(message.data['type'] == 'payment') {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentDashboard()));
      } else {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
      }


      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
    });

    enableIOSNotifications();
    await registerNotificationListeners();



  }
  Future<void> registerNotificationListeners() async {
    final AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@drawable/ic_launcher');
    const DarwinInitializationSettings iOSSettings =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {},
    );
// onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      // homeController.getHomeData(
      //   withLoading: false,
      // );
      // log(message, key: 'firebase_message');
      final RemoteNotification? notification = message!.notification;
      final AndroidNotification? android = message.notification?.android;
// If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
            ),
          ),
        );
      }
    });
  }
  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
        'This channel is used for important notifications.', // description
        importance: Importance.max,
      );
*/

}





