
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/weather.dart';

Future<WeatherData> fetchWeatherForecast() async {
  final String apiKey = '2aj7QwO7BAn76KjXQ6V8Ww5QMcPefSJU';
  final String location = 'new york';

  final Uri uri = Uri.parse('https://api.tomorrow.io/v4/weather/forecast?location=$location&apikey=$apiKey');

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print("Forcast "+WeatherData.fromJson(data).location.name);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Failed to fetch weather forecast');
    }
  } catch (e) {
    throw Exception('Failed to fetch weather forecast');
  }
}

