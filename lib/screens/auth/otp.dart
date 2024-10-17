import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lca/screens/auth/login.dart';

import '../../app_routes.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/custom_button_style.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/image_constant.dart';
import '../../widgets/theme_helper.dart';
import '../../widgets/utils/size_utils.dart';

class FrameFourteenScreen extends StatefulWidget {
  FrameFourteenScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<FrameFourteenScreen> createState() => _FrameFourteenScreenState();
}

class _FrameFourteenScreenState extends State<FrameFourteenScreen> {
  TextEditingController phoneNumberSectionController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  _buildLoginSection(context),
                  Spacer(
                    flex: 29,
                  ),
                  _buildPhoneNumberSection(context),
                  SizedBox(height: 24.v),
                  _buildFrameFourSection(context),
                  SizedBox(height: 21.v),
                  _buildDidntReceiveOTPSection(context),
                  SizedBox(height: 43.v),
                  _buildLoginButtonSection(context),
                  SizedBox(height: 11.v),
                  _buildViaEmailButtonSection(context),
                  Spacer(
                    flex: 70,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 59.h,
        vertical: 56.v,
      ),
      decoration: AppDecoration.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 38.v),
          Container(
            decoration: AppDecoration.outlineBlack,
            child: Text(
              "Login".tr,
              style: theme.textTheme.displayLarge,
            ),
          ),
          SizedBox(height: 13.v),
          Padding(
            padding: EdgeInsets.only(left: 9.h),
            child: Row(   crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(
                  "via Phone".tr,
                  style: CustomTextStyles.titleLargeRegular,
                ),SizedBox(width: 10,),Icon(Icons.phone,color: Colors.white,size: 30,),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumberSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 13.h,
        right: 27.h,
      ),
      child: CustomTextFormField(
        controller: phoneNumberSectionController,
        hintText: "Phone Number".tr,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.phone,
        alignment: Alignment.centerLeft,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(15.h, 11.v, 27.h, 11.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgMinimize,
            height: 22.v,
            width: 14.h,
            color: Colors.green,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 45.v,
        ),
        borderDecoration: TextFormFieldStyleHelper.fillGreen,
      ),
    );
  }

  /// Section Widget
  Widget _buildSendOTP(BuildContext context) {
    return CustomOutlinedButton(
      height: 31.v,
      width: 133.h,
      text: "Send OTP".tr,
      margin: EdgeInsets.only(right: 4.h),
      buttonStyle: CustomButtonStyles.outlineWhiteATL15,
      buttonTextStyle: CustomTextStyles.bodyLargeDMSansWhiteA70001,
    );
  }

  /// Section Widget
  Widget _buildFrameFourSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 13.h,
        right: 27.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 11.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.fillGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgLocation,
            color: Colors.green,
            height: 21.v,
            width: 16.h,
            margin: EdgeInsets.symmetric(vertical: 5.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 27.h,
              top: 3.v,
              bottom: 3.v,
            ),
            child: Text(
              "OTP".tr,
              style: CustomTextStyles.bodyLargeDMSansBlack90001,
            ),
          ),
          Spacer(),
          _buildSendOTP(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDidntReceiveOTPSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 37.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 110.h,
            child: Text(
              "Didn't receive OTP?".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium!.copyWith(
                height: 1.33,
              ),
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgQrcode,
            height: 21.v,
            width: 15.h,
            margin: EdgeInsets.symmetric(vertical: 9.v),
          ),
          
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginButtonSection(BuildContext context) {
    return CustomOutlinedButton(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      width: 284.h,
      height: 50,
      text: "Login".tr,
      onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: Text('Coming Soon......'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Text(
                      'Ok',
                      style: CustomTextStyles.titleMediumGreen600,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )),
    );
  }

  /// Section Widget
  Widget _buildViaEmailButtonSection(BuildContext context) {
    return MaterialButton(
        color: Color.fromRGBO(48, 60, 122, 1),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => FrameThirteenScreen()));
        },
        height: 46.v,
        // width: 212.h,
        child: Text(
          "via Email".tr,
          style: CustomTextStyles.headlineSmallDMSansWhiteA70001Regular,
        ));
  }
}
