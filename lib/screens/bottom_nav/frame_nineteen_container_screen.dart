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

// ignore_for_file: must_be_immutable
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
                  onGenerateRoute: (routeSetting) => PageRouteBuilder(
                      pageBuilder: (ctx, ani, ani1) =>
                          getCurrentPage(routeSetting.name!),
                      transitionDuration: Duration(seconds: 0))),
              bottomNavigationBar: _buildBottomBar(context))),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.frameEightScreen;
      case BottomBarEnum.Search:
        return AppRoutes.frameEightScreen;
      case BottomBarEnum.Complaints:
        return AppRoutes.frameSeventeenScreen;
      case BottomBarEnum.Profile:
        return AppRoutes.profile;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.frameEightScreen:
        return DeviceListScreen();

   
      case AppRoutes.frameSeventeenScreen:
        return FrameSeventeenScreen();
      case AppRoutes.profile:
        return FrameThirtytwoPage();
      default:
        return DefaultWidget();
    }
  }
}
