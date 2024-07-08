import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lca/model/device.dart';
import 'package:lca/model/login_model.dart';
import 'package:lca/model/register_model.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/bottom_nav/frame_nineteen_container_screen.dart';
import '../widgets/custom_text_style.dart';
import '../widgets/utils/notification.dart';
import 'config.dart';

class Api {
  var myToken;

  Future<void> registerUser(
      String emailController,
      String passwordController,
      String firstName,
      String lastname,
      String mobile,
      String country,
      String pincode,
      String state,
      String fullAdress,
      double lat,
      double long,
      String city,String fcm_token) async {
    if (emailController.isNotEmpty && passwordController.isNotEmpty) {
      Map<String, dynamic> regBody = {
        "email": emailController,
        "passwordText": passwordController,
        'firstName': firstName,
        "lastName": lastname,
        "phoneNo": mobile,
        "fcm_token":fcm_token,
        "address": {
          "city": city,
          "pincode": pincode,
          "state": state,
          "country": country,
          "fullAddress": fullAdress,
          "lat": lat,
          "long": long
        }
      };
      try {
        var response = await http.post(Uri.parse(registration),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody));

        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['success']);
        print(response.statusCode);

        if (response.statusCode == 201) {
         
          loginUser(emailController, passwordController);
     showToast('Succesfully Registered with userId ');
        } else if(response.statusCode== 400) {
          showToast(response.body);}
      } catch (error) {
        showToast(error.toString());
      }
    }
    return showToast('Try again later');
  }

  Future<LoginModel?> loginUser(
      String emailController, String passwordController) async {
    if (emailController.isNotEmpty && passwordController.isNotEmpty) {
      var reqBody = {
        "username": emailController,
        "password": passwordController
      };
      try {
        var response = await http.post(Uri.parse(login),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(reqBody));

        var jsonResponse = jsonDecode(response.body);
        LoginModel loginModel = LoginModel.fromJson(jsonResponse);
        loginModel.token;
        print(loginModel.token);
        if (jsonResponse['token'].toString() != 'null') {
          myToken = jsonResponse['token'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user', jsonEncode(jsonResponse['data']['user']));
          prefs.setString('token', myToken);
           SharedPreferences preff = await SharedPreferences.getInstance();
        preff.setString('image', loginModel.data!.user!.imgUrl.toString());
       
          showToast('Logged In with ${loginModel.data!.user!.email}');
          print(prefs.getString('user'));
           DeviceDataService().fetchData();
          //   print(list);
        } else {
          showToast(jsonResponse['message']);
        }
      } catch (e) {
        showToast(e.toString());
      }
    }
    return null;
  }
}

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

    SharedPreferences prefss = await SharedPreferences.getInstance();
    token = prefss.getString('token');
    print(token);
    //  print(cachedData);
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

void comingsoonpop(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => Container(
            child: AlertDialog(
              content: Text(
                'Coming Soon....',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.w800),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    'Ok',
                    style: CustomTextStyles.titleMediumGreen600,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ));
}

