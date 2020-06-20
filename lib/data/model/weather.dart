import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final double temperatureFahrenheit;

  Weather({
    @required this.cityName,
    @required this.temperature,
    this.temperatureFahrenheit,
  });

  @override
  List<Object> get props => [cityName, temperature, temperatureFahrenheit];
}
