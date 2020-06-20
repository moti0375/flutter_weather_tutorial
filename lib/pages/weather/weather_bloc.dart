import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfakeweather/data/model/weather.dart';
import 'package:flutterfakeweather/data/weather_repository.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_event.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_state.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {

  final WeatherRepository _repository;

  WeatherBloc(this._repository);

  @override
  WeatherBlocState get initialState => WeatherInitial();

  @override
  Stream<WeatherBlocState> mapEventToState(WeatherBlocEvent event) async* {
    if(event is GetWeather){
      yield WeatherLoading();
      yield* _fetchWeatherData(event);
    }

    if(event is GetWeatherDetails){
      yield WeatherLoading();
      yield* _fetchWeatherDetails(event);
    }
  }

  Stream<WeatherBlocState> _fetchWeatherData(GetWeather event) async* {
    try{
      final Weather weather = await _repository.getWeatherFromApi(event.cityName);
      yield WeatherLoaded(weather: weather);
    } on Error{
      yield WeatherError(error: "Could not fetch weather");
    }

  }

  Stream<WeatherBlocState> _fetchWeatherDetails(GetWeatherDetails event) async*{
    yield WeatherLoading();
    Weather weather = await _repository.getWeatherDetails(event.cityName);
    yield WeatherLoaded(weather: weather);
  }
}
