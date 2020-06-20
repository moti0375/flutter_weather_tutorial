import 'package:flutterfakeweather/data/model/weather.dart';
import 'package:flutterfakeweather/data/weather_repository.dart';
import 'package:mobx/mobx.dart';

part 'weather_store.g.dart';

enum StoreState { initial, loading, loaded }

class WeatherStore extends _WeatherStore with _$WeatherStore {
  WeatherStore(WeatherRepository repository) : super(repository);
}

abstract class _WeatherStore with Store {
  final WeatherRepository _repository;

  _WeatherStore(this._repository);

  @observable
  ObservableFuture<Weather> _weatherFuture;

  @observable
  Weather weather;

  @observable
  String errorMessage;

  @computed
  StoreState get state {
//    print("state: ${_weatherFuture.status}");
    if (_weatherFuture == null || _weatherFuture.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _weatherFuture.status == FutureStatus.pending ? StoreState.loading : StoreState.loaded;
  }

  @action
  Future<void> getWeather(String cityName) async {
    print("getWeather called: $cityName");
    try {
      errorMessage = null;
      _weatherFuture = ObservableFuture(_repository.getWeatherFromApi(cityName));
      weather = await _weatherFuture;
    } catch (e) {
      print("There was an error ${e.toString()} ");
      errorMessage = "Couldn't fetch weather";
    }
  }

  @action
  Future<void> getWeatherDetails(String cityName) async {
    _weatherFuture = ObservableFuture(_repository.getWeatherDetails(cityName));
    weather = await _weatherFuture;
  }
}
