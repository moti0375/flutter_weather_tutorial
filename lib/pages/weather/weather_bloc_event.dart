import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();
  @override
  List<Object> get props => const[];
}

class GetWeather extends WeatherBlocEvent{
  final String cityName;

  GetWeather({this.cityName});
  @override
  List<Object> get props => [cityName];
}

class GetWeatherDetails extends WeatherBlocEvent{
  final String cityName;
  GetWeatherDetails({this.cityName}) ;
  @override
  List<Object> get props => [cityName];
}


