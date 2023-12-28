import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_weather/models/weather_model.dart';
import 'package:flutter_weather/screens/weather_screen.dart';
import 'package:flutter_weather/services/api_services.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    //현재 위치에 따른 날씨 데이터 받아오기
    currentWeather = getCurrentLocation()
        .then((value) => ApiService().getCurrentWeather(lat, lon));
  }

  late Future<CurrentWeatherResponse?> currentWeather;
  double lat = 0;
  double lon = 0;

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
        currentWeather = ApiService().getCurrentWeather(lat, lon);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: currentWeather,
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
                        AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          child: Container(
                            key: Key(snapshot.data!.weather[0].main),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.1),
                                      BlendMode.srcOver),
                                  image: AssetImage(
                                      "images/${snapshot.data!.weather[0].main}.jpg"),
                                  fit: BoxFit.cover),
                            ),
                            child: WeatherScreen(
                              weatherData: snapshot.data!,
                              isLoading: snapshot.connectionState ==
                                  ConnectionState.waiting,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          top: 70,
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              children: [
                                IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      getCurrentLocation(); // Tab하면 현재 위치 새로 불러오기
                                    },
                                    icon: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 7,
                                            offset: const Offset(13, 13),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.assistant_navigation,
                                        size: 30,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container());
      },
    );
  }
}
