import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/api/device/devices.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/location.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/theme_helper.dart';

class FrameFifteenScreen extends StatefulWidget {
  int? devices;
  FrameFifteenScreen({Key? key, this.devices})
      : super(
          key: key,
        );

  @override
  State<FrameFifteenScreen> createState() => _FrameFifteenScreenState();
}

int? selectedValue = 1;
int? _selectedValue = 1;
int total = _selectedValue! + 4;

class _FrameFifteenScreenState extends State<FrameFifteenScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getGeoLocationPosition();
    gettoken();
    super.initState();
  }

  TextEditingController deviceIDvalueController = TextEditingController();
  String? token;
  TextEditingController nameController = TextEditingController();

  TextEditingController country = TextEditingController();

  TextEditingController region = TextEditingController();

  TextEditingController pincode = TextEditingController();
  TextEditingController latitude = TextEditingController();

  TextEditingController longitude = TextEditingController();

  TextEditingController latitudedb = TextEditingController();

  TextEditingController longitudedb = TextEditingController();
  TextEditingController city = TextEditingController();
  String? latlong;
  TextEditingController address = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  int? default_value = 4;
  void _handleValueChanged(int? value) {
    setState(() {
      selectedValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
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
                      _buildRegisterDeviceSection(context),
                      SizedBox(height: 17),
                      Container(
                        width: 459,
                        margin: const EdgeInsets.only(
                          left: 25,
                          right: 36,
                        ),
                        padding:const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 22,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 6),
                            Text(
                              "Device Details".tr,
                              style: CustomTextStyles
                                  .headlineSmallDMSansBlack90001Bold,
                            ),
                            SizedBox(height: 1),
                            Divider(
                              color: appTheme.gray400,
                              endIndent: 15,
                            ),
                            SizedBox(height: 36),
                            Text(
                              "Device IMEI".tr,
                              style: CustomTextStyles.titleMediumBluegray900,
                            ),
                          const  SizedBox(height: 16),
                            Padding(
                              padding:const EdgeInsets.only(right: 10),
                              child: TextFormField(
                                  enabled: true,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length != 15) {
                                      return 'Please enter a valid IMEI number.';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  scrollPadding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  controller: deviceIDvalueController,
                                  style: CustomTextStyles
                                      .bodyLargeDMSansBlack90001,
                                  maxLength: 15,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Device IMEI" + "*".tr,
                                    hintStyle: CustomTextStyles
                                        .bodyLargeDMSansBluegray500,
                                    isDense: true,
                                    contentPadding:const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 9,
                                    ),
                                    fillColor: appTheme.green20030,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: appTheme.green300B7,
                                        width: 2,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: appTheme.green300B7,
                                        width: 2,
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                "Device Name".tr,
                                style: CustomTextStyles.titleMediumBluegray900,
                              ),
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: CustomTextFormField(
                                width: 380.h,
                                controller: nameController,
                                hintText: "Device Name*".tr,
                                hintStyle:
                                    CustomTextStyles.bodyLargeDMSansBluegray500,
                                textInputAction: TextInputAction.done,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 9,
                                ),
                              ),
                            ),
                            SizedBox(height: 5.v),
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text(
                                "Expansion Mode".tr,
                                style: CustomTextStyles.titleMediumBluegray900,
                              ),
                            ),
                            Container(
                              width: 380.h,
                              height: 80.v,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.green,
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          _handleValueChanged(1);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 2,
                                                ),
                                                color: selectedValue == 1
                                                    ? Colors.green
                                                    : Colors.transparent,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('Connected'.tr)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      _handleValueChanged(2);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.green,
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 2,
                                                ),
                                                color: selectedValue == 2
                                                    ? Colors.green
                                                    : Colors.transparent,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text('Not Connected'.tr)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            selectedValue == 1
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total valve Count'.tr,
                                          style: CustomTextStyles
                                              .titleMediumBluegray900,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        DropdownButton<int>(
                                          value: _selectedValue,
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              _selectedValue = newValue;
                                            });
                                          },
                                          items: List.generate(
                                  selectedValue == 1 ?             8:3,
                                            (index) => DropdownMenuItem<int>(
                                              value: index + 1,
                                              child: Text('${index + 5}'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const  SizedBox(
                                    height: 2,
                                  ),
                            selectedValue == 1
                                ? Text(
                                    'This expansion count will reflect on next schedule save'
                                        .tr,
                                    style:
                                        CustomTextStyles.bodyLargeDMSansRegular,
                                  )
                                : Text(""),
                            _buildLatitudeSection(context),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                "Address".tr,
                                style: CustomTextStyles.titleMediumBluegray900,
                              ),
                            ),
                            const SizedBox(height: 7),
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  _buildCountry(context),
                                  _buildRegion(context)
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  _buildPincode(context),
                                  _buildCity(context),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.v),
                            _buildAddress(context),
                            SizedBox(height: 20.v),
                            CustomOutlinedButton(
                              onPressed: () {
                                print(selectedValue);
                                if (_formKey.currentState!.validate()) {
                                  Devices().registerDevice(
                                      deviceIDvalueController.text,
                                      nameController.text,
                                      latitudedb.text,
                                      longitudedb.text,
                                      selectedValue == 1 ? true : false,
                                      token.toString(),
                                      country.text,
                                      pincode.text,
                                      region.text,
                                      address.text,
                                      selectedValue == 1
                                          ? total.toString()
                                          : default_value.toString(),
                                      city.text,
                                      context);
                                }
                              },
                              height: 50,
                              //margin: EdgeInsets.only(left: 10),
                              width: 365.h,
                              text: "Save".tr,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green),
                              buttonTextStyle: CustomTextStyles
                                  .headlineSmallPoppinsWhiteA70001,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
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

  Widget _buildCountry(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 6,
      ),
      child: SizedBox(
        width: 150.h,
        child: CustomTextFormField(
          controller: country,
          hintText: "Country*".tr,
          //   textInputAction: TextInputAction.done,
          //textInputType: TextInputType.visiblePassword,
          prefixConstraints: const BoxConstraints(
            maxHeight: 45,
          ),
          //obscureText: true,
        ),
      ),
    );
  }

  Widget _buildRegion(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: SizedBox(
        width: 150.h,
        child: CustomTextFormField(
          controller: region,
          hintText: "State*".tr,
          //  textInputAction: TextInputAction.done,
          //textInputType: TextInputType.number,
          prefixConstraints: const BoxConstraints(
            maxHeight: 45,
          ),
          //obscureText: true,
        ),
      ),
    );
  }

  Widget _buildPincode(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 6,
      ),
      child: SizedBox(
        width: 150.h,
        child: CustomTextFormField(
          controller: pincode,
          hintText: "Pincode*".tr,
          //maxLines: 6,

          textInputType: TextInputType.number,
          //  textInputAction: TextInputAction.done,
          //    textInputType: TextInputType.visiblePassword,
          prefixConstraints: const BoxConstraints(
            maxHeight: 45,
          ),
          // obscureText: true,
        ),
      ),
    );
  }

  Widget _buildCity(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: SizedBox(
        width: 150.h,
        child: CustomTextFormField(
          controller: city,
          hintText: "City*".tr,
          textInputAction: TextInputAction.done,
          //       textInputType: TextInputType.visiblePassword,
          prefixConstraints: const BoxConstraints(
            maxHeight: 45,
          ),
          // obscureText: true,
        ),
      ),
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: Container(
        width: 340.h,
        height: 150.v,
        child: TextFormField(
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: address,
//autofocus: true,
          style: CustomTextStyles.bodyLargeDMSansBlack90001,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: "Full Address".tr,
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
  Widget _buildRegisterDeviceSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 48,
      ),
      decoration: AppDecoration.bg,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            decoration: AppDecoration.outlineBlack,
            child: Text(
              "Register Device".tr,
              style: CustomTextStyles.displayMedium48,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: 374,
            margin: const EdgeInsets.only(
              left: 22,
              right: 23,
            ),
            child: Text(
              "Please fill the form below to register your device".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.bodyLargeDMSansRegular,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLatitudeSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 240,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Current location'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
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
                    setState(() {
                      latitude.text = position!.latitude.toString() +
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
                    color: Colors.white,
                    size: 26.h,
                  ),
                )),
                Text(
                  'Auto fill'.tr,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 10,
          ),
          child: SizedBox(
            width: 380.h,
            child: CustomTextFormField(
              controller: latitude,
              hintText: "Latitude".tr + " & " + "Longitude",
              fillColor: Colors.white,
              enabled: false,
              borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  )),
              textInputAction: TextInputAction.done,
              //       textInputType: TextInputType.visiblePassword,
              prefixConstraints: const BoxConstraints(
                maxHeight: 45,
              ),

              // obscureText: true,
            ),
          ),
        ),
      ],
    );
  }
}
