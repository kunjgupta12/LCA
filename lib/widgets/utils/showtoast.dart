
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lca/widgets/custom_text_style.dart';

void showToast(String? message) {
  if (message == null ||
      message.trim().isEmpty ||
      message.trim().toLowerCase() == 'success') {
    return;
  }
  try {
    Fluttertoast.cancel();
  } catch (e) {}
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor:Colors.white,
      fontSize: 17.0);
}