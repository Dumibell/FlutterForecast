import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/models/weather_model.dart';
import "package:http/http.dart" as http;

class ApiService {
  final String baseUrl = dotenv.get("WEATHER_BASE_URL");
  final String apiKey = dotenv.get("WEATHER_API_KEY");

// 현재 날씨
  Future<CurrentWeatherResponse> getCurrentWeather(
      double lat, double lon) async {
    final url = Uri.parse("$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      CurrentWeatherResponse weatherData =
          CurrentWeatherResponse.fromJson(jsonData);
      return weatherData;
    } else {
      throw Exception("Failed to get weather data");
    }
  }

// 3시간 간격의 날씨
  Future<HourlyWeatherResponse> getHourlyWeather(double lat, double lon) async {
    final url = Uri.parse("$baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      HourlyWeatherResponse weatherData =
          HourlyWeatherResponse.fromJson(jsonData);

      return weatherData;
    } else {
      throw Exception("Failed to get weather data");
    }
  }
}
