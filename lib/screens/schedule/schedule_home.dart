import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lca/api/device/device_status_api.dart';
import 'package:lca/model/device_status/type1.dart';
import 'package:lca/screens/create_schedule/frame_twenty_screen.dart';
import 'package:lca/screens/schedule/view_schedule.dart';
import 'package:lca/widgets/app_bar/appbar_title.dart';
import 'package:lca/widgets/app_bar/custom_app_bar.dart';
import 'package:lca/widgets/app_decoration.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_elevated_button.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:get/get.dart';

class Schedule extends StatefulWidget {
  final String token;
  final int id;
  final String iemi;
  final String name;
int valve;
   Schedule({
    Key? key,required this.valve,
    required this.token,
    required this.id,
    required this.iemi,
    required this.name,
  }) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  Timer? _timer;
  type1? type1data;

  @override
  void initState() {
    super.initState();
    getData();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  Future<void> getData() async {
    type1data = await valve_detail_type1(widget.id.toString());
    setState(() {
      type1data = type1data;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      try {
        if (type1data == null) {
          type1data = await valve_detail_type1(widget.id.toString());
          setState(() {
            type1data = type1data;
          });
        }
      } catch (e) {
        showToast(context,'Waiting for device to respond');
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Sizer(builder: (context, orientation, deviceType) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDeviceInfoRow("Device Name", widget.name),
              const SizedBox(height: 5),
              _buildDeviceInfoRow("Device IMEI", widget.iemi),
              _buildHeaderRow(context),
              _buildScheduleList(),
              _buildConfigureButton(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDeviceInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            "$label:".tr,
            style: CustomTextStyles.headlineSmallDMSansBlack90001Bold,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: TextStyle(
            color: appTheme.gray70001,
            fontSize: 20,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(right: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 11.v),
        decoration: AppDecoration.fillGrayF.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
          color: Colors.amber,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Program".tr, style: theme.textTheme.titleLarge),
            Text("Status".tr, style: theme.textTheme.titleLarge),
            Text("Action".tr, style: theme.textTheme.titleLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleList() {
    return Expanded(
      flex: 2,
      child: type1data == null ? _buildLoadingList() : _buildLoadedList(),
    );
  }

  Widget _buildLoadingList() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(index == 0 ? 'Program A'.tr : "Program B".tr),
                  CircularProgressIndicator(),
                  CustomElevatedButton(
                    isDisabled: true,
                    buttonTextStyle: CustomTextStyles.titleMediumWhiteA70001,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewScedule(
                            iemi: widget.iemi,
                            name: widget.name,
                            type: index,
                            type1data: type1data,
                            id: widget.id,
                          ),
                        ),
                      );
                    },
                    width: 110.h,
                    buttonStyle: CustomButtonStyles.fillOnError,
                    text: 'View'.tr,
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadedList() {
    var check = type1data!.c.m;
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(index == 0 ? 'Program A'.tr : "Program B".tr),
                  Text(check[index] != 0 ? 'SET'.tr : 'NOT SET'.tr),
                  CustomElevatedButton(
                    isDisabled: check[index] == 0,
                    buttonTextStyle: CustomTextStyles.titleMediumWhiteA70001,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewScedule(
                            iemi: widget.iemi,
                            name: widget.name,
                            type: index,
                            type1data: type1data,
                            id: widget.id,
                          ),
                        ),
                      );
                    },
                    width: 110.h,
                    buttonStyle: check[index] != 0
                        ? CustomButtonStyles.fillOrangeA
                        : CustomButtonStyles.fillOnError,
                    text: 'View'.tr,
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildConfigureButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: CustomElevatedButton(
        text: 'Configure'.tr,
        buttonStyle: CustomButtonStyles.fillOrangeA,
        buttonTextStyle: CustomTextStyles.titleLargeWhiteA70001,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FrameTwentyScreen(valve:widget.valve,
                token: widget.token,
                id: widget.id,
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 2, top: 27, bottom: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppbarTitle(text: "My Programs".tr),
          ],
        ),
      ),
      styleType: Style.bgGradientnamelightgreenA700namegreen800aa,
    );
  }
}
