import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterfakeweather/data/model/weather.dart';
import 'package:flutterfakeweather/pages/weather/weather_store.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeatherDetails extends StatefulWidget {
  final String cityName;
  final WeatherStore store;

  const WeatherDetails({Key key, this.cityName, this.store}) : super(key: key);

  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();

  static Widget create(String cityName, BuildContext context) {
    return Provider<WeatherStore>.value(
      value: Provider.of<WeatherStore>(context),
      child: Consumer<WeatherStore>(
        builder: (c, store, widget) => WeatherDetails(
          cityName: cityName,
          store: store,
        ),
      ),
    );
  }
}

class _WeatherDetailsState extends State<WeatherDetails> {
  NumberFormat naturalFormat = NumberFormat('#,###,###,###.#');


  @override
  void initState() {
    super.initState();
    widget.store.getWeatherDetails(widget.cityName);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Observer(
          builder: (_) {
            switch (widget.store.state) {
              case StoreState.loading:
                return _buildLoading();
              case StoreState.loaded:
                return _buildDetailsWithContent(widget.store.weather);
              default:
                return SizedBox.shrink();
            }
          },
        ),
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

  Widget _buildDetailsWithContent(Weather weather) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '${weather.cityName}',
            style: TextStyle(fontSize: 40),
          ),
          Text(
            '${naturalFormat.format(weather.temperature)}°C',
            style: TextStyle(fontSize: 80),
          ),
          Text(
            '${naturalFormat.format(weather.temperatureFahrenheit)}°F',
            style: TextStyle(fontSize: 80),
          )
        ],
      ),
    );
  }
}
