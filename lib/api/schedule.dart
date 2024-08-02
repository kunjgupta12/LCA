import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lca/api/api.dart';
import 'package:lca/api/config.dart';
import 'package:lca/model/schedule/ViewSchedule.dart';
import 'package:lca/model/schedule/CreateSchedule.dart';
import 'package:http/http.dart' as http;
import 'package:lca/screens/bottom_nav/frame_nineteen_container_screen.dart';
import 'package:lca/widgets/utils/showtoast.dart';
class CreateSchedule extends ChangeNotifier{
  
int time=540;
  bool _isLoading = false;
  String? _errorMessage = null;
  bool get isLoading => _isLoading;
  bool _isDisposed = false;

  String? get errorMessage => _errorMessage;
  String createSchedule(myToken,deviceId,Schedule schedule){
   
      notifyListeners();
      _errorMessage = null;

     _isLoading=true;

      try {
     schedule_program(myToken, deviceId, schedule,_isLoading);
     
     
      } catch (e) {
        showToast(e.toString());
      } finally{
   Future.delayed(Duration(minutes: 9)).whenComplete((){
    _isLoading = false;
        notifyListeners();
     
        print(_isLoading);}); 
      }
   return _errorMessage.toString();}  void resetLoadingState() {
    _isLoading = false;
    notifyListeners();
  } 
}



Future<String?> schedule_program(
    String token, int deviceId, Schedule schedule,bool isLoading) async {
  final String apiUrl = '$url/api/v1/schedule/$deviceId';
  final Uri uri = Uri.parse(apiUrl);

  final response = await http.post(uri,
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(schedule.toJson(json)));
  print(json.encode(schedule.toJson(json)));
  print(response.statusCode);
   Future.delayed(Duration(minutes: 9)).whenComplete((){isLoading=true;});

  if (response.statusCode == 201) {
    // If the server returns a 200 OK response, parse the JSON data
    var data = jsonDecode(response.body);
    print('Response data: ${data}');

   // Get.offAll(() => FrameNineteenContainerScreen());
    return response.body.toString();
  } else {
    showToast(response.body);
  }

  // Construct the URL with query parameters
}

Future<List<GetSchedule>> schedule_get(int deviceId, String token) async {
  final String apiUrl = '$schedule$deviceId';
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
    print('Response schedule data: ${data}');

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => GetSchedule.fromJson(job)).toList();
  } else {
    showToast(response.body);
  }

  List jsonResponse = json.decode(response.body);
  return jsonResponse.map((job) => GetSchedule.fromJson(job)).toList();
  // Construct the URL with query parameters
}

Future<List<Schedule>> saved_schedule(deviceId, token) async {
  final String apiUrl = '$schedule$deviceId';
  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => Schedule.fromJson(job)).toList();
  } else {
    print(response.body);
  }

  List jsonResponse = json.decode(response.body);
  return jsonResponse.map((job) => Schedule.fromJson(job)).toList();
}
