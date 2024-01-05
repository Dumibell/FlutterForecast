import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/utils/common.dart';

class CurrentWeatherWidget extends StatefulWidget {
  final CurrentWeatherResponse weatherData;

  const CurrentWeatherWidget({
    required this.weatherData,
    Key? key,
  }) : super(key: key);

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    getCelsius(widget.weatherData.main.temp),
                    style: const TextStyle(
                        fontSize: 50, fontWeight: FontWeight.w600),
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
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DefaultTextStyle(
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                child: Wrap(
                  spacing: 5,
                  children: [
                    Text("H: ${getCelsius(widget.weatherData.main.tempMax)}"),
                    Text("L: ${getCelsius(widget.weatherData.main.tempMin)}"),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 1,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
