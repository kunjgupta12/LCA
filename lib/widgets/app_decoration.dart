import 'package:flutter/material.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/size_utils.dart';

class AppDecoration {
  static BoxDecoration get gradientTealToErrorContainer => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.94, -0.33),
          end: Alignment(0.94, 0.33),
          colors: [Color(0xFF6CCDB0), Color(0xFF39BCCD)],
        ),

        /*  gradient: LinearGradient(
          begin: Alignment(0.75, 0.35),
          end: Alignment(0.43, 0.93),
          colors: [
            Color.fromRGBO(108, 205, 176, .41),
            Color.fromRGBO(58, 188, 206, .95)
          ],
        ),*/
      );
  // Bg decorations
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray100.withOpacity(0.59),
      );
  static BoxDecoration get fillOnError => BoxDecoration(
        color: theme.colorScheme.onError.withOpacity(1),
      );
  static BoxDecoration get fillGrayF => BoxDecoration(
        color: appTheme.gray100F4,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
// Outline decorations
  static BoxDecoration get outlinePrimary => BoxDecoration();
  static BoxDecoration get outlinePrimary1 => BoxDecoration(
        color: appTheme.blueGray100C1,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );
  static BoxDecoration get outlinePrimary2 => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );
  static BoxDecoration get outlinePrimary3 => BoxDecoration(
        color: theme.colorScheme.onError,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );
  static BoxDecoration get outlinePrimary4 => BoxDecoration(
        color: appTheme.gray50,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );
  static BoxDecoration get outlinePrimary5 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.7),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );

  static BoxDecoration get bg => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.93, 0.25),
          end: Alignment(0.04, 1),
          colors: [
            appTheme.lightGreenA700,
            appTheme.green800Aa,
          ],
        ),
      );

  // Ffd decorations
  static BoxDecoration get ffd => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.05, 0.15),
          end: Alignment(1, 0.72),
          colors: [
            appTheme.deepPurple900,
            appTheme.purple5007f,
          ],
        ),
      );

  // Fill decorations
  static BoxDecoration get fillAmber => BoxDecoration(
        color: appTheme.amber100,
      );
  static BoxDecoration get fillDeepOrangeA => BoxDecoration(
        color: appTheme.deepOrangeA10063,
      );

  static BoxDecoration get fillGreen => BoxDecoration(
        color: appTheme.green20030,
      );
  static BoxDecoration get fillOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(0.87),
      );
  static BoxDecoration get fillOnPrimaryContainer1 => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: appTheme.whiteA700,
      );

  // Gradient decorations
  static BoxDecoration get gradientBlueToIndigoAEd => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.5, 0),
          end: Alignment(0.5, 1),
          colors: [
            appTheme.blue900,
            appTheme.indigoA200Ed,
          ],
        ),
      );
  static BoxDecoration get gradientGrayBToGreenB => BoxDecoration(
        border: Border.all(
          color: appTheme.gray70001,
          width: 1,
          strokeAlign: strokeAlignOutside,
        ),
        gradient: LinearGradient(
          begin: Alignment(0.96, 0.06),
          end: Alignment(0.07, 0.87),
          colors: [
            appTheme.gray200B7,
            appTheme.green300B7,
          ],
        ),
      );
  static BoxDecoration get gradientOnPrimaryToPurpleF => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(1, 0.29),
          end: Alignment(0, 0.77),
          colors: [
            theme.colorScheme.onPrimary,
            appTheme.purple5007f,
          ],
        ),
      );
  static BoxDecoration get gradientRedToRed => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 0.79),
          end: Alignment(1.11, 0.23),
          colors: [
            appTheme.red600,
            appTheme.red30075,
          ],
        ),
      );

  // Ko decorations
  static BoxDecoration get ko => BoxDecoration(
        border: Border.all(
          color: appTheme.blueGray50,
          width: 1,
        ),
        gradient: LinearGradient(
          begin: Alignment(0.96, 0.06),
          end: Alignment(0.07, 0.87),
          colors: [
            appTheme.gray200B7,
            appTheme.green300B7,
          ],
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration();
  static BoxDecoration get outlineBlack90001 => BoxDecoration(
        color: appTheme.blueGray100C1,
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack900011 => BoxDecoration(
        color: appTheme.tealA100B2,
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack900012 => BoxDecoration(
        color: appTheme.purpleA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack900013 => BoxDecoration();
  static BoxDecoration get outlineBlack900014 => BoxDecoration(
        color: appTheme.blueGray100,
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack900015 => BoxDecoration(
        color: appTheme.whiteA70001.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack900016 => BoxDecoration(
        color: appTheme.orangeA20002,
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: appTheme.whiteA70001,
        border: Border.all(
          color: appTheme.blueGray50,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.gray90011,
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              2,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineOnPrimaryContainer => BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        border: Border.all(
          color: theme.colorScheme.onPrimaryContainer,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black90001.withOpacity(0.16),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              -1,
            ),
          ),
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder23 => BorderRadius.circular(
        23,
      );
  static BorderRadius get circleBorder58 => BorderRadius.circular(
        58.h,
      );

  // Rounded borders
  static BorderRadius get roundedBorder1 => BorderRadius.circular(
        1,
      );
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10,
      );
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15,
      );
  static BorderRadius get roundedBorder20 => BorderRadius.circular(
        20,
      );
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );

  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4,
      );
  static BorderRadius get roundedBorder41 => BorderRadius.circular(
        41,
      );
  static BorderRadius get roundedBorder52 => BorderRadius.circular(
        52,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
