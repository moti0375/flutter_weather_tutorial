import 'package:equatable/equatable.dart';
import 'package:flutterfakeweather/data/model/weather.dart';

abstract class WeatherBlocState extends Equatable {
  const WeatherBlocState();
  @override
  List<Object> get props => const[];
}

class WeatherInitialState extends WeatherBlocState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherBlocState{}
class WeatherLoaded extends WeatherBlocState{
  final Weather weather;

  WeatherLoaded({this.weather});

  @override
  List<Object> get props => [weather];
}

