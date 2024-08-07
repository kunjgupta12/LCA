import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lca/api/config.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:lca/model/schedule/ViewSchedule.dart';
import 'package:lca/model/schedule/CreateSchedule.dart';

class CreateScheduleProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> createSchedule(
      String myToken, int deviceId, Schedule schedule) async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await schedule_program(myToken, deviceId, schedule);
      if (response == null) {
        _errorMessage = 'An error occurred';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      // Delay resetting the loading state by 9 minutes
      Future.delayed(Duration(minutes: 9), () {
        _isLoading = false;
        notifyListeners();
      });
    }
  }

  void resetLoadingState() {
    _isLoading = false;
    notifyListeners();
  }
}

Future<String?> schedule_program(
    String token, int deviceId, Schedule schedule) async {
  final String apiUrl = '$url/api/v1/schedule/$deviceId';
  final Uri uri = Uri.parse(apiUrl);

  try {
    final response = await http.post(
      uri,
      headers: await getHeaders(),
      body: json.encode(schedule),
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print('Response data: $data');
      return response.body;
    } else {
      showToasttoast('Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    showToasttoast('Request failed: $e');
    return null;
  }
}

Future<List<GetSchedule>> schedule_get(int deviceId, String token) async {
  final String apiUrl = '$schedule$deviceId';
  final Uri uri = Uri.parse(apiUrl);

  try {
    final response = await http.get(
      uri,
      headers: await getHeaders(),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('Response schedule data: $data');

      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => GetSchedule.fromJson(job)).toList();
    } else {
      showToasttoast('Error: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    showToasttoast('Request failed: $e');
    return [];
  }
}
