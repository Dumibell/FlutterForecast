import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_weather/firebase_options.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/screens/notification_screen.dart';
import 'package:flutter_weather/screens/weather_screen.dart';
import 'package:flutter_weather/services/api_services.dart';
import 'package:flutter_weather/services/firebase_services.dart';
import 'package:geolocator/geolocator.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Future<WeatherData?> weather;
  double lat = 0;
  double lon = 0;

  @override
  void initState() {
    super.initState();

    // 데이터를 앱이 시작되자마자 받아오기
    weather = _initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/notification_screen": (context) => const NotificationPage()},
      navigatorKey: navigatorKey,
      home: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //데이터가 들어오고 난 후 splash 화면 제거
            FlutterNativeSplash.remove();
          }
          return AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: snapshot.hasData
                ? Scaffold(
                    body: Stack(
                      children: [
                        WeatherScreen(
                          weatherData: snapshot.data!,
                          isLoading: snapshot.connectionState ==
                              ConnectionState.waiting,
                        ),
                        Positioned(
                          left: 30,
                          top: 70,
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: const Offset(13, 13),
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        getCurrentLocation(); // Tab하면 현재 위치 새로 불러오기
                                      },
                                      icon: const Icon(
                                        Icons.assistant_navigation,
                                        size: 30,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          );
        },
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    // 위치권한 받아오기
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }
    try {
      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        // 위도 경도 세팅
        lat = position.latitude;
        lon = position.longitude;
        //현재 위치에 따른 날씨 데이터 받아오기
        weather = ApiService().getCurrentWeather(lat, lon);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<WeatherData?> _initializeApp() async {
    await dotenv.load(fileName: ".env");

    // 현재 위치 정보 업데이트
    await getCurrentLocation();

    return weather;
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const WeatherApp());
}
