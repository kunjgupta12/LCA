import 'package:flutter/material.dart';
import 'package:lca/widgets/app_decoration.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/image_constant.dart';
import '../../widgets/theme_helper.dart';
import '../../widgets/utils/size_utils.dart';
import 'widgets/gridvalvecounte_item_widget.dart'; // ignore_for_file: must_be_immutable

class FrameThirtythreePage extends StatelessWidget {
  const FrameThirtythreePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 35.v),
            child: Container(
              margin: EdgeInsets.only(bottom: 5.v),
              padding: EdgeInsets.symmetric(horizontal: 13.h),
              child: Container(
                margin: EdgeInsets.only(right: 6.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.h,
                  vertical: 20.v,
                ),
                decoration: AppDecoration.outlinePrimary1.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder41,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTemperatureSection(context),
                    SizedBox(height: 14.v),
                    _buildLoranTwentyThreeSection(context),
                    SizedBox(height: 23.v),
                    _buildClockOneSection(context),
                    SizedBox(height: 30.v),
                    CustomElevatedButton(
                      text: "Low Flow",
                      margin: EdgeInsets.only(
                        left: 13.h,
                        right: 17.h,
                      ),
                    ),
                    SizedBox(height: 27.v),
                    _buildArrowLeftSection(context),
                    SizedBox(height: 11.v)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(
        text: "DASHBOARD",
      ),
      styleType: Style.bgGradientnameteal200nameerrorContainer,
    );
  }

  /// Section Widget
  Widget _buildTemperatureSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 5.h,
        right: 4.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 9.h,
        vertical: 3.v,
      ),
      decoration: AppDecoration.gradientTealToErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: 98.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "21°C",
                    style: theme.textTheme.displayLarge,
                  ),
                  Container(
                    width: 63.h,
                    margin: EdgeInsets.only(
                      left: 73.h,
                      top: 17.v,
                      bottom: 13.v,
                    ),
                    child: Text(
                      "High : 22 C\nLow : 20 C",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 98.h),
              child: Text(
                "Delhi",
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          SizedBox(height: 4.v),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 81.h),
              child: Text(
                "Partly Cloudy | Feels like 24°C",
                style: CustomTextStyles.bodySmall12,
              ),
            ),
          ),
          SizedBox(height: 20.v),
          Padding(
            padding: EdgeInsets.only(
              left: 57.h,
              right: 54.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgWind,
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  margin: EdgeInsets.only(
                    top: 5.v,
                    bottom: 2.v,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.h,
                    top: 2.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "5 km/h",
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        "Wind ",
                        style: CustomTextStyles.bodySmall12_1,
                      )
                    ],
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 91.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRain2,
                        height: 30.adaptSize,
                        width: 30.adaptSize,
                        margin: EdgeInsets.only(bottom: 6.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.v),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "50%",
                              style: theme.textTheme.titleSmall,
                            ),
                            Text(
                              "Humidity ",
                              style: CustomTextStyles.bodySmall12_1,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 17.v),
          Padding(
            padding: EdgeInsets.only(
              left: 57.h,
              right: 48.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 97.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomImageView(
                        //  imagePath: ImageConstant.imgRainSensor,
                        height: 30.adaptSize,
                        width: 30.adaptSize,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 1.h),
                            child: Text(
                              "50%",
                              style: theme.textTheme.titleSmall,
                            ),
                          ),
                          Text(
                            "Chance(Rain)",
                            style: theme.textTheme.bodySmall,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                CustomImageView(
                  //     imagePath: ImageConstant.imgDewPoint,
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 3.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "10mm",
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        "Precipitation",
                        style: theme.textTheme.bodySmall,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 17.v)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLoranTwentyThreeSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 3.h,
        right: 6.h,
      ),
      padding: EdgeInsets.symmetric(vertical: 16.v),
      decoration: AppDecoration.outlinePrimary2.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 6.v,
              bottom: 8.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Text(
                    "Loran23",
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                SizedBox(height: 6.v),
                Text(
                  "123456678912344",
                  style: CustomTextStyles.titleMediumLibreFranklinOnPrimary,
                )
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgRectangle4281,
            height: 68.v,
            width: 96.h,
            margin: EdgeInsets.only(top: 4.v),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildClockOneSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 9.h,
        right: 6.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 1.v),
            padding: EdgeInsets.symmetric(
              horizontal: 36.h,
              vertical: 6.v,
            ),
            decoration: AppDecoration.outlinePrimary3.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 11.v),
                CustomImageView(
                  imagePath: ImageConstant.imgClock,
                  height: 73.adaptSize,
                  width: 73.adaptSize,
                  margin: EdgeInsets.only(left: 6.h),
                ),
                SizedBox(height: 14.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Text(
                    "POWER",
                    style: CustomTextStyles.headlineSmallLightgreenA700,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 143.v,
            width: 158.h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 8.v,
            ),
            decoration: AppDecoration.outlinePrimary4.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgRain1,
              height: 126.adaptSize,
              width: 126.adaptSize,
              alignment: Alignment.center,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildValveElevenSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 1.h),
          child: Text(
            "Valve 11",
            style: theme.textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 3.v),
        CustomImageView(
          imagePath: ImageConstant.imgGroup48095620,
          height: 13.v,
          width: 149.h,
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildValveTwelveSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 1.h),
          child: Text(
            "Valve 12",
            style: theme.textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 2.v),
        Container(
          width: 148.h,
          decoration: AppDecoration.fillBlueGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
          child: Container(
            height: 13.v,
            width: 1.h,
            decoration: BoxDecoration(
              color: appTheme.cyan700,
              borderRadius: BorderRadius.circular(
                1.h,
              ),
            ),
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildArrowLeftSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgArrowLeft,
          height: 20.v,
          width: 12.h,
          margin: EdgeInsets.only(
            top: 192.v,
            bottom: 210.v,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 6.h),
            padding: EdgeInsets.symmetric(
              horizontal: 1.h,
              vertical: 16.v,
            ),
            decoration: AppDecoration.fillOnError.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: AppDecoration.outlinePrimary,
                        child: Text(
                          "Program A",
                          style: CustomTextStyles.headlineSmallRedA70001,
                        ),
                      ),
                      CustomOutlinedButton(
                        width: 108.h,
                        text: "Irrigation",
                        leftIcon: Container(
                          margin: EdgeInsets.only(right: 6.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.img90a1b852E20d4,
                            height: 18.adaptSize,
                            width: 18.adaptSize,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 21.v),
                SizedBox(
                  height: 42.v,
                  width: 312.h,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 4.h,
                            top: 3.v,
                          ),
                          child: Text(
                            "Valve 1",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 92.h),
                          child: Text(
                            "Valve 2",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 13.v,
                          width: 312.h,
                          decoration: BoxDecoration(
                            color: appTheme.greenA700,
                            borderRadius: BorderRadius.circular(
                              5.h,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              5.h,
                            ),
                            child: LinearProgressIndicator(
                              value: 1.0,
                              backgroundColor: appTheme.greenA700,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                appTheme.greenA700,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 41.v,
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 16.h,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return GridvalvecounteItemWidget();
                    },
                  ),
                ),
                SizedBox(height: 7.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    right: 5.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildValveElevenSection(context),
                      _buildValveTwelveSection(context)
                    ],
                  ),
                ),
                SizedBox(height: 28.v)
              ],
            ),
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgArrowLeft,
          height: 20.v,
          width: 12.h,
          margin: EdgeInsets.only(
            left: 5.h,
            top: 192.v,
            bottom: 210.v,
          ),
        )
      ],
    );
  }
}
