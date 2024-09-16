import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lca/screens/devices_list/device_scroll.dart';
import 'package:lca/screens/dashboard/frame_eight_page.dart';
import 'package:lca/screens/profile/profile.dart';
import '../../app_routes.dart';
import '../../model/weather/weather_model.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/theme_helper.dart';
import '../complaint/home_complaint.dart';
import '../create_schedule/frame_twenty_screen.dart';
import 'package:get/get.dart';

class FrameNineteenContainerScreen extends StatefulWidget {
  int? devices;
  final Future<Weather>? futureWeatherData;
  static const String routeName = 'bottompage';
  FrameNineteenContainerScreen({Key? key, this.devices, this.futureWeatherData})
      : super(key: key);

  @override
  State<FrameNineteenContainerScreen> createState() =>
      _FrameNineteenContainerScreenState();
}

class _FrameNineteenContainerScreenState
    extends State<FrameNineteenContainerScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  String currentPageName = 'bottom'; // Default page name

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navigatorKey.currentState!.canPop()) {
          navigatorKey.currentState!.pop();
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appTheme.gray100F4,
          body: Navigator(
            key: navigatorKey,
            initialRoute: AppRoutes.frameEightScreen,
            onGenerateRoute: (routeSetting) {
              currentPageName = getCurrentPageName(routeSetting.name!);
              log('Navigating to page: $currentPageName'); // Log current page name

              return PageRouteBuilder(
                pageBuilder: (ctx, ani, ani1) =>
                    getCurrentPage(routeSetting.name!),
                transitionDuration: Duration(seconds: 0),
              );
            },
          ),
          bottomNavigationBar: _shouldShowBottomBar(currentPageName)
              ? _buildBottomBar(context)
              : null,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  /// Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.frameEightScreen;

   
      case BottomBarEnum.Complaints:
        return AppRoutes.frameSeventeenScreen;
      case BottomBarEnum.Profile:
        return AppRoutes.profile;
      default:
        return "/";
    }
  }

  /// Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.frameEightScreen:
        return DeviceListScreen();
      case AppRoutes.frameSeventeenScreen:
        return FrameSeventeenScreen();
      case AppRoutes.profile:
        return FrameThirtytwoPage();
      case AppRoutes.frameTwentyScreen:
        return FrameTwentyScreen(); // Ensure this is the correct page
      default:
        return DeviceListScreen();
    }
  }

  String getCurrentPageName(String route) {
    String pageName;
    switch (route) {
      case AppRoutes.frameEightScreen:
        pageName = 'DeviceListScreen';
        break;
      case AppRoutes.frameSeventeenScreen:
        pageName = 'FrameSeventeenScreen';
        break;
      case AppRoutes.profile:
        pageName = 'FrameThirtytwoPage';
        break;
      case AppRoutes.frameTwentyScreen:
        pageName = 'FrameTwentyScreen';
        break;
      default:
        pageName = 'UnknownPage';
    }

    // Log only for the specified pages
    if (pageName != 'UnknownPage') {
      log('Route $route maps to page $pageName');
    }

    return pageName;
  }

  bool _shouldShowBottomBar(String pageName) {
    // Hide bottom bar for specific pages
    return pageName != 'FrameTwentyScreen'; // Hide for FrameTwentyScreen
  }
}
