import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather_model.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherScreen({
    required this.weatherData,
    Key? key,
  }) : super(key: key);

  // 섭씨 변환 함수
  String getCelsius(double temp) {
    return "${(temp - 273.15).toStringAsFixed(1)}°";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.dstATop),
              image: AssetImage("images/${weatherData.weather[0].main}.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      getCelsius(weatherData.main.temp),
                      style: const TextStyle(
                          fontSize: 44, fontWeight: FontWeight.w600),
                    ),
                    DefaultTextStyle(
                      style: const TextStyle(fontSize: 15),
                      child: Wrap(
                        spacing: 5,
                        children: [
                          Text("H ${getCelsius(weatherData.main.tempMax)}"),
                          Text("L ${getCelsius(weatherData.main.tempMin)}"),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          weatherData.weather[0].description,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Image.network(
                          "https://openweathermap.org/img/wn/${weatherData.weather[0].icon}@2x.png",
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
