import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/weather/weather_model.dart';

Future<Weather> fetchData(String query) async {
  final String? apiKey = dotenv.env['WEATHER_API_KEY'];
  final String apiUrl =
      'http://api.weatherapi.com/v1/forecast.json?q=$query&key=$apiKey';
  // Replace with your actual API key

  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    var data = jsonDecode(response.body);
    print('Response data: ${data}');

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('weather', jsonEncode(data));

    return Weather.fromJson(data);
  } else {throw Exception('Failed to load data');
  }

  // Construct the URL with query parameters
}
