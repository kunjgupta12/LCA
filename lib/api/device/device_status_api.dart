import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lca/api/config.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/model/device_status/type4.dart';
import 'package:lca/model/device_status/type1.dart';
import 'package:lca/model/device_status/type2.dart';
import 'package:lca/services/notification.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:http/http.dart' as http;

Future<DeviceStatus?> device_detail(String deviceId) async {
  final String apiUrl = '$url/api/v1/data/${deviceId}/type/4/last';
  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(uri, headers: await getHeaders());
  print(response.body);
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    var data = jsonDecode(response.body);
    print('Response data: ${data}');

    return DeviceStatus.fromJson(data);
  }
}

Future<type2> valve_detail_typeb(String deviceId) async {
  final String apiUrl = '$url/api/v1/data/${deviceId}/type/3/last';
  // Replace with your actual API key

  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(uri, headers: await getHeaders());
  print(response.body);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print('b: ${data}');
    return type2.fromJson(data);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<type1?> valve_detail_type1(String deviceId) async {
  try {
    final String apiUrl = '$url/api/v1/data/$deviceId/type/1/last';

    final Uri uri = Uri.parse(apiUrl);

    final response = await http.get(uri, headers: await getHeaders());
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return type1.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    showToasttoast('Waiting for device to respond');
  }
}

Future<void> resetValve(deviceId,BuildContext context) async {
  final String apiUrl = '$url/api/v1/devices/${deviceId}/reset';
  final Uri uri = Uri.parse(apiUrl);
  Map<String, dynamic> regBody = {'lfr': "1"};
  final response = await http.put(
      body: jsonEncode(regBody), uri, headers: await getHeaders());
  print(response.body);
  if (response.statusCode == 200) {
   
   Navigator.pop(context);
   showToasttoast('Flow Reset Data Send Successfully');
  } else {
    showToasttoast('Flow Reset Data Send UnSuccessfull');
  }
  
}

Future<type2> valve_detail_typea(String deviceId) async {
  final String apiUrl = '$url/api/v1/data/${deviceId}/type/2/last';
  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(uri, headers: await getHeaders());
  print(response.body);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    return type2.fromJson(data);
  } else {
    throw Exception('Failed to load data');
  }
}

DeviceStatus? deviceStatus;
type2? typeb;
type2? typea;
String? devideId;

class DeviceProvider with ChangeNotifier {
  DeviceStatus? get data => deviceStatus;
  type2? get type2a => typea;
  type2? get type3b => typeb;
  DataProvider(String deviceIdget) {
    devideId = deviceIdget;

    _fetchData(deviceIdget);
  }

  Future<void> refreshData() async {
    if (devideId != null) {
      await _fetchData(devideId!);
    }
  }

  Future<void> _fetchData(String deviceId) async {
    try {
      deviceStatus = await device_detail(deviceId);

      typeb = await valve_detail_typeb(deviceId);
      typea = await valve_detail_typea(deviceId);
      notifyListeners();
    } catch (error) {
      print("Error fetching data: $error");
    }
  }
}
