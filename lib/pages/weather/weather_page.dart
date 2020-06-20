import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfakeweather/data/model/weather.dart';
import 'package:flutterfakeweather/data/weather_repository.dart';
import 'package:flutterfakeweather/pages/details/weather_details.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc.dart';
import 'package:flutterfakeweather/pages/weather/weather_bloc_state.dart';
import 'package:flutterfakeweather/widgets/TextInputField.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();

  static Widget create(){
    return BlocProvider(
      create: (c) => WeatherBloc(AppRepository()),
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
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: BlocListener<WeatherBloc, WeatherBlocState>(
          listener: (context, state){
            if(state is WeatherError){
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.error.toString()), duration: Duration(seconds: 3),));
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherBlocState>(
            builder: (BuildContext context, WeatherBlocState state) {
              if (state is WeatherLoaded) {
                return buildColumnWithData(context, state.weather);
              }
              if (state is WeatherLoading) {
                return _buildCircularIndicator();
              }
              if (state is WeatherInitial) {
                return buildColumnWithData(context, null);
              }
              if(state is WeatherError){
                return buildColumnWithData(context, null);
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (weather != null)
          Text(
            weather.cityName?? "",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
          ),
        if (weather != null)
          Text(
            '${naturalFormat.format(weather.temperature)}°C',
            style: TextStyle(fontSize: 80),
          ),

        if(weather != null)
          RaisedButton(
            color: Colors.lightBlue[100],
            child: Text('See Details'),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => WeatherDetails.create(weather.cityName, context)));
            },
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
