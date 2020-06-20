import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfakeweather/data/model/weather.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_event.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_state.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  @override
  WeatherBlocState get initialState => WeatherInitialState();

  @override
  Stream<WeatherBlocState> mapEventToState(WeatherBlocEvent event) async* {
    if(event is GetWeather){
      yield* _fetchWeatherData(event);
    }
  }

  Stream<WeatherBlocState> _fetchWeatherData(GetWeather event) async* {
    yield WeatherLoading();
    final Weather weather = await _getWeatherDataFromApi(event.cityName);
    yield WeatherLoaded(weather: weather);
  }


  Future<Weather> _getWeatherDataFromApi(String cityName) async {
    return Future.delayed(Duration(milliseconds: 2000), (){
      return Weather(cityName: cityName, temperature: 20 + Random().nextInt(15) + Random().nextDouble());
    });
  }
}
