
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lca/api/api.dart';
import 'package:lca/api/config.dart';
import 'package:lca/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:lca/screens/bottom_nav/frame_nineteen_container_screen.dart';
import 'package:lca/screens/profile/profile.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';/*
class UserEditProvider extends ChangeNotifier {
  List<User> _user = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<User> get devices => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;*/

  Future<void> update_user(String token, String emailController,
      String? passwordController,
      String firstName,
      String lastname,
      String mobile,
      String country,
      String pincode,
      String state,
      String fullAdress,
      String lat,
      String long,
      String city) async {
   // _isLoading = true;
   // _errorMessage = null;
   // notifyListeners();
  final String apiUrl = user_update;
  // Replace with your actual API key
      Map<String, dynamic> regBody = {
        "email": emailController,
        "passwordText": passwordController,
        'firstName': firstName,
        "lastName": lastname,
        "phoneNo": mobile,
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
  final Uri uri = Uri.parse(apiUrl);

 
    try {
       final response = await http.put(
    uri,
    headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(regBody)
  );
  print(response.body);
      if (response.statusCode == 200) {
         var data = jsonDecode(response.body);
    print('User Updated data: ${data}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user', jsonEncode(data));
User.fromJson(data);
    String?   jsonString = prefs.getString('user');
  Future<User> fetchUserData() async {
    final response = json.decode(jsonString.toString());
    return User.fromJson(response);
  }

 showToast('Updated');
                 Get.offAll(FrameNineteenContainerScreen());
      } else {

       // _errorMessage = 'Failed to load devices';
      }
    } catch (e) {
      showToast(e.toString());
    //  _errorMessage = 'Failed to load devices: $e';
    } finally {
    //  _isLoading = false;
    ///  notifyListeners();
    }
  }
