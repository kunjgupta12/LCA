import 'package:flutter/material.dart';
import 'package:lca/screens/auth/login.dart';
import 'package:lca/screens/auth/signup.dart';
import 'package:lca/screens/bottom_nav/frame_nineteen_container_screen.dart';
import 'package:lca/screens/devices_list/device_list.dart';
import 'package:lca/screens/home/frame_eight_page.dart';
import 'package:lca/screens/profile/profile.dart';
import 'package:lca/screens/register_device/register_device.dart';
import 'package:lca/screens/splash_screen.dart';

class AppRoutes {
  static const String frameFiveScreen = '/frame_five_screen';
  static const String profile = '/frame_thiertytwo';

  static const String frameThirteenScreen = '/frame_thirteen_screen';

  static const String frameFourteenScreen = '/frame_fourteen_screen';

  static const String frameFifteenScreen = '/frame_fifteen_screen';

  static const String frameEightScreen = '/frame_eight_screen';

  static const String frameSeventeenScreen = '/frame_seventeen_screen';

  static const String frameEighteenScreen = '/frame_eighteen_screen';

  static const String frameNineteenPage = '/frame_nineteen_page';

  static const String frameNineteenContainerScreen =
      '/frame_nineteen_container_screen';

  static const String frameTwentyScreen = '/frame_twenty_screen';

  static const String devicelist = '/devices';
  static const String frameSevenScreen = '/frame_seven_screen';

  static const String homeScreen = '/home_screen';

  static const String frameTenScreen = '/frame_ten_screen';

  static const String frameNineScreen = '/frame_nine_screen';

  static const String frameTwelveScreen = '/frame_twelve_screen';

  static const String frameSixteenScreen = '/frame_sixteen_screen';

  static const String frameTwentytwoScreen = '/frame_twentytwo_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    frameFiveScreen: (context) => FrameFiveScreen(),
    frameThirteenScreen: (context) => FrameThirteenScreen(),
    profile: (context) => FrameThirtytwoPage(),
    devicelist: (context) => DeeviceList(),
    frameEightScreen: (context) => FrameEightPage(),
    frameNineteenContainerScreen: (context) => FrameNineteenContainerScreen(),
    frameFifteenScreen: (context) => FrameFifteenScreen(),
    frameTwelveScreen: (context) => FrameTwelveScreen(),
  };
}
