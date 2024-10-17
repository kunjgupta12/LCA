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
      throw Exception(response.body);
    }
  } catch (e) {
    showToasttoast('Waiting for device to respond');
  }
}

Future<void> resetValve(deviceId, BuildContext context) async {
  final String apiUrl = '$url/api/v1/devices/${deviceId}/flow-reset';
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
Future<void> updatesim(deviceId, BuildContext context,id) async {
  final String apiUrl = '$url/api/v1/devices/${deviceId}/sim/$id';
  final Uri uri = Uri.parse(apiUrl);
  Map<String, dynamic> regBody = {};
  final response = await http.put(
      body: jsonEncode(regBody), uri, headers: await getHeaders());
  print(response.body);
  if (response.statusCode == 200) {
    Navigator.pop(context);
    showToasttoast(' Successfully');
  } else {
  showToasttoast(' Failed');
  }
}
Future<void> updatepump(deviceId, BuildContext context,String prt,String pit) async {
  final String apiUrl = '$url/api/v1/devices/${deviceId}/pump';
  final Uri uri = Uri.parse(apiUrl);
  Map<String, dynamic> regBody = {"pumpInIt":pit,
  "pumpRechargeTime":prt};
  final response = await http.put(
      body: jsonEncode(regBody), uri, headers: await getHeaders());
  print(response.body);
  print(pit);
  print(prt);
  if (response.statusCode == 200) {
    Navigator.pop(context);
    showToasttoast(' Successfully');
  } else {
    showToasttoast(' Failed');
  }
}
Future<void> emergency(deviceId, BuildContext context,bool enable) async {
  final String apiUrl = '$url/api/v1/devices/${deviceId}/emergency/$enable';
  final Uri uri = Uri.parse(apiUrl);
  Map<String, dynamic> regBody = {};
  final response = await http.put(
      body: jsonEncode(regBody), uri, headers: await getHeaders());
  print(response.body);
  if (response.statusCode == 200) {
    Navigator.pop(context);
    showToasttoast(' Successfully');
  } else {
  showToasttoast(' Failed');
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
    throw Exception(response.body);
  }
}

class DeviceProvider with ChangeNotifier {
  DeviceStatus? _deviceStatus;
  type2? _typeA;
  type2? _typeB;
  String? _deviceId;
  type1? _type1;
  DeviceStatus? get deviceStatus => _deviceStatus;
  type2? get type2a => _typeA;
  type2? get type3b => _typeB;
  type1? get type11 => _type1;
  DeviceProvider(String deviceIdd) {
    _deviceId = deviceIdd;
    _fetchData(deviceIdd);
  }

  Future<void> refreshData() async {
    if (_deviceId != null) {
      await _fetchData(_deviceId!);
    }
  }

  Future<void> _fetchData(String deviceId) async {
    try {
      _deviceStatus = await device_detail(deviceId);
      _type1 = await valve_detail_type1(deviceId);

      if (_type1!.c.m[0] != 0) _typeA = await valve_detail_typea(deviceId);
      if (_type1!.c.m[1] != 0) _typeB = await valve_detail_typeb(deviceId);
      notifyListeners();
    } catch (error) {
      // Provide better error handling or logging
      debugPrint("Error fetching data: $error");
    }
  }
}
