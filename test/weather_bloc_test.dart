import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfakeweather/data/model/weather.dart';
import 'package:flutterfakeweather/data/weather_repository.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_event.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_state.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  MockWeatherRepository mockWeatherRepository;
  final weather = Weather(temperature: 20, cityName: 'London');

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
  });

  group('GetWeather', () {
    test('Old way bloc testing GetWeather', () {
      when(mockWeatherRepository.getWeatherFromApi(any)).thenAnswer(
        (_) async => (weather),
      );
      final WeatherBloc bloc = WeatherBloc(mockWeatherRepository);

      bloc.add(GetWeather(cityName: 'London'));

      expectLater(bloc, emitsInOrder([WeatherInitial(), WeatherLoading(), WeatherLoaded(weather: weather)]));
    });

    test('BlocTest package long testing GetWeather', () {
      when(mockWeatherRepository.getWeatherFromApi(any)).thenAnswer(
        (_) async => (weather),
      );
      final WeatherBloc bloc = WeatherBloc(mockWeatherRepository);

      bloc.add(GetWeather(cityName: 'London'));
      emitsExactly(bloc, [
        WeatherInitial(),
        WeatherLoading(),
        isA<WeatherLoaded>(),
      ]);
    });

    blocTest(
      "BlocTest package testing GetWeather'",
      build: () async {
        when(mockWeatherRepository.getWeatherFromApi(any)).thenAnswer(
          (_) async => (weather),
        );
        return WeatherBloc(mockWeatherRepository);
      },
      act: (bloc) => bloc.add(
        GetWeather(cityName: "London"),
      ),
      expect: [WeatherLoading(), isA<WeatherLoaded>()],
    );

    blocTest("BlocTest package testing GetWeather emits [WeatherLoading, WeatherError]",
        build: () async {
          when(mockWeatherRepository.getWeatherFromApi(any)).thenThrow(NetworkError(),
          );
          return WeatherBloc(mockWeatherRepository);
        },
        act: (bloc) => bloc.add(
          GetWeather(cityName: "London"),
        ),
        expect: [WeatherLoading(), WeatherError(error: "Could not fetch weather")],
    );
  });
}
