import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/screens/weather_screen.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return const WeatherScreen();
  }
}

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MaterialApp(
    home: WeatherApp(),
  ));
}
