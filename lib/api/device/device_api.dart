import 'dart:async';
import 'dart:convert';
import 'package:lca/api/config.dart';
import 'package:lca/api/token_shared_pref.dart';
import 'package:lca/model/device/device.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../screens/bottom_nav/frame_nineteen_container_screen.dart';
import '../api.dart';
import 'package:get/get.dart';

class Devices {
  Future<void> registerdevice(
      String iemi,
      String title,
      String latitude,
      String longitude,
      bool expansionMode,
      String token,
      String country,
      String pincode,
      String state,
      String fullAdress,
      String valvecount,
      String city) async {
    var regbody = {
      "imei": iemi,
      "title": title,
      "expansionMode": expansionMode,
      "valveCount": valvecount,
      "address": {
        "city": city,
        "pincode": pincode,
        "state": state,
        "country": country,
        "fullAdddress": fullAdress,
        "lat": latitude,
        "long": longitude,
      }
    };
    var response = await http.post(Uri.parse(device_register),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(regbody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 201) {
      showToast('Sucessfully Registered');
     
       DeviceDataService().deviceslist(token);
      Get.offAll(FrameNineteenContainerScreen());
    } else if(response.statusCode==400){
      showToast('Name and IEMI are same');}
  }

  Future<void> updatedevice(
      String id,
      String iemi,
      String title,
      String latitude,
      String longitude,
      bool expansionMode,
      String token,
      String country,
      String pincode,
      String state,
      String fullAdress,
      String valvecount,
      String city) async {
    var regbody = {
      "imei": iemi,
      "title": title,
      "expansionMode": expansionMode,
      "valveCount": valvecount,
      "address": {
        "city": city,
        "pincode": pincode,
        "state": state,
        "country": country,
        "fullAdddress": fullAdress,
        "lat": latitude,
        "long": longitude,
      }
    };
    print(regbody);
    var response = await http.put(Uri.parse("$device_register$id"),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(regbody));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      Get.offAll(FrameNineteenContainerScreen());
    } else
      showToast(jsonResponse['valveCount']);
  }
}

Future<void> deletedevice(String id) async {
  print("Fetching users...");
  final prefss = await SharedPreferences.getInstance();
  String token = prefss.getString('token').toString();
  try {
    var response = await http.delete(
      Uri.parse('${get_device}/$id'),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Get.offAll(FrameNineteenContainerScreen());
     
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print(e);
  } 
}

Future<Device> fetchdevice(int id) async {
var token=  SharedPrefManager.getAccessToken();
  try {
    var response = await http.get(
      Uri.parse('$get_device/$id'),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Device.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print(e);
  }
  return Device.fromJson(jsonDecode(''));
}
