import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_weather/firebase_options.dart';
import 'package:flutter_weather/screens/home_screen.dart';
import 'package:flutter_weather/screens/notification_screen.dart';
import 'package:flutter_weather/services/firebase_services.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {"/notification_screen": (context) => const NotificationPage()},
        navigatorKey: navigatorKey,
        home: const HomeScreen());
  }
}

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  runApp(const WeatherApp());
}
