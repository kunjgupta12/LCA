import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lca/api/config.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/api/token_shared_pref.dart';
import 'package:lca/model/device/device.dart';
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
