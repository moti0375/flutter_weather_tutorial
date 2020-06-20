import 'package:flutter/material.dart';
import 'package:flutterfakeweather/pages/weather/weather_store.dart';
import 'package:provider/provider.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({Key key}) : super(key: key);
  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: _submitText,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter city name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          suffixIcon: Icon(Icons.search)
        ),
      ),
    );
  }

  void _submitText(String text){
    print("_submitText: $text");
    try{
      final store = Provider.of<WeatherStore>(context, listen: false);
      store.getWeather(text);
    } catch(e) {
      print('error: ${e.toString()}');
    }

  }
}
