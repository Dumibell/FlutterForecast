class CurrentWeatherResponse {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  CurrentWeatherResponse({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory CurrentWeatherResponse.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherResponse(
      coord: Coord.fromJson(json['coord']),
      weather: (json['weather'] as List<dynamic>)
          .map((weather) => Weather.fromJson(weather))
          .toList(),
      base: json['base'],
      main: Main.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}

class Coord {
  double lon, lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }
}

class Weather {
  int id;
  String main, description, icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Main {
  double temp, feelsLike, tempMin, tempMax;
  int pressure, humidity;
  int? seaLevel, groundLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    this.seaLevel,
    this.groundLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      groundLevel: json['grnd_level'],
    );
  }
}

class Wind {
  double speed;
  double? gust;
  int deg;

  Wind({
    required this.speed,
    required this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
      gust: json['gust']?.toDouble(),
    );
  }
}

class Clouds {
  int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Sys {
  String? country;
  int sunrise, sunset;

  Sys({this.country, required this.sunrise, required this.sunset});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

class HourlyWeatherResponse {
  String cod;
  int message;
  int cnt;
  List<WeatherItem> list;
  City city;

  HourlyWeatherResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory HourlyWeatherResponse.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherResponse(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: (json['list'] as List<dynamic>)
          .map((item) => WeatherItem.fromJson(item))
          .toList(),
      city: City.fromJson(json['city']),
    );
  }
}

class WeatherItem {
  int dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  String pod;
  Rain? rain;
  String dtTxt;

  WeatherItem({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.pod,
    required this.dtTxt,
    this.rain,
  });

  factory WeatherItem.fromJson(Map<String, dynamic> json) {
    return WeatherItem(
      dt: json['dt'],
      main: Main.fromJson(json['main']),
      weather: (json['weather'] as List<dynamic>)
          .map((item) => Weather.fromJson(item))
          .toList(),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      pod: json['sys']['pod'],
      dtTxt: json['dt_txt'],
    );
  }
}

class Rain {
  double h3;

  Rain({required this.h3});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(h3: json['3h']);
  }
}

class City {
  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}
