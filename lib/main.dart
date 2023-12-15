import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/screens/intro_screen.dart';
import 'package:flutter_weather/screens/weather_screen.dart';
import 'package:flutter_weather/services/api_services.dart';
import 'package:geolocator/geolocator.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Future<dynamic> weather;
  double latitude = 0; // 설정해야 할 좌표 값
  double longitude = 0; // 설정해야 할 좌표 값

  @override
  void initState() {
    super.initState();
    weather = _initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return WeatherScreen(weatherData: snapshot.data);
          } else {
            return const IntroScreen();
          }
        },
      ),
    );
  }

  Future<void> getCurrentLocation() async {
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
        // 현재 위치 정보 업데이트
        latitude = position.latitude;
        longitude = position.longitude;
        weather = ApiService().getCurrentWeather(latitude, longitude);
      });
      print("latitude: $latitude, longitude: $longitude");
    } catch (e) {
      print(e);
    }
  }

  Future<WeatherData> _initializeApp() async {
    await dotenv.load(fileName: ".env");
    // 여기에서 필요한 초기화 작업 및 데이터 로딩 작업 수행

    // API 호출
    getCurrentLocation();
    return ApiService().getCurrentWeather(latitude, longitude);
  }
}

void main() async {
  runApp(const WeatherApp());
}
