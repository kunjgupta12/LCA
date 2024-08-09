import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lca/api/config.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/model/schedule/ViewSchedule.dart';
import 'package:lca/model/schedule/CreateSchedule.dart';
import 'package:http/http.dart' as http;
import 'package:lca/screens/create_schedule/frame_twenty_screen.dart';
import 'package:lca/widgets/utils/messages.dart';
import 'package:lca/widgets/utils/showtoast.dart';

class CreateScheduleProvider extends ChangeNotifier {
  int time = 540;
  bool _isLoading = false;
  String? _errorMessage = null;
  bool get isLoading => _isLoading;
  bool _isDisposed = false;

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
      Future.delayed(Duration(minutes: 9)).whenComplete(() {
        _isLoading = false;
        notifyListeners();

        print(_isLoading);
      });
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
  Future.delayed(Duration(minutes: 9)).whenComplete(() {
    isLoading = true;
  });

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * .2,
        left: MediaQuery.of(context).size.width * .25,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                formattedTime,
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
void _showOverlay(BuildContext context) {
    overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(overlayEntry!);
  }
  if (response.statusCode == 201) {
    var data = jsonDecode(response.body);
       showmessages(context);
                        _showOverlay(context);
    print('Response data: ${data}');
    return response.body.toString();
  } else {
    showToasttoast(response.body);
  }

}

Future<List<GetSchedule>> schedule_get(int deviceId, String token) async {
  final String apiUrl = '$url+/api/v1/schedule/all/"+$deviceId';
  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(
    uri,
    headers: await getHeaders()
  );
  print(response.body);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print('Response schedule data: ${data}');
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((job) => GetSchedule.fromJson(job)).toList();
  } else {
    showToasttoast(response.body);
  }

  List jsonResponse = json.decode(response.body);
  return jsonResponse.map((job) => GetSchedule.fromJson(job)).toList();
}