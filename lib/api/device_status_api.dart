import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lca/api/config.dart';
import 'package:lca/model/device_status.dart';
import 'package:lca/model/type2.dart';
import 'package:lca/model/type3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<DeviceStatus> device_detail(String deviceId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token').toString();
  final String apiUrl = '$url/api/v1/data/${deviceId}/type/4/last';
  // Replace with your actual API key

  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    var data = jsonDecode(response.body);
    print('Response data: ${data}');

    return DeviceStatus.fromJson(data);
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load data');
  }
}

Future<type3> valve_detail_typeb(String deviceId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token').toString();
  final String apiUrl = '$url/api/v1/data/${deviceId}/type/3/last';
  // Replace with your actual API key

  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    var data = jsonDecode(response.body);
    print('b: ${data}');
    //sharedPreferences.setString('durationb',type3.);
    return type3.fromJson(data);
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load data');
  }
}

Future<type2> valve_detail_typea(String deviceId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String token = sharedPreferences.getString('token').toString();
  final String apiUrl = '$url/api/v1/data/${deviceId}/type/2/last';
  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
     var data = jsonDecode(response.body);
    print('a ${data}');
     return type2.fromJson(data);
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load data');
  }
}
DeviceStatus? deviceStatus;
type3? typeb;
type2? typea;
String? devideId;
class DeviceProvider with ChangeNotifier {
  Timer? _timer;


  DeviceStatus? get data => deviceStatus;
type2? get type2a=>typea;
type3? get type3b=>typeb;

  DataProvider(String deviceIdget) {
    devideId = deviceIdget;

    _fetchData(deviceIdget);
  }

  Future<void> _fetchData(String deviceId) async {
    try {
      deviceStatus = await device_detail(deviceId);
      deviceStatus!.c!.p == 'B'
          ? typeb = await valve_detail_typeb(deviceId)
          : typea=await valve_detail_typea(deviceId);
      notifyListeners();
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
