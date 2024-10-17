import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lca/api/config.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/model/auth/user_model.dart';
import 'package:lca/model/device/device.dart';
import 'package:lca/screens/auth/login.dart';
import 'package:lca/screens/devices_list/device_scroll.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../screens/bottom_nav/frame_nineteen_container_screen.dart';

class DeviceDataService {
  Future<List<dynamic>> fetchData(token) async {
    return await fetchAndCacheData(token.toString());
  }

  Future<ApiResponse> deviceslist(String token) async {
    try {
      var response =
          await http.get(Uri.parse(devices), headers: await getHeaders());
      print(response.body);
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      return ApiResponse.fromJson(json.decode(e.toString()));
    }
  }

  Future<List<dynamic>> fetchAndCacheData(String token) async {
    try {
      var response =
          await http.get(Uri.parse(devices), headers: await getHeaders());

      if (response.statusCode == 200) {
        Get.off(FrameNineteenContainerScreen(
          devices: response.body.length,
        ));
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      return [];
    }
  }
}

Future<ApiResponse> fetchDevices(int pageNumber) async {
  final response = await http.get(
      Uri.parse('${devices}?pageNumber=$pageNumber&pageSize=10'),
      headers: await getHeaders());

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    UserModel user = json.decode(jsonString.toString());

    showToasttoast('Token Expired');
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();

    if (token != null) {
      await messaging.unsubscribeFromTopic('${user.id}-');
      //  print("UnSubscribed to topic: ${userData.id}");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(() => FrameThirteenScreen());
  } else {
    throw Exception('Failed to load devices');
  }
  return ApiResponse.fromJson(response.headers);
}
