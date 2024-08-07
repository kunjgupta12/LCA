import 'dart:convert';
import "package:get/get.dart";
import 'package:http/http.dart' as http;
import 'package:lca/api/device/functions.dart';
import 'package:lca/model/complaint/complaint_count_model.dart';
import 'package:lca/model/complaint/complaint_detail_model.dart';
import 'package:lca/model/complaint/complaint_register_model.dart';
import 'package:lca/model/device/device.dart';
import 'package:lca/screens/bottom_nav/frame_nineteen_container_screen.dart';
import 'package:lca/screens/devices_list/device_scroll.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'config.dart';

Future<int> complaint_count_closed(String token) async {
  final String apiUrl = '$complaint_count_api';
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
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    var data = jsonDecode(response.body);
    print('Response data: ${data}');
    final List<dynamic> jsonData = json.decode(response.body);
    final openComplaints = jsonData
        .map((json) => ComplaintCount.fromJson(json))
        .where((complaint) => complaint.statusName == 'Closed')
        .toList();
    return openComplaints[0].count!.toInt();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<int> complaint_count(String token) async {
  final String apiUrl = '$complaint_count_api';
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
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print('Response data: ${data}');
    final List<dynamic> jsonData = json.decode(response.body);
    final openComplaints = jsonData
        .map((json) => ComplaintCount.fromJson(json))
        .where((complaint) => complaint.statusName != 'Closed')
        .toList();
    return openComplaints[0].count!.toInt() + openComplaints[1].count!.toInt();
  } else {
    throw Exception('Failed to load data');
  }

  // Construct the URL with query parameters
}

Future<ComplaintDetail> complaint(String token) async {
  final String apiUrl = '$complaint_get';
  final Uri uri = Uri.parse(apiUrl);

  final response = await http.get(
    uri,
    headers: await getHeaders()
  );
  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON data
    var data = jsonDecode(response.body);
    print('complaint data: ${data}');

    return ComplaintDetail.fromJson(data);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Complaint> register_complaint(
    String token, String device_id, String des, String problem_id) async {
  

  Map<String, dynamic> regBody = {
    "deviceId": device_id,
    "categoryId": problem_id,
    "description": des
  };

  final Uri uri = Uri.parse(complaint_regiaster);

  final response = await http.post(uri,
      headers: await getHeaders(),
      body: jsonEncode(regBody));
  if (response.statusCode == 201) {
    // If the server returns a 200 OK response, parse the JSON data
    var data = jsonDecode(response.body);
     showToasttoast(Complaint.fromJson(data).status!.status.toString());
    Get.offAll(FrameNineteenContainerScreen());
    return Complaint.fromJson(data);
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load data');
  }
}

Future<List<Device>> fetchDevicesissues() async {
  final response = await http.get(
    Uri.parse('${devices}?pageNumber=0&pageSize=100'),
    headers: await getHeaders()
  );
  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body)['content'];
    return jsonResponse.map((json) => Device.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load devices');
  }
}