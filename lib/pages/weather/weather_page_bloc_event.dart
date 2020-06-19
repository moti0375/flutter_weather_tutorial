import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class WeatherPageBlocEvent extends Equatable {
  const WeatherPageBlocEvent();
  @override
  List<Object> get props => const[];
}

class GetWeather extends WeatherPageBlocEvent{
  final String cityName;

  GetWeather({this.cityName});
  @override
  List<Object> get props => [cityName];
}


