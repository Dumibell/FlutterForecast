# FlutterForecast App ⛅️

![Splash png 17-21-10-020](https://github.com/Dumibell/FlutterForecast/assets/100185602/dc240a5a-7331-40bb-8312-59487816a432)


FlutterForecast is a Flutter-based mobile app that dynamically changes the background image based on the weather and displays the current temperature and weather description.

## Demo

![flutter_weather_app_demo](https://github.com/Dumibell/FlutterForecast/assets/100185602/f1e90daf-301e-4165-aae6-fa6f79e50ef6)

Here is a quick demo of how the app looks and works. Watch the screencast to see the features in action.

## Key Features

- Real-time background image updates based on changing weather conditions
- Display of current temperature and weather description for the user's location
- Display of city name based on the user's location

## Used Open API
- [OpenWeatherMap](https://openweathermap.org/): Real-time weather data for the current location

## Used Packages

- [geolocator](https://pub.dev/packages/geolocator): Location information retrieval
- [http](https://pub.dev/packages/http): Making API calls
- [dotenv](https://pub.dev/packages/flutter_dotenv): Environment variable management
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash): Customized native splash screen
- [loading_animation_widget](https://pub.dev/packages/loading_animation_widget): Loading animation during data retrieval


## Setup

1. Obtain an OpenWeatherMap API Key.
2. Create a `.env` file in the project root directory.
3. Add the API Key to the `.env` file as follows:

```plaintext
WEATHER_API_KEY=Your_OpenWeatherMap_API_Key
```

## Usage

1. When you launch the app for the first time, an introductory screen will be displayed while fetching weather data.
2. Once the data is fully loaded, the weather information for the current location will be displayed.
3. Check the background image and current weather information in the app.
4. Tap the navigation icon at the top of the screen to refresh the current location and weather data.


## Notes

- A stable internet connection is required.
- Location permission must be granted to obtain accurate weather information.

## Contact

For any inquiries or support, please contact me at [choyejee14@gmail.com](mailto:choyejee14@gmail.com).
