import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_event.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_state.dart';
import 'package:intl/intl.dart';

class WeatherDetails extends StatefulWidget {
  final String cityName;

  const WeatherDetails({Key key, this.cityName}) : super(key: key);

  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();

  static Widget create(String cityName, BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<WeatherBloc>(context),
      child: WeatherDetails(cityName: cityName,),
    );
  }
}

class _WeatherDetailsState extends State<WeatherDetails> {
  NumberFormat naturalFormat = NumberFormat('#,###,###,###.#');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context)..add(GetWeatherDetails(cityName: widget.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: BlocBuilder<WeatherBloc, WeatherBlocState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return _buildLoading();
          }
          if (state is WeatherLoaded) {
            return _buildDetailsWithContent(state);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildDetailsWithContent(WeatherLoaded state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '${state.weather.cityName}',
            style: TextStyle(fontSize: 40),
          ),
          Text(
            '${naturalFormat.format(state.weather.temperature)}°C',
            style: TextStyle(fontSize: 80),
          ),
          Text(
            '${naturalFormat.format(state.weather.temperatureFahrenheit)}°F',
            style: TextStyle(fontSize: 80),
          )
        ],
      ),
    );
  }
}
