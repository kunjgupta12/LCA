import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lca/screens/complaint/view_complaint.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/theme_helper.dart';
import 'create_complaint.dart';

String? jsonString;
String? token;
void storedevice() async {
  final prefs = await SharedPreferences.getInstance();

  token = prefs.getString("token");
}

class FrameSeventeenScreen extends StatefulWidget {
  FrameSeventeenScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<FrameSeventeenScreen> createState() => _FrameSeventeenScreenState();
}

class _FrameSeventeenScreenState extends State<FrameSeventeenScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  void initState() {
    storedevice();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100F4,
        appBar: _buildAppBar(context),
        body: Sizer(builder: (context, orientation, deviceType) {
          return SizedBox(
            width: double.maxFinite,
            height: height * .92,
            child: Column( 
              children: [
                const SizedBox(height: 10),
                 Expanded(
                  child: Container(
                    width: .9 * MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      left: 12,
                      right: 18,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: AppDecoration.gradientGrayBToGreenB.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder41,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .05),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width * .8,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Having Issues?".tr,
                                    style: CustomTextStyles
                                        .displayMediumPoppinsff000000,
                                  ),
                                  TextSpan(
                                    text: "\nDon’t Worry,We got you!".tr,
                                    style: CustomTextStyles.titleSmallff000000,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .1),
                        CustomElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FrameEighteenScreen(
                                    data: jsonString, token: token)));
                          },
                          height: height * .1,
                          width: MediaQuery.of(context).size.width * .65,
                          text: "Register Complaint".tr,
                          buttonStyle: CustomButtonStyles.fillOrangeA,
                          buttonTextStyle:
                              CustomTextStyles.titleLargePoppinsWhiteA70001,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .1),
                        CustomElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    FrameNineteenPage(token: token)));
                          },
                          height: height * .1,
                          width: MediaQuery.of(context).size.width * .65,
                          text: "View Complaints".tr,
                          buttonStyle: CustomButtonStyles.fillOrangeATL15,
                          buttonTextStyle:
                              CustomTextStyles.titleLargePoppinsWhiteA70001,
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .7,
                            child: Text(
                              "For further Assistance \nContact us at +910101010 "
                                  .tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.titleLargePoly.copyWith(
                                height: 1.05,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: EdgeInsets.only(
          left: 2,
          top: 27,
          bottom: 3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppbarTitle(
              text: "My Complaints".tr,
            ),
          ],
        ),
      ),
      styleType: Style.bgGradientnamelightgreenA700namegreen800aa,
    );
  }
}
