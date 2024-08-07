import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(BuildContext context, String? message) {
  // Early return if message is null, empty, or 'success'
  if (message == null ||
      message.trim().isEmpty ||
      message.trim().toLowerCase() == 'success') {
    return;
  }

  // Display the styled toast message using AwesomeDialog
  AwesomeDialog(
    context: context,
   
    animType: AnimType.scale,
   
    desc: message,
    btnOkOnPress: () {},
    btnOkColor: Colors.black,
    headerAnimationLoop: false,
    btnOkIcon: Icons.check_circle,
  ).show();
}
void showToasttoast(String? message) {
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