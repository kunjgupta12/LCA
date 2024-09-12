
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lca/api/config.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/widgets/utils/showtoast.dart';

import '../../model/schedule/CreateSchedule.dart';
import '../../widgets/utils/messages.dart';

class CreateScheduleProvider extends ChangeNotifier {
 
  bool _isLoading = false;
  String? _errorMessage = null;
  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;
  String createSchedule(myToken, deviceId, Schedule schedule,BuildContext context) {
    notifyListeners();
    _errorMessage = null;

    _isLoading = true;

    try {
      schedule_program(myToken, deviceId, schedule, _isLoading,context);
    } catch (e) {
      showToasttoast(e.toString());
    } finally {
     /* Future.delayed(Duration(minutes: 9)).whenComplete(() {
        _isLoading = false;
        notifyListeners();

        print(_isLoading);
      });*/
    }
    return _errorMessage.toString();
  }

  void resetLoadingState() {
    _isLoading = false;
    notifyListeners();
  }
}

Future<String?> schedule_program(
    String token, int deviceId, Schedule schedule, bool isLoading,BuildContext context) async {
  final String apiUrl = '$url/api/v1/schedule/$deviceId';
  final Uri uri = Uri.parse(apiUrl);

  final response = await http.post(uri,
      headers:await getHeaders(),
      body: json.encode(schedule.toJson(json)));
  print(json.encode(schedule.toJson(json)));
  log(response.statusCode);
 
 var data = jsonDecode(response.body);
  if (response.statusCode == 201) {
   
       showmessages(context);
      /*  Future.delayed(Duration(minutes: 9)).whenComplete(() {
    isLoading = true;
  });             */
    print('Response data: ${data}');
    return response.body.toString();
  } else {
    
    showToasttoast(data['message']);
  }

}
