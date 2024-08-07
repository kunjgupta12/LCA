import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lca/services/location.dart';
import 'package:lca/api/user/user.dart';
import 'package:lca/widgets/app_decoration.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_checkbox_button.dart';
import 'package:lca/widgets/custom_elevated_button.dart';
import 'package:lca/widgets/custom_image.dart';
import 'package:lca/widgets/custom_text_form_field.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/image_constant.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:get/get.dart';
class Edit extends StatefulWidget {
  double? lat;
  double? long;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String token;
  String? city;
  String? country;
  String? state;
  String? pincode;
  String? fullAddress;
  Edit(
      {super.key,
      this.lat,
      this.long,
      required this.firstName,
      this.lastName,
      required this.token,
      this.phoneNo,
      this.city,
      this.country,
      this.email,
      this.fullAddress,
      this.pincode,
      this.state});

  @override
  State<Edit> createState() => _EditState();
}

Widget _buildFortyEight(BuildContext context) {
  return Container(
    width: 500.h,
    padding: EdgeInsets.symmetric(
      horizontal: 40.v,
      vertical: 80.h,
    ),
    decoration: AppDecoration.bg,
    child: Center(
      child: Container(
        decoration: AppDecoration.outlineBlack,
        child: Text(
          "Edit Profile".tr,
          style: theme.textTheme.displayLarge,
        ),
      ),
    ),
  );
}

class _EditState extends State<Edit> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool show_enabled = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController city =
        TextEditingController(text: widget.city.toString());
    TextEditingController firstNmae = TextEditingController(
        text: '${widget.firstName.toString()} ${widget.lastName}');
    TextEditingController email = TextEditingController(text: widget.email);
    TextEditingController phoneNo = TextEditingController(text: widget.phoneNo);
    TextEditingController country = TextEditingController(text: widget.country);
    TextEditingController state = TextEditingController(text: widget.state);
    TextEditingController pincode =
        TextEditingController(text: widget.pincode.toString());
    TextEditingController fullAddress =
        TextEditingController(text: widget.fullAddress);
    TextEditingController grs =
        TextEditingController(text: '${widget.lat},${widget.long}');

    return Scaffold(
      body: Sizer(builder: (context, orientation, deviceType) {
        return SingleChildScrollView(
            child: Column(
          children: [
            _buildFortyEight(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildName(context, firstNmae),
                  _buildPhoneNumber(context, phoneNo),
                  _buildEmail(context, email),
                  CustomCheckboxButton(
                    alignment: Alignment.centerLeft,
                    text: "Change Password".tr,
                    textStyle: CustomTextStyles.titleMediumGreen600,
                    value: show_enabled,
                    decoration: BoxDecoration(),
                    padding: EdgeInsets.symmetric(vertical: 3),
                    onChange: (value) {
                      if (show_enabled == false) {
                        setState(() {
                          show_enabled = true;
                        });
                      } else if (show_enabled = true) {
                        setState(() {
                          show_enabled = false;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildPassword(context),
                  _buildConfirmPassword(context),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Current Location'.tr,
                            style: TextStyle(color: Colors.green, fontSize: 18),
                          ),
                          Container(
                              child: IconButton(
                            onPressed: () async {
                              position = await getGeoLocationPosition();
                              location =
                                  'Lat: ${position!.latitude} , Long: ${position!.longitude}';
                              placemarks = await placemarkFromCoordinates(
                                  position!.latitude, position!.longitude);
                              print(placemarks);
                              place = placemarks![0];

                              grs.text = position!.latitude.toString() +
                                  " , " +
                                  position!.longitude.toString();
                              state.text = place!.administrativeArea.toString();
                              pincode.text = place!.postalCode.toString();
                              city.text = place!.locality.toString();
                              country.text = place!.country.toString();

                              // address.text = place!.toString();
                            },
                            icon: Icon(
                              Icons.gps_fixed,
                              color: Colors.green,
                              size: 25.h,
                            ),
                          )),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey.shade100),
                        width: 384.h,
                        child: TextFormField(
                          enabled: false,
                          controller: grs,
                          autofocus: true,
                          style: CustomTextStyles.bodyLargeDMSansBlack90001,
                          decoration: InputDecoration(
                            hintText: "GPS Location".tr,
                            hintStyle: CustomTextStyles.titleLargeGray50003,
                            isDense: true,
                            fillColor: appTheme.gray200B7,
                            filled: true,
                            border: //widget.borderDecoration ??
                                OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: // widget.borderDecoration ??
                                OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: //widget.borderDecoration ??
                                OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                              borderSide: BorderSide(
                                color: appTheme.green300B7,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCountry(context, country),
                      _buildCountry(context, state)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCountry(context, pincode),
                      _buildCountry(context, city)
                    ],
                  ),
                  _buildAddress(context, fullAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: 186.h,
                        text: "Cancel".tr,
                        buttonTextStyle: CustomTextStyles.labelLargeWhiteA70001,
                        buttonStyle:
                            CustomButtonStyles.fillOrangeATL15.copyWith(
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            // If the button is pressed, return green, otherwise blue
                            if (states.contains(WidgetState.pressed)) {
                              return Colors.green;
                            }
                            return Colors.green;
                          }),
                        ),
                      ),
                      CustomElevatedButton(
                        onPressed: () async {
                          await update_user(
                            widget.token,
                            email.text,
                            show_enabled ? password.text : null,
                            firstNmae.text.split(' ').first ??
                                firstNmae.text.split('').last,
                            firstNmae.text.split(' ').last,
                            phoneNo.text,
                            country.text,
                            pincode.text,
                            state.text,
                            fullAddress.text,
                            grs.text.split(',').first,
                            grs.text.split(',').last,
                            city.text,
                          );
                        },
                        width: 186.h,
                        text: "Save".tr,
                        buttonTextStyle: CustomTextStyles.labelLargeWhiteA70001,
                        buttonStyle:
                            CustomButtonStyles.fillOrangeATL15.copyWith(
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            if (states.contains(WidgetState.pressed)) {
                              return Colors.green;
                            }
                            return Colors.green;
                          }),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
      }),
    );
  }

  bool _obscureText = true;

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    //  final provider = Provider.of<SignUpProvider>(context);
    return CustomTextFormField(
      enabled: show_enabled,
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.length < 8 ||
            value.length > 25) {
          return 'Please enter a valid password';
        }
        return null;
      },
      controller: password,
      hintText: "Password*".tr,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      fillColor: show_enabled ? appTheme.green20030 : appTheme.gray200B7,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(15, 12, 27, 12),
        child: CustomImageView(
          color: Colors.green,
          imagePath: ImageConstant.imgLocation,
          height: 21,
          width: 21,
        ),
      ),
      suffix: Container(
        margin: const EdgeInsets.fromLTRB(30, 15, 16, 15),
        child: CustomImageView(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          color: Colors.green,
          imagePath: _obscureText ? ImageConstant.eye : ImageConstant.imgEye,
          height: 25,
          width: 25,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 45,
      ),
      obscureText: _obscureText,
    );
  }

  bool _cobscureText = true;

  /// Section Widget
  Widget _buildConfirmPassword(BuildContext context) {
    //   final provider = Provider.of<SignUpProvider>(context);
    return CustomTextFormField(
      enabled: show_enabled,
      controller: confirmPasswordController,
      hintText: "Confirm Password*".tr,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      fillColor: show_enabled ? appTheme.green20030 : appTheme.gray200B7,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(15, 12, 27, 12),
        child: CustomImageView(
          color: Colors.green,
          imagePath: ImageConstant.imgLocation,
          height: 21,
          width: 21,
        ),
      ),
      suffix: Container(
        margin: const EdgeInsets.fromLTRB(30, 15, 16, 15),
        child: CustomImageView(
          onTap: () {
            setState(() {
              _cobscureText = !_cobscureText;
            });
          },
          color: Colors.green,
          imagePath: _cobscureText ? ImageConstant.eye : ImageConstant.imgEye,
          height: 25,
          width: 25,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 45,
      ),
      obscureText: _cobscureText,
    );
  }

  Widget _buildAddress(BuildContext context, TextEditingController address) {
    return Container(
      height: 150,
      child: TextFormField(
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        controller: address,
        //   autofocus: true,
        style: CustomTextStyles.bodyLargeDMSansBlack90001,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: "Full Address",
          hintStyle: CustomTextStyles.titleLargeGray50003,
          isDense: true,
          contentPadding:
              const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
          fillColor: appTheme.green20030,
          filled: true,
          border: //widget.borderDecoration ??
              OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: // widget.borderDecoration ??
              OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: //widget.borderDecoration ??
              OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
            borderSide: BorderSide(
              color: appTheme.green300B7,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountry(BuildContext context, TextEditingController country) {
    return SizedBox(
      width: 178.h,
      child: CustomTextFormField(
        controller: country,

        prefixConstraints: BoxConstraints(
          maxHeight: 45,
        ),
        //obscureText: true,
      ),
    );
  }

  Widget _buildName(
      BuildContext context, TextEditingController nameController) {
    return CustomTextFormField(
      height: 65,
      controller: nameController,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(14, 10, 18, 10),
        child: CustomImageView(
          color: Colors.green,
          imagePath: ImageConstant.imgAccountcircle,
          height: 24,
          width: 24,
        ),
      ),
      prefixConstraints: BoxConstraints(),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumber(
      BuildContext context, TextEditingController phoneNumberController) {
    return CustomTextFormField(
      controller: phoneNumberController,
      validator: (value) {
        if (value == null || value.isEmpty || value.length != 10) {
          return 'Please enter a valid 10-digit number.';
        }
        return null;
      },
      textInputType: TextInputType.phone,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(15, 11, 27, 11),
        child: CustomImageView(
          color: Colors.green,
          imagePath: ImageConstant.imgMinimize,
          height: 22,
          width: 14,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 45,
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(
      BuildContext context, TextEditingController emailController) {
    //   final provider = Provider.of<SignUpProvider>(context);
    return CustomTextFormField(
      validator: (value) {
        RegExp regex =
            RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
        if (value!.isEmpty) {
          return 'Please enter email';
        } else {
          if (!regex.hasMatch(value)) {
            return 'Please enter valid email';
          } else {
            return null;
          }
        }
      },
      controller: emailController,
      textInputType: TextInputType.emailAddress,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(15, 14, 27, 14),
        child: CustomImageView(
          color: Colors.green,
          imagePath: ImageConstant.imgLock,
          height: 16,
          width: 20,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 45,
      ),
    );
  }
}
