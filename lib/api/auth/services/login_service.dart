import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:lca/api/api.dart';
import 'package:lca/api/config.dart';
import 'package:lca/api/token_shared_pref.dart';
import 'package:lca/model/auth/login_model.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
Future<void> login_api(var reqBody,var myToken,_errorMessage,_isLoading)  async{
 var response = await http.post(Uri.parse(login),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(reqBody));

        var jsonResponse = jsonDecode(response.body);
        LoginModel loginModel = LoginModel.fromJson(jsonResponse);
       
        if (jsonResponse['token'].toString() != 'null') {

_errorMessage=null;
          myToken = jsonResponse['token'];
           SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user', jsonEncode(jsonResponse['data']['user']));
           SharedPreferences preff = await SharedPreferences.getInstance();
          preff.setString('image', loginModel.data!.user!.imgUrl.toString());
_isLoading=false;
          showToast('Logged In with ${loginModel.data!.user!.email}');
          print(prefs.getString('user'));
          DeviceDataService().fetchData();
           FirebaseMessaging messaging = FirebaseMessaging.instance;
          String? token = await messaging.getToken();

          if (token != null) {
            await messaging.subscribeToTopic('${loginModel.data!.user!.id}-');
            print("Subscribed to topic: ${loginModel.data!.user!.id}");
          }
       
           LoginModel.fromJson(jsonResponse);
        } else {
          showToast(jsonResponse['message']);
        }
      
}