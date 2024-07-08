import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RectangularFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  RectangularFloatingActionButton(
      {required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // Standard height for FloatingActionButton
      width: 140.0, // Custom width to make it rectangular
      child: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        child: child,
      ),
    );
  }
}
