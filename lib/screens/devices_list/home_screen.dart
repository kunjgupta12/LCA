import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lca/api/api.dart';
import 'package:lca/api/complaints.dart';
import 'package:lca/api/config.dart';
import 'package:lca/model/complaint_issue.dart';
import 'package:lca/screens/complaint_detail/complaint_detail.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/device.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/theme_helper.dart';

class FrameEighteenScreen extends StatefulWidget {
  String? data;
  String? token;
  FrameEighteenScreen({Key? key, this.data, this.token})
      : super(
          key: key,
        );

  @override
  State<FrameEighteenScreen> createState() => _FrameEighteenScreenState();
}

class _FrameEighteenScreenState extends State<FrameEighteenScreen> {
  List<Device>? devices = [];
  Future<List<Issue>>? issues;
  @override
  void initState() {
    print('good data:${widget.data}');
    List<dynamic> jsonData = json.decode(widget.data.toString())['content'];
    devices = jsonData.map((data) => Device.fromJson(data)).toList();
    // TODO: implement initState
   // issues=fetchDataissue(widget.token.toString());
   
    super.initState();
  }

  TextEditingController deviceidSectionController = TextEditingController();

  TextEditingController nameSectionController = TextEditingController();

  TextEditingController issueCounterSectionController = TextEditingController();

  TextEditingController descriptionSectionController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      _buildThreeSection(context),
                      SizedBox(height: 17),
                      Container(
                        width: 389.h,
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 15,
                        ),
                        /* decoration: AppDecoration.ko.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder52,
                        ),*/
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 9),
                            Text(
                              "Complaint".tr,
                              style: TextStyle(
                                  color: Colors.green.shade500,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 28),
                            ),
                            Divider(
                              color: appTheme.gray400,
                              endIndent: 15,
                            ),
                            SizedBox(height: 36),
                            Text(
                              "Device IMEI".tr,
                              style: CustomTextStyles.titleMediumBluegray900,
                            ),
                            SizedBox(height: 16),
                            _buildDeviceidSection(context),
                            SizedBox(height: 14),
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text(
                                "Device Name".tr,
                                style: CustomTextStyles.titleMediumBluegray900,
                              ),
                            ),
                            SizedBox(height: 16),
                            _buildNameSection(context),
                            SizedBox(height: 14),
                            Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Text(
                                "Problem",
                                style: CustomTextStyles.titleMediumBluegray900,
                              ),
                            ),
                            SizedBox(height: 16),
                            _buildIssueCounterSection(context),
                            SizedBox(height: 14),
                            Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Text(
                                "Add Note",
                                style: CustomTextStyles.titleMediumBluegray900,
                              ),
                            ),
                            SizedBox(height: 17),
                            _buildDescriptionSection(context),
                            SizedBox(height: 18),
                            _buildSubmitSection(context),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
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
  Widget _buildThreeSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 9,
      ),
      decoration: AppDecoration.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 1),
                child: Text(
                  "< Back".tr,
                  style: CustomTextStyles.titleLargePoppinsGray600,
                ),
              )),
          SizedBox(height: 25),
          Center(
            child: Container(
              decoration: AppDecoration.outlineBlack,
              child: Text(
                "Register Complaint".tr,
                style: theme.textTheme.displayMedium,
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 400,
            margin: EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              "Please fill the form below to register you complaint.".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.bodyLargeDMSansRegular,
            ),
          ),
          SizedBox(height: 38),
        ],
      ),
    );
  }

  Device? selectedDevice;
  String? selectedItem;

  /// Section Widget
  Widget _buildDeviceidSection(BuildContext context) {
    return widget.data != null
        ? DropdownButtonFormField<Device>(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(15),
              ),
              focusColor: Colors.green,
              iconColor: Colors.green,
              contentPadding: const EdgeInsets.symmetric(vertical: 2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            hint: Text(selectedDevice?.toString() ?? 'Device ID'),
            value: selectedDevice,
            onChanged: (Device? newValue) {
              setState(() {
                selectedDevice = newValue;
              });
            },
            items: devices!.map<DropdownMenuItem<Device>>((Device apiResponse) {
              return DropdownMenuItem<Device>(
                  value: apiResponse,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(apiResponse.title.toString()),
                  ));
            }).toList(),
          )
        : CircularProgressIndicator();
  }
int? device_name=0;
  /// Section Widget
  Widget _buildNameSection(BuildContext context) {
    return DropdownButtonFormField<Device>(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(15),
        ),
        focusColor: Colors.green,
        iconColor: Colors.green,
        contentPadding: const EdgeInsets.symmetric(vertical: 2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      hint: Text(selectedDevice?.toString() ?? 'Device Name'),
      value: selectedDevice,
      onChanged: (Device? newValue) {
        setState(() {
          selectedDevice = newValue;
          device_name=selectedDevice!.id;
        });
      },
      items: devices!.map<DropdownMenuItem<Device>>((Device device) {
        return DropdownMenuItem<Device>(
            value: device,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(device.imei.toString()),
            ));
      }).toList(),
    ); /*Padding(
      padding: EdgeInsets.only(right: 15),
      child: CustomTextFormField(
        controller: nameSectionController,
        hintText: "Device Name".tr,
        hintStyle: CustomTextStyles.bodyLargeDMSansBluegray500,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 9,
        ),
      ),
    );*/
  }

  String? selectedissue;
int?  problem_id;
  /// Section Widget
  Widget _buildIssueCounterSection(BuildContext context) {
    

   //IssueProvider dataProvider = Provider.of<IssueProvider>(context);
    return Consumer<IssueProvider>(
       builder: (context, dataProvider, child) {
        if (dataProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (dataProvider.errorMessage != null) {
          return Center(child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Reload"),
                IconButton(onPressed: (){dataProvider.fetchissues(widget.token.toString());}, icon: Icon(Icons.replay_outlined)),
              ],
            ),
          ) );
        } else {
    /*  future: issues,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Issue>? categories = snapshot.data;*/
          return DropdownButtonFormField<Issue>(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(15),
              ),
              focusColor: Colors.green,
              iconColor: Colors.green,
              contentPadding: const EdgeInsets.symmetric(vertical: 2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            hint: Text(selectedissue?.toString() ?? 'Select Issue'),
            value: null,
            onChanged: (Issue? issue) {
              print('Selected category: ${issue!.title}');
              setState(() {
                selectedissue = issue.title;
                problem_id=issue.id;
              });
            },
            items: dataProvider.devices.map<DropdownMenuItem<Issue>>((Issue category) {
              return DropdownMenuItem<Issue>(
                value: category,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(category.title.toString()),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  /// Section Widget
  Widget _buildDescriptionSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: Container(
        height: 200,
        child: CustomTextFormField(
            controller: descriptionSectionController,
            hintText: "Additional Information....",
            hintStyle: CustomTextStyles.bodyLargeDMSansBluegray500,
            textInputAction: TextInputAction.done,
            maxLines: 15,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 21,
              vertical: 30,
            )),
      ),
    );
  }

  /// Section Widget
  Widget _buildSubmitSection(BuildContext context) {
    return CustomElevatedButton(
      height: 57.v,
      width: 450.h,
      text: "Next".tr,
      onPressed: () {
        print(device_name);
        if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FrameThirtyfiveScreen(iemi: selectedDevice!.imei.toString(),name: selectedDevice!.title,note: descriptionSectionController.text,problem: selectedissue,device_id: selectedDevice!.id,problem_id: problem_id,token: widget.token.toString(),)));
        }
      },
      //buttonStyle: CustomButtonStyles.none,
      //  decoration: CustomButtonStyles.gradientIndigoAToPurpleADecoration,
      buttonTextStyle: CustomTextStyles.headlineSmallPoppinsWhiteA70001,
      buttonStyle: CustomButtonStyles.fillOnError.copyWith(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          // If the button is pressed, return green, otherwise blue
          if (states.contains(MaterialState.pressed)) {
            return Colors.green;
          }
          return Colors.green;
        }),
      ),
      alignment: Alignment.center,
    );
  }
}
