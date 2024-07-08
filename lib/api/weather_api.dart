import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/weather_model.dart';

Future<Weather> fetchData(String query) async {
  final String apiKey = '28c4784792a8416ba8e101453241605';
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
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load data');
  }

  // Construct the URL with query parameters
}
