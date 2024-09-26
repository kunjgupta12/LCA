import 'package:flutter/material.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/size_utils.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get labelLargeRedA70003 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.redA70003,
      );

  static get headlineSmallErrorContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.errorContainer,
      );
  static get headlineSmallRedA70001 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.redA70001,
        fontWeight: FontWeight.w700,
      );
//
  static get bodySmall12 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 12,
      );
  static get bodySmall12_1 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 12,
      );
// Headline text style
  static get headlineSmallLightgreenA700 =>
      theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.lightGreenA700,
      );

// Title text style
  static get titleMediumLibreFranklinOnPrimary =>
      theme.textTheme.titleMedium!.libreFranklin.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleSmallPoppinsPrimary =>
      theme.textTheme.titleSmall!.poppins.copyWith(
        color: theme.colorScheme.primary.withOpacity(1),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      );
  static get bodyLargeDMSans => theme.textTheme.bodyLarge!.dMSans.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeDMSansBlack90001 =>
      theme.textTheme.bodyLarge!.dMSans.copyWith(
        color: appTheme.black90001.withOpacity(0.54),
        fontSize: 18,
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeDMSansBluegray500 =>
      theme.textTheme.bodyLarge!.dMSans.copyWith(
        color: appTheme.blueGray500,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeDMSansRegular =>
      theme.textTheme.bodyLarge!.dMSans.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeDMSansWhiteA70001 =>
      theme.textTheme.bodyLarge!.dMSans.copyWith(
        color: appTheme.whiteA70001,
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeJosefinSans =>
      theme.textTheme.bodyLarge!.josefinSans.copyWith(
        fontSize: 19,
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeLohitDevanagari =>
      theme.textTheme.bodyLarge!.lohitDevanagari.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get bodyMedium13 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 13,
      );
  static get bodyMediumInter => theme.textTheme.bodyMedium!.inter;
  // Display text style
  static get displayMedium48 => theme.textTheme.displayMedium!.copyWith(
        fontSize: 48,
      );
  static get displayMediumCodaCaption =>
      theme.textTheme.displayMedium!.codaCaption.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w800,
      );
  static get displayMediumPoppins =>
      theme.textTheme.displayMedium!.poppins.copyWith(
        fontSize: 40,
        fontWeight: FontWeight.w700,
      );
  static get displayMediumPoppinsff000000 =>
      theme.textTheme.displayMedium!.poppins.copyWith(
        color: Color(0XFF000000),
        fontSize: 40.fSize,
        fontWeight: FontWeight.w800,
      );
  // Headline text style
  static get headlineLargeLibreFranklin =>
      theme.textTheme.headlineLarge!.libreFranklin.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w500,
      );
  static get headlineLargeLilitaOneGreenA700 =>
      theme.textTheme.headlineLarge!.lilitaOne.copyWith(
        color: appTheme.greenA700,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      );
  static get headlineLargeRobotoBlack90001 =>
      theme.textTheme.headlineLarge!.roboto.copyWith(
        color: appTheme.black90001,
        fontSize: 32,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallDMSansBlack90001 =>
      theme.textTheme.headlineSmall!.dMSans.copyWith(
        color: appTheme.black90001,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallDMSansBlack90001Bold =>
      theme.textTheme.headlineSmall!.dMSans.copyWith(
        color: appTheme.black90001,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallDMSansBlack90001_1 =>
      theme.textTheme.headlineSmall!.dMSans.copyWith(
        color: appTheme.black90001,
      );
  static get headlineSmallDMSansWhiteA70001 =>
      theme.textTheme.headlineSmall!.dMSans.copyWith(
        color: appTheme.whiteA70001,
      );
  static get headlineSmallDMSansWhiteA70001Regular =>
      theme.textTheme.headlineSmall!.dMSans.copyWith(
        color: appTheme.whiteA70001,
        fontWeight: FontWeight.w400,
      );
  static get headlineSmallLibreFranklinWhiteA70001 =>
      theme.textTheme.headlineSmall!.libreFranklin.copyWith(
        color: appTheme.whiteA70001,
      );
  static get headlineSmallLilitaOneWhiteA70001 =>
      theme.textTheme.headlineSmall!.lilitaOne.copyWith(
        color: appTheme.whiteA70001,
        fontWeight: FontWeight.w400,
      );
  static get headlineSmallPoppinsWhiteA70001 =>
      theme.textTheme.headlineSmall!.poppins.copyWith(
        color: appTheme.whiteA70001,
        fontWeight: FontWeight.w700,
      );
  // Label text style
  static get labelLargeRed50 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.red50,
      );
  static get labelLargeRoboto => theme.textTheme.labelLarge!.roboto.copyWith(
        fontSize: 13,
      );
  static get labelLargeRobotoBlack90001 =>
      theme.textTheme.labelLarge!.roboto.copyWith(
        color: appTheme.black90001.withOpacity(0.7),
        fontSize: 13,
      );
  static get labelLargeWhiteA70001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.whiteA70001,
        fontWeight: FontWeight.w800,
      );
  static get labelMediumRoboto => theme.textTheme.labelMedium!.roboto.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get labelMediumRobotoBlack90001 =>
      theme.textTheme.labelMedium!.roboto.copyWith(
        color: appTheme.black90001.withOpacity(0.5),
        fontWeight: FontWeight.w500,
      );
  // Title text style
  static get titleLargeGray50003 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.gray50003,
      );
  static get titleLargeLibreFranklinWhiteA70001 =>
      theme.textTheme.titleLarge!.libreFranklin.copyWith(
        color: appTheme.whiteA70001,
      );
  static get titleLargePoly => theme.textTheme.titleLarge!.poly.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get titleLargePoppins => theme.textTheme.titleLarge!.poppins.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get titleLargePoppinsGray600 =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: appTheme.gray600,
        fontWeight: FontWeight.w600,
      );
  static get titleLargePoppinsRegular =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get titleLargePoppinsWhiteA70001 =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: appTheme.whiteA70001,
        fontWeight: FontWeight.w600,
        fontSize:27.fSize
      );
  static get titleLargeRedA70002 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.redA70002,
      );
  static get titleLargeRegular => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get titleLargeWhiteA70001 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA70001,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeWhiteA70001Bold => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.whiteA70001,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumBluegray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray900,
        fontSize: 18,
      );
  static get titleMediumGreen600 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.green600,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumPoppinsDeeporange600 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.deepOrange600,
      );
  static get titleMediumPoppinsGreenA70001 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.greenA70001,
      );
  static get titleMediumPoppinsOnErrorContainer =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get titleMediumPoppinsRedA70001 =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: appTheme.redA70001,
      );
  static get titleMediumWhiteA70001 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA70001,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallRobotoBlack90001 =>
      theme.textTheme.titleSmall!.roboto.copyWith(
        color: appTheme.black90001.withOpacity(0.7),
      );
  static get titleSmallff000000 => theme.textTheme.titleSmall!.copyWith(
        color: Color(0XFF000000),
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get dMSans {
    return copyWith(
      fontFamily: 'DM Sans',
    );
  }

  TextStyle get libreFranklin {
    return copyWith(
      fontFamily: 'Libre Franklin',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get lilitaOne {
    return copyWith(
      fontFamily: 'Lilita One',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get lohitDevanagari {
    return copyWith(
      fontFamily: 'Lohit Devanagari',
    );
  }

  TextStyle get josefinSans {
    return copyWith(
      fontFamily: 'Josefin Sans',
    );
  }

  TextStyle get codaCaption {
    return copyWith(
      fontFamily: 'Coda Caption',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get poly {
    return copyWith(
      fontFamily: 'Poly',
    );
  }
}
