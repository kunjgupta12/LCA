import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lca/api/api.dart';
import 'package:lca/screens/auth/login.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import '../../api/location.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/image_constant.dart';
import '../../widgets/theme_helper.dart';

class FrameTwelveScreen extends StatefulWidget {
  FrameTwelveScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<FrameTwelveScreen> createState() => _FrameTwelveScreenState();
}

class _FrameTwelveScreenState extends State<FrameTwelveScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController grs = TextEditingController();

  TextEditingController country = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();

  bool contrast = false;
String? fcm_token;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // await Geolocator.requestPermission();
      await Geolocator.requestPermission()
          .then((value) {})
          .onError((error, stackTrace) {
        print('error');
      });
      return await Geolocator.getCurrentPosition();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

@override
  void initState() {
    // TODO: implement initState
   
    _getGeoLocationPosition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Sizer(builder: (context, orientation, deviceType) {
          return SizedBox(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      _buildFortyEight(context),
                      SizedBox(height: 21),
                      Text(
                        "User Registration".tr,
                        style: theme.textTheme.displaySmall,
                      ),
                      SizedBox(height: 30),
                      _buildName(context),
                      SizedBox(height: 10),
                      _buildPhoneNumber(context),
                      SizedBox(height: 10),
                      _buildEmail(context),
                      SizedBox(height: 10),
                      _buildPassword(context),
                      GestureDetector(
                        onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => Container(
                                  child: AlertDialog(
                                    content: Container(
                                      height: 50.h,
                                      child:const  Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                       
                                         
                                          Text(
                                              'Must be of at least 8 characters\nin length',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 15),)
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        child: Text(
                                          'Ok',
                                          style: CustomTextStyles
                                              .titleMediumGreen600,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  ),
                                )),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 25.0, top: 0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            const   Icon(
                                Icons.info,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                'Password hint',
                                style: CustomTextStyles.titleMediumGreen600,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      _buildConfirmPassword(context),
                      _buildGPS(context),
                      SizedBox(height: 7),
                      SizedBox(
                        width: 460.h,
                        child: Row(
                          children: [
                            _buildCountry(context),
                            _buildRegion(context)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 440.h,
                        child: Row(
                          children: [
                            _buildPincode(context),
                            _buildCity(context),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildAddress(context),
                      SizedBox(height: 5),
                     const  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: 25.0),
                            child: Text(
                              '* Required Fields',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: CustomCheckboxButton(
                          alignment: Alignment.centerLeft,
                          text: "Agree to Terms and Conditions".tr,
                          value: contrast,
                          decoration: BoxDecoration(),
                          padding: EdgeInsets.symmetric(vertical: 3),
                          onChange: (value) {
                            if (contrast == false) {
                              setState(() {
                                contrast = true;
                              });
                            } else if (contrast = true) {
                              setState(() {
                                contrast = false;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 25),
                      _buildRegister(context),
                      SizedBox(height: 5),
                      _buildContrast(context),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Section Widget
  Widget _buildFortyEight(BuildContext context) {
    return Container(
      width: 500.h,
      padding: EdgeInsets.symmetric(
        horizontal: 40.v,
        vertical: 80.h,
      ),
      decoration: AppDecoration.bg,
      child: CustomImageView(
        fit: BoxFit.fill,
        imagePath: ImageConstant.imgRectangle2212,
        height: 74.v,
        width: 32.h,
      ),
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 25,
      ),
      child: CustomTextFormField(
        height: 65,
        controller: nameController,
        hintText: "Name*".tr,
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
      ),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 25,
      ),
      child: CustomTextFormField(
        controller: phoneNumberController,
        validator: (value) {
          if (value == null || value.isEmpty || value.length != 10) {
            return 'Please enter a valid 10-digit number.';
          }
          return null;
        },
        hintText: "Phone Number*".tr,
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
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    //   final provider = Provider.of<SignUpProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 25,
      ),
      child: CustomTextFormField(
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
        hintText: "Email ID*".tr,
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
      ),
    );
  }

  bool _obscureText = true;

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    //  final provider = Provider.of<SignUpProvider>(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 25,
      ),
      child: CustomTextFormField(
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              value.length < 8 ||
              value.length > 25) {
            return 'Please enter a valid password';
          }
          return null;
        },
        controller: passwordController,
        hintText: "Password*".tr,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
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
      ),
    );
  }

  bool _cobscureText = true;

  /// Section Widget
  Widget _buildConfirmPassword(BuildContext context) {
    //   final provider = Provider.of<SignUpProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 25,
      ),
      child: CustomTextFormField(
        controller: confirmPasswordController,
        hintText: "Confirm Password*".tr,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
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
      ),
    );
  }

  // Section Widget
  Widget _buildGPS(BuildContext context) {
    return Container(
      width: 460.h,
      child: Padding(
        padding: EdgeInsets.only(
          left: 22,
          right: 19,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
           const      Text(
                  'Current Location',
                  style: TextStyle(color: Colors.green, fontSize: 18),
                ),
                Container(
                    child: IconButton(
                  onPressed: () async {
                    position = await _getGeoLocationPosition();
                    location =
                        'Lat: ${position!.latitude} , Long: ${position!.longitude}';
                    placemarks = await placemarkFromCoordinates(
                        position!.latitude, position!.longitude);
                    print(placemarks);
                    place = placemarks![0];
                    setState(() {
                      grs.text = position!.latitude.toString() +
                          " , " +
                          position!.longitude.toString();
                      region.text = place!.administrativeArea.toString();
                      pincode.text = place!.postalCode.toString();
                      city.text = place!.locality.toString();
                      country.text = place!.country.toString();
                      // address.text = place!.toString();
                    });
                  },
                  icon: Icon(
                    Icons.gps_fixed,
                    color: Colors.green,
                    size: 30.h,
                  ),
                )),
              ],
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              width: 394.h,
              child: TextFormField(
                enabled: false,
                controller: grs,
                autofocus: true,
                style: CustomTextStyles.bodyLargeDMSansBlack90001,
                decoration: InputDecoration(
                  hintText: "GPS Location",
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
      ),
    );
  }

  /// Section Widget
  Widget _buildCountry(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: SizedBox(
        width: 180.h,
        child: CustomTextFormField(
          controller: country,
          hintText: "Country*".tr,

          prefixConstraints: BoxConstraints(
            maxHeight: 45,
          ),
          //obscureText: true,
        ),
      ),
    );
  }

  Widget _buildRegion(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20,
      ),
      child: SizedBox(
        width: 180.h,
        child: CustomTextFormField(
          controller: region,
          hintText: "State*".tr,
         prefixConstraints: BoxConstraints(
            maxHeight: 45,
          ),
          //obscureText: true,
        ),
      ),
    );
  }

  Widget _buildPincode(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: SizedBox(
        width: 180.h,
        child: CustomTextFormField(
          controller: pincode,
          hintText: "Pincode*".tr,
        
          textInputType: TextInputType.number,
          //  textInputAction: TextInputAction.done,
          //    textInputType: TextInputType.visiblePassword,
          prefixConstraints: BoxConstraints(
            maxHeight: 45,
          ),
          // obscureText: true,
        ),
      ),
    );
  }

  Widget _buildCity(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20,
      ),
      child: SizedBox(
        width: 180.h,
        child: CustomTextFormField(
          controller: city,
          hintText: "City*".tr,
          textInputAction: TextInputAction.done,
          //       textInputType: TextInputType.visiblePassword,
          prefixConstraints: BoxConstraints(
            maxHeight: 45,
          ),
          // obscureText: true,
        ),
      ),
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 25,
      ),
      child: Container(
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
      ),
    );
  }

  /// Section Widget
  Widget _buildContrast(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 345.h,
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FrameThirteenScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account?",
                      style: CustomTextStyles.titleMediumGreen600,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomOutlinedButton(
                      text: 'Login',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FrameThirteenScreen()));
                      },
                      buttonStyle: CustomButtonStyles.outlineWhiteATL15
                          .copyWith(backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                        return const Color.fromRGBO(48, 60, 122, 1);
                      })),
                      buttonTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                      width: 85,
                      height: 30,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRegister(BuildContext context) {
    return CustomOutlinedButton(
        width: 200,
        text: "Register".tr,
        buttonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return Colors.green;
          }),
        ),
        onPressed: () {
          try {
            if (_formKey.currentState!.validate()) {
              if (contrast == false) {
               showToast(
                   'Please Accept Terms and Conditions',
                  );
              }
              if (confirmPasswordController.text != passwordController.text) {
                showToast('Password does not matched');
              } else
                Api().registerUser(
                  emailController.text,
                  passwordController.text,
                  nameController.text.split(' ').first ?? nameController.text,
                  nameController.text.split(' ').last ?? "",
                  phoneNumberController.text,
                  country.text,
                  pincode.text,
                  region.text,
                  address.text,
                  position!.latitude,
                  position!.longitude,
                  city.text,fcm_token.toString()
                );
            } 
            else {
               FocusScope.of(context).requestFocus();
            }
          } catch (e) {
            showToast(e.toString());
          }
        } 
        );
  }
}
