import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lca/api/api.dart';
import 'package:lca/api/auth/auth_repository.dart';
import 'package:lca/screens/auth/otp.dart';
import 'package:lca/screens/auth/signup.dart';
import 'package:lca/screens/schedule/view_schedule.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_decoration.dart';
import '../../widgets/custom_button_style.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/image_constant.dart';
import '../../widgets/theme_helper.dart';

class FrameThirteenScreen extends StatefulWidget {
  FrameThirteenScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<FrameThirteenScreen> createState() => _FrameThirteenScreenState();
}

class _FrameThirteenScreenState extends State<FrameThirteenScreen> {
  TextEditingController emailSectionController = TextEditingController();
  final _focusNode = List.generate(2, (_) => FocusNode());
  TextEditingController passwordSectionController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _focusNode.forEach((node) => node.dispose());
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Sizer(
          builder: (context, orientation, deviceType) {
            
       return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            physics: ScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              //    width: max.width,
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      _buildLoginSection(context),
                      Spacer(
                        flex: 30,
                      ),
                      _buildEmailSection(context),
                      SizedBox(height: 20),
                      _buildPasswordSection(context),
                      SizedBox(height: 43),
                      _buildLoginButtonSection(context),
                      SizedBox(height: 15),
                      _buildViaPhoneButtonSection(context),
                      SizedBox(
                        height: 20,
                      ),
                      _buildContrast(context),
                      Spacer(
                        flex: 69,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );}
        ),
      ),
    );
  }

// Section Widget
  Widget _buildContrast(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 335.h,
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FrameTwelveScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?".tr,
                      style: CustomTextStyles.titleMediumGreen600,
                    ),
                    
                    CustomOutlinedButton(
                      text: 'Create'.tr,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FrameTwelveScreen()));
                      },
                      buttonStyle: CustomButtonStyles.outlineWhiteATL15
                          .copyWith(
                            backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                        return Color.fromRGBO(48, 60, 122, 1);
                      })),
                      buttonTextStyle: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.w800),
                      width:105.h,
                      height: 30.v,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 59,
        vertical: 56,
      ),
      decoration: AppDecoration.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 38),
          Container(
            decoration: AppDecoration.outlineBlack,
            child: Text(
              "Login".tr,
              style: theme.textTheme.displayLarge,
            ),
          ),
          SizedBox(height: 13),
          Padding(
            padding: EdgeInsets.only(left: 9),
            child: Text(
              "via Email".tr,
              style: CustomTextStyles.titleLargeRegular,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: CustomTextFormField(
        focusNode: _focusNode[0],
        controller: emailSectionController,
        hintText: "Email ID*".tr,
        validator: (value) {
          RegExp regex =
              RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
          if (value!.isEmpty) {
            return 'Please enter email';
          } else {
            if (!regex.hasMatch(value)) {
              return 'Enter valid Email id';
            } else {
              return null;
            }
          }
        },
        textInputType: TextInputType.emailAddress,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(15, 14, 27, 14),
          child: CustomImageView(
            imagePath: ImageConstant.imgLock,
            height: 16,
            color: Colors.green,
            width: 20,
          ),
        ),
        prefixConstraints: BoxConstraints(maxHeight: 45),
        //borderDecoration: TextFormFieldStyleHelper.fillGreen,
      ),
    );
  }

  bool _cobscureText = true;

  /// Section Widget
  Widget _buildPasswordSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: CustomTextFormField(
        controller: passwordSectionController,
        hintText: "Password*".tr,
        focusNode: _focusNode[1],
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        prefix: Container(
          margin: const EdgeInsets.fromLTRB(15, 12, 27, 12),
          child: CustomImageView(
            imagePath: ImageConstant.imgLocation,
            color: Colors.green,
            height: 21,
            width: 16,
          ),
        ),
        suffix: Container(
          margin: EdgeInsets.fromLTRB(30, 15, 16, 15),
          child: CustomImageView(
            onTap: () {
              setState(() {
                _cobscureText = !_cobscureText;
              });
            },
            color: Colors.green,
            imagePath: _cobscureText ? ImageConstant.eye : ImageConstant.imgEye,
            height: 20,
            width: 20,
          ),
        ),
        prefixConstraints: const BoxConstraints(
          maxHeight: 45,
        ),
        obscureText: _cobscureText,
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginButtonSection(BuildContext context) {
    return Consumer<LoginNotifier>(
        builder: (context, dataProvider, child) { if (dataProvider.isLoading==true) {
          return Center(child: CircularProgressIndicator());
        } 
      if(dataProvider.errorMessage==null){
        return CustomOutlinedButton(
          onPressed: () {
            if (_formKey.currentState!.validate())
            {
            dataProvider.loginUser(
                  emailSectionController.text, passwordSectionController.text,context);
            }
           
          },
          width: 284,
          height: 50,
          text: "Login".tr,
          // margin: EdgeInsets.only(left: 15),
          alignment: Alignment.center,
        );
      } return CircularProgressIndicator();
      }
  );  
  }

  /// Section Widget
  Widget _buildViaPhoneButtonSection(BuildContext context) {
    return MaterialButton(
        color: Color.fromRGBO(48, 60, 122, 1),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FrameFourteenScreen()));
          //.pushNamed(context, AppRoutes.frameFourteenScreen);
        },
        height: 46,
        // width: 212.h,
        child: Text(
          "via Phone".tr,
          style: CustomTextStyles.headlineSmallDMSansWhiteA70001Regular,
        ));
  }
}
