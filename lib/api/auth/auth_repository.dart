
import 'package:flutter/material.dart';
import 'package:lca/api/auth/services/login_service.dart';
import 'package:lca/model/auth/login_model.dart';
import 'package:lca/widgets/utils/showtoast.dart';
class RegisterNotifier extends ChangeNotifier {
  var myToken;
  bool _isLoading = false;
  String? _errorMessage = null;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Future<LoginModel?> loginUser(
      String emailController, String passwordController) async {
    if (emailController.isNotEmpty && passwordController.isNotEmpty) {
      var reqBody = {
        "username": emailController,
        "password": passwordController
      };
      notifyListeners();
      _errorMessage = null;
     _isLoading=true;
      try {
       login_api(reqBody, myToken,_errorMessage,_isLoading);
      } catch (e) {
        showToast(e.toString());
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
    return null;
  }
}