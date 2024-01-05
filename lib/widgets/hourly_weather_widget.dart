import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather_model.dart';

class HourlyWeatherWidget extends StatefulWidget {
  final Future<HourlyWeatherResponse?> weatherData;

  const HourlyWeatherWidget({super.key, required this.weatherData});

  @override
  State<HourlyWeatherWidget> createState() => _HourlyWeatherWidgetState();
}

class _HourlyWeatherWidgetState extends State<HourlyWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.weatherData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  var weather = snapshot.data!.list[index];
                  return const Text("1123");
                },
                itemCount: snapshot.data!.list.length,
                scrollDirection: Axis.horizontal,
              ))
            ],
          );
        }
        return Container();
      },
    );
  }
}
