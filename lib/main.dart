import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_weather/firebase_options.dart';
import 'package:flutter_weather/screens/home_screen.dart';
import 'package:flutter_weather/screens/notification_screen.dart';
import 'package:flutter_weather/screens/test_screen.dart';
import 'package:flutter_weather/services/firebase_services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  createState() => _WeatherAppState();
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("---------백그라운드 수신처리중---------");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications(); // 셋팅 메소드
  showFlutterNotification(message); // 로컬노티
}

/// fcm 전경 처리 - 로컬 알림 보이기
void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    // 알림이 있고, 안드로이드인경우(아이폰은 별도 설정 필요 x)
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
      payload: message.data["screen"],
    );
  }
}

// 필요 변수
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false; // 셋팅여부 판단 flag

/// 셋팅 메소드
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: onTabNotification,
    onDidReceiveBackgroundNotificationResponse: onTabNotification,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // iOS foreground notification 권한
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // IOS background 권한 체킹 , 요청
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  getToken();

  // 셋팅flag 설정
  isFlutterLocalNotificationsInitialized = true;
}

// nofitication 클릭시 화면 이동하는 함수
void onTabNotification(NotificationResponse details) async {
  if (details.payload != null) {
    print('onDidReceiveNotificationResponse - payload: ${details.payload}');
    navigatorKey.currentState?.pushNamed("/${details.payload}");
  }
}

// 토큰 가져오는 함수
Future<void> getToken() async {
  // ios
  String? token;
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    token = await FirebaseMessaging.instance.getAPNSToken();
  }
  // aos
  else {
    token = await FirebaseMessaging.instance.getToken();
  }
  print("Token: $token");
}

void handleMessage(RemoteMessage? message) {
  // navigate to new screen when message is received and user tabs notification
  if (message != null) {
    navigatorKey.currentState?.pushNamed(
      "/${message.data["screen"]}",
      arguments: message,
    );
  }
}

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await setupFlutterNotifications();

  runApp(const WeatherApp());
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  void initState() {
    super.initState();
    // foreground 수신처리
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    // background 수신처리
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    // 앱 꺼졌을 때
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "title",
      initialRoute: "/",
      routes: {
        "/notification_screen": (context) => const NotificationPage(),
      },
      navigatorKey: navigatorKey,
      home: const TestScreen(),
    );
  }
}
