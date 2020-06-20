import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_event.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_state.dart';
import 'package:bloc_test/bloc_test.dart';

class MockWeatherBloc extends MockBloc<WeatherBlocEvent, WeatherBlocState> implements WeatherBloc {}

void main() {
  MockWeatherBloc mockBloc;

  setUp(() {
    mockBloc = MockWeatherBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  test('MockBloc test', () {
    whenListen(mockBloc, Stream.fromIterable([WeatherInitial(), WeatherLoading()]));

    expectLater(
      mockBloc,
      emitsInOrder([WeatherInitial(), WeatherLoading()]),
    );
  });
}
