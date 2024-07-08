import 'package:flutter/material.dart';
import 'package:lca/widgets/theme_helper.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillOnError => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onError,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
  static ButtonStyle get fillOrangeA => ElevatedButton.styleFrom(
        backgroundColor: appTheme.orangeA20001,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );
  static ButtonStyle get fillOrangeATL15 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.orangeA200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      );

  // Gradient button style
  static BoxDecoration get gradientIndigoAToPurpleADecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: appTheme.indigoA7002d,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              3,
            ),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.indigoA100,
            appTheme.purpleA200,
          ],
        ),
      );
  static BoxDecoration get gradientIndigoAToPurpleATL25Decoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: appTheme.indigoA7002d,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              3,
            ),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.indigoA100,
            appTheme.purpleA200,
          ],
        ),
      );

  // Outline button style
  static ButtonStyle get outlineWhiteATL15 => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary.withOpacity(1),
        side: BorderSide(
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
  static ButtonStyle get outlineWhiteATL23 => OutlinedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        side: BorderSide(
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
