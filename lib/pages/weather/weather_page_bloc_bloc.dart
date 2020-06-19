import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfakeweather/model/weather.dart';
import 'package:flutterfakeweather/pages/weather/weather_page_bloc_event.dart';
import 'package:flutterfakeweather/pages/weather/weather_page_bloc_state.dart';

class WeatherPageBlocBloc extends Bloc<WeatherPageBlocEvent, WeatherPageBlocState> {
  @override
  WeatherPageBlocState get initialState => WeatherInitialState();

  @override
  Stream<WeatherPageBlocState> mapEventToState(WeatherPageBlocEvent event) async* {
    if(event is GetWeather){
      yield* _fetchWeatherData(event);
    }
  }

  Stream<WeatherPageBlocState> _fetchWeatherData(GetWeather event) async* {
    yield WeatherLoading();
    final Weather weather = await _getWeatherDataFromApi(event.cityName);
    yield WeatherLoaded(weather: weather);
  }


  Future<Weather> _getWeatherDataFromApi(String cityName) async {
    return Future.delayed(Duration(milliseconds: 5000), (){
      return Weather(cityName: cityName, temperature: 20 + Random().nextInt(15) + Random().nextDouble());
    });
  }
}
