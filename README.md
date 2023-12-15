# FlutterForecast App ⛅️

FlutterForecast is a Flutter-based mobile app that dynamically changes the background image based on the weather and displays the current temperature and weather description.

## Key Features

- Real-time background image updates based on changing weather conditions
- Display of current temperature and weather description for the user's location
- Display of city name based on the user's location

## Used Packages

- [geolocator](https://pub.dev/packages/geolocator): Location information retrieval
- [http](https://pub.dev/packages/http): OpenWeatherMap API calls
- [dotenv](https://pub.dev/packages/flutter_dotenv): Environment variable management

## Setup

1. Obtain an OpenWeatherMap API Key.
2. Create a `.env` file in the project root directory.
3. Add the API Key to the `.env` file as follows:

```plaintext
WEATHER_API_KEY=Your_OpenWeatherMap_API_Key
```

## Usage

1. When you run the app, the weather information for the current location will be displayed.
2. Check the background image and current weather information in the app.

## Notes

- A stable internet connection is required.
- Location permission must be granted to obtain accurate weather information.


