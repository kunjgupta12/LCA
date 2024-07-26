
  import 'dart:convert';

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
      String fullAdress,
      double lat,
      double long,
      String city,
      String fcm_token) async {
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
          RegisterNotifier().loginUser(emailController, passwordController);
          showToast('Succesfully Registered with userId ');
        } else if (response.statusCode == 400) {
          showToast(jsonResponse['message']);
        }
      } catch (error) {
        showToast(error.toString());
      }
    }
  }

