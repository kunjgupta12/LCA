import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lca/api/token_shared_pref.dart';
import 'package:lca/model/device/device.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/bottom_nav/frame_nineteen_container_screen.dart';
import 'config.dart';




class DeviceDataService {
  Future<List<dynamic>> fetchData() async {
    String? token;

    SharedPreferences prefss = await SharedPreferences.getInstance();
    token = prefss.getString('token');
    print(token);
    //  print(cachedData);
    return await fetchAndCacheData(token.toString());
  }

  Future<ApiResponse> fetchDatafordevices() async {
    String? token;
    token = SharedPrefManager.getAccessToken().toString();
    return await deviceslist(token.toString());
  }

  Future<ApiResponse> deviceslist(String token) async {
    try {
      var response = await http.get(
        Uri.parse(devices),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('device', response.body.length);

        var data = jsonDecode(response.body);
        final prefss = await SharedPreferences.getInstance();
        prefss.setString('devicelist', jsonEncode(data));

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
      var response = await http.get(
        Uri.parse(devices),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('device', response.body.length);

        print(prefs);
        Get.off(FrameNineteenContainerScreen(
          devices: response.body.length,
        ));
        response.body.isNotEmpty;
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      //showToast(e.toString());
      return [];
    }
  }
}
