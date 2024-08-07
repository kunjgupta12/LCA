import 'package:flutter/material.dart';
import 'package:lca/api/auth/services/login_service.dart';
import 'package:lca/model/auth/login_model.dart';
import 'package:lca/widgets/utils/showtoast.dart';

class LoginNotifier extends ChangeNotifier {
  String? myToken;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<LoginModel?> loginUser(String emailController, String passwordController,BuildContext context) async {
    if (emailController.isNotEmpty && passwordController.isNotEmpty) {
      var reqBody = {
        "username": emailController,
        "password": passwordController
      };

      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      try {
        await loginApi(reqBody, ValueNotifier<String?>(myToken), ValueNotifier<String?>(_errorMessage), ValueNotifier<bool>(_isLoading),context);
      } catch (e) {
        showToast(context,e.toString());
        _errorMessage = e.toString();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
    return null;
  }
   void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
