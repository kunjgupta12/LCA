import 'dart:async';
import 'dart:convert';
import 'package:lca/api/config.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/model/schedule/ViewSchedule.dart';
import 'package:http/http.dart' as http;
import 'package:lca/widgets/utils/showtoast.dart';

Future<List<GetSchedule>> schedule_get(int deviceId, String token) async {
  final String apiUrl = '$url/api/v1/schedule/all/$deviceId';
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