import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lca/api/device/device_list.dart';
import 'package:lca/api/config.dart';
import 'package:lca/model/auth/login_model.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<void> loginApi(Map<String, dynamic> reqBody, ValueNotifier<String?> myToken, ValueNotifier<String?> errorMessage, ValueNotifier<bool> isLoading,BuildContext context
) async {
  isLoading.value = true;

  try {
    final response = await http.post(
      Uri.parse(login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final LoginModel loginModel = LoginModel.fromJson(jsonResponse);

      if (jsonResponse['token'] != null) {
        errorMessage.value = null;
        myToken.value = jsonResponse['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(jsonResponse['data']['user']));
        await prefs.setString('image', loginModel.data?.user?.imgUrl ?? '');
        await prefs.setString('token', myToken.value!);

        showToast(context,'Logged In with ${loginModel.data?.user?.email ?? ''}');
        await DeviceDataService().fetchData(jsonResponse['token']);

        final FirebaseMessaging messaging = FirebaseMessaging.instance;
        final token = await messaging.getToken();

        if (token != null) {
          await messaging.subscribeToTopic('${loginModel.data?.user?.id}-');
          log("Subscribed to topic: ${loginModel.data?.user?.id}");
        }
      } else {
        errorMessage.value = jsonResponse['message'];
        showToast(context,jsonResponse['message']);
      }
    } else {
      final jsonResponse = jsonDecode(response.body);
      errorMessage.value = jsonResponse['message'] ?? 'An error occurred';
      showToast(context,errorMessage.value!);
    }
  } catch (e) {
    errorMessage.value = 'An error occurred: $e';
    showToast(context,errorMessage.value!);
  } finally {
    isLoading.value = false;
  }
}
