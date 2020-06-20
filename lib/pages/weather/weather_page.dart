import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfakeweather/data/model/weather.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_state.dart';
import 'package:flutterfakeweather/widgets/TextInputField.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();

  static Widget create(){
    return BlocProvider(
      create: (c) => WeatherBloc(),
      child: WeatherPage(),
    );
  }
}

class _WeatherPageState extends State<WeatherPage> {
  NumberFormat naturalFormat = NumberFormat('#,###,###,###.#');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: BlocProvider(
        create: (c) => WeatherBloc(),
        child: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: BlocListener<WeatherBloc, WeatherBlocState>(
            listener: (context, state){
              if(state is WeatherLoaded){
                print("WeatherLoaded: ${state.weather.temperature}");
              }
            },
            child: BlocBuilder<WeatherBloc, WeatherBlocState>(
              builder: (BuildContext context, WeatherBlocState state) {
                if (state is WeatherLoaded) {
                  return buildColumnWithData(state.weather);
                }
                if (state is WeatherLoading) {
                  return _buildCircularIndicator();
                }
                if (state is WeatherInitialState) {
                  return buildColumnWithData(null);
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (weather != null)
          Text(
            weather.cityName,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
          ),
        if (weather != null)
          Text(
            '${naturalFormat.format(weather.temperature)}°C',
            style: TextStyle(fontSize: 80),
          ),
        TextInputField()
      ],
    );
  }

  Widget _buildCircularIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
