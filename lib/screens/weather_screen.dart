import 'package:flutter/material.dart';
import 'package:flutter_weather/services/api_services.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<dynamic> weather;

  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    super.initState();

    // getCurrentLocation 함수 호출
    getCurrentLocation();

    // API 호출을 위한 위치 정보를 사용하여 Future를 초기화
    weather = ApiService().getCurrentWeather(latitude, longitude);
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

// 섭씨 변환 함수
  String getCelsius(double temp) {
    return "${(temp - 273.15).toStringAsFixed(1)}°";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String backgroundImage =
              "images/${snapshot.data.weather[0]?.main ?? "clear"}.jpg";

          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.dstATop),
                    image: AssetImage(backgroundImage),
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
                            getCelsius(snapshot.data.main.temp),
                            style: const TextStyle(
                                fontSize: 44, fontWeight: FontWeight.w600),
                          ),
                          DefaultTextStyle(
                            style: const TextStyle(fontSize: 15),
                            child: Wrap(
                              spacing: 5,
                              children: [
                                Text(
                                    "H ${getCelsius(snapshot.data.main.tempMax)}"),
                                Text(
                                    "L ${getCelsius(snapshot.data.main.tempMin)}"),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                snapshot.data.weather[0]?.description,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Image.network(
                                "https://openweathermap.org/img/wn/${snapshot.data.weather[0]?.icon}@2x.png",
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
        return Container(
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         colorFilter: ColorFilter.mode(
          //             Colors.black.withOpacity(0.6), BlendMode.dstATop),
          //         image: const AssetImage("images/Drizzle.jpg"),
          //         fit: BoxFit.cover)),
          child: const Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Text(
                "loading...",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
