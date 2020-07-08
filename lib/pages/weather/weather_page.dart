import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterfakeweather/data/model/weather.dart';
import 'package:flutterfakeweather/data/weather_repository.dart';
import 'package:flutterfakeweather/pages/details/weather_details.dart';
import 'package:flutterfakeweather/pages/weather/weather_store.dart';
import 'package:flutterfakeweather/widgets/TextInputField.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatefulWidget {
  final WeatherStore store;

  const WeatherPage({Key key, this.store}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();

  static Widget create() {
    return Provider<WeatherStore>(
      create: (_) => WeatherStore(AppRepository()),
      dispose: (_, store) => store,
      child: Consumer<WeatherStore>(
        builder: (_, store, __) => WeatherPage(store: store),
      ),
    );
  }
}

class _WeatherPageState extends State<WeatherPage> {
  NumberFormat naturalFormat = NumberFormat('#,###,###,###.#');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<ReactionDisposer> _snackBarDisposer;

  @override
  void initState() {
    super.initState();
    var disposer = reaction(
      (_) => widget.store.errorMessage,
      (String message) => _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      ),
    );

    _snackBarDisposer ??= [disposer];
  }

  @override
  void dispose() {
    super.dispose();
//    _snackBarDisposer.forEach((disposer) => disposer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Observer(
            builder: (_) {
              print('builder: ');
              switch (widget.store.state) {
                case StoreState.initial:
                  return buildColumnWithData(context, null);
                case StoreState.loading:
                  return _buildCircularIndicator();
                case StoreState.loaded:
                  return buildColumnWithData(context, widget.store.weather);
                default:
                  return buildColumnWithData(context, null);
              }
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
            weather.cityName ?? "",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
          ),
        if (weather != null)
          Text(
            '${naturalFormat.format(weather.temperature)}°C',
            style: TextStyle(fontSize: 80),
          ),
        if (weather != null)
          RaisedButton(
            color: Colors.lightBlue[100],
            child: Text('See Details'),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => WeatherDetails.create(weather.cityName, context))),
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
