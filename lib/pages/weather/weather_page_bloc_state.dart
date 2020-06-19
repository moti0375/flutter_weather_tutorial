import 'package:equatable/equatable.dart';
import 'package:flutterfakeweather/model/weather.dart';

abstract class WeatherPageBlocState extends Equatable {
  const WeatherPageBlocState();
  @override
  List<Object> get props => const[];
}

class WeatherInitialState extends WeatherPageBlocState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherPageBlocState{}
class WeatherLoaded extends WeatherPageBlocState{
  final Weather weather;

  WeatherLoaded({this.weather});

  @override
  List<Object> get props => [weather];
}

