import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lca/api/auth/auth_repository.dart';
import 'package:lca/api/config.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:http/http.dart' as http;

Future<void> registerUser(
    String emailController,
    String passwordController,
    String firstName,
    String lastname,
    String mobile,
    String country,
    String pincode,
    String state,
    String fullAddress,
    double lat,
    double long,
    String city,
    String fcm_token,
    LoginNotifier registerNotifier,
    BuildContext context) async {
  if (emailController.isNotEmpty && passwordController.isNotEmpty) {
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
        "fullAddress": fullAddress,
        "lat": lat,
        "long": long
      }
    };

    registerNotifier.setLoading(true);

    try {
      var response = await http.post(
        Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      log(response.body.toString());
      if (response.statusCode == 201) {
        await registerNotifier.loginUser(
            emailController, passwordController, context);
        showToast(context, 'Successfully Registered');
      } else {
        showToast(context, jsonResponse['message'] ?? 'Registration failed');
      }
    } catch (error) {
      showToast(context, error.toString());
    } finally {
      registerNotifier.setLoading(false);
    }
  } else {
    showToast(context, 'Please fill in all fields');
  }
}
