import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WeatherScreen extends StatefulWidget {
  final CurrentWeatherResponse weatherData;
  final bool isLoading;

  const WeatherScreen({
    required this.weatherData,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // 섭씨 변환 함수
  String getCelsius(double temp) {
    return "${(temp - 273.15).toStringAsFixed(1)}°";
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 45,
              child: Center(
                  child: widget.isLoading
                      ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white, size: 30)
                      : Text(
                          widget.weatherData.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      getCelsius(widget.weatherData.main.temp),
                      style: const TextStyle(
                          fontSize: 44, fontWeight: FontWeight.w600),
                    ),
                    DefaultTextStyle(
                      style: const TextStyle(fontSize: 15),
                      child: Wrap(
                        spacing: 5,
                        children: [
                          Text(
                              "H: ${getCelsius(widget.weatherData.main.tempMax)}"),
                          Text(
                              "L: ${getCelsius(widget.weatherData.main.tempMin)}"),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.weatherData.weather[0].description,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Image.network(
                          "https://openweathermap.org/img/wn/${widget.weatherData.weather[0].icon}@2x.png",
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
