import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lca/screens/bottom_nav/frame_nineteen_container_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lca/api/config.dart';
import 'package:lca/model/device/device.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:get/get.dart';
 Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    return {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
class DeviceService {
 

  Future<void> registerDevice(Map<String, dynamic> regBody, String token,BuildContext context) async {
    var response = await http.post(
      Uri.parse(device_register),
      headers: await getHeaders(),
      body: jsonEncode(regBody),
    );

    _handleResponse(context,response, successMessage: 'Successfully Registered');
  }

  Future<void> updateDevice(String id, Map<String, dynamic> regBody, String token,BuildContext context) async {
    var response = await http.put(
      Uri.parse('$device_register$id'),
      headers: await getHeaders(),
      body: jsonEncode(regBody),
    );

    _handleResponse(context,response, successMessage: 'Device Updated');
  }

  Future<void> deleteDevice(String id,BuildContext context) async {
    var response = await http.delete(
      Uri.parse('$get_device/$id'),
      headers: await getHeaders(),
    );

    _handleResponse(context,response, successMessage: 'Device Deleted');
  }

  Future<Device> fetchDevice(int id) async {
    var response = await http.get(
      Uri.parse('$get_device/$id'),
      headers: await getHeaders(),
    );

    if (response.statusCode == 200) {
      return Device.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load device data');
    }
  }

  void _handleResponse(BuildContext context,
    http.Response response, {String? successMessage}) {
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (successMessage != null) showToast(context,successMessage);
      Get.offAll(FrameNineteenContainerScreen());
    } else if (response.statusCode == 400) {
      showToast(context,jsonResponse['message'] ?? 'Bad Request');
    } else {
      showToast(context,jsonResponse['message'] ?? 'Something went wrong');
    }
  }
}
