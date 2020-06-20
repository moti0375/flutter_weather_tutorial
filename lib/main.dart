import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterfakeweather/pages/weather/weather_page.dart';

void main() {
  EquatableConfig.stringify = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WeatherPage.create(),
    );
  }
}
