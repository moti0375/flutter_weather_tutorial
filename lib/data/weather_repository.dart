import 'dart:math';

import 'package:flutterfakeweather/data/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeatherFromApi(String cityName);
  Future<Weather> getWeatherDetails(String cityName);
}

class AppRepository implements WeatherRepository {
  double cachedTemperature;

  @override
  Future<Weather> getWeatherDetails(String cityName) {
    return Future.delayed(Duration(seconds: 2), () {
      return Weather(
        cityName: cityName,
        temperature: cachedTemperature,
        temperatureFahrenheit: convertToFahrenheit(cachedTemperature),
      );
    });
  }

  @override
  Future<Weather> getWeatherFromApi(String cityName) {
    return Future.delayed(Duration(milliseconds: 2000), () {
      if (Random().nextBool()) {
        throw NetworkError();
      }
      var temperature = 20 + Random().nextInt(15) + Random().nextDouble();
      cachedTemperature = temperature;
      return Weather(
        cityName: cityName,
        temperature: temperature,
        temperatureFahrenheit: convertToFahrenheit(cachedTemperature)
      );
    });
  }

  double convertToFahrenheit(double celsius){
    return celsius * 1.8 + 32;
  }
}

class NetworkError extends Error {}
