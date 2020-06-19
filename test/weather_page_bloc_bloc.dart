import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class WeatherPageBlocBloc extends Bloc<WeatherPageBlocEvent, WeatherPageBlocState> {
  @override
  WeatherPageBlocState get initialState => InitialWeatherPageBlocState();

  @override
  Stream<WeatherPageBlocState> mapEventToState(
    WeatherPageBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
