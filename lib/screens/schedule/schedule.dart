import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lca/api/device_status_api.dart';
import 'package:lca/api/schedule.dart';
import 'package:lca/model/getschedule.dart';
import 'package:lca/model/type1.dart';
import 'package:lca/model/type2.dart';
import 'package:lca/model/type3.dart';
import 'package:lca/screens/create_schedule/frame_twenty_screen.dart';
import 'package:lca/screens/schedule/view_schedule.dart';
import 'package:lca/widgets/app_bar/appbar_title.dart';
import 'package:lca/widgets/app_bar/custom_app_bar.dart';
import 'package:lca/widgets/app_decoration.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_elevated_button.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/floating_button.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:provider/provider.dart';

class Schedule extends StatefulWidget {
  String token;
  int id;
  String iemi;
  String name;
  Schedule(
      {super.key,
      required this.id,
      required this.token,
      required this.name,
      required this.iemi});

  @override
  State<Schedule> createState() => _ScheduleState();
}

Timer? _timer;

class _ScheduleState extends State<Schedule> {
  @override
  void initState() {
    // TODO: implement initState
    getdata();
    _startTimer();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose'
    _stopTimer();

    super.dispose();
  }

  Future<void> getdata() async {
    type1data = await valve_detail_type1(widget.id.toString());
    setState(() {
      type1data=type1data;
    });
  }

  type1? type1data;
  void _startTimer() async {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      try {
        if (type1data == null)
          setState(() async {
            type1data = await valve_detail_type1(widget.id.toString());
          });
      } catch (e) {
        showToast('Waiting for device to respond');
      }
     
      print('send');
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: _buildAppBar(context),
      body: Sizer(builder: (context, orientation, deviceType) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Device Name:",
                      style: CustomTextStyles.headlineSmallDMSansBlack90001Bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: appTheme.gray70001,
                      fontSize: 20,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "Device IEMI:",
                      style: CustomTextStyles.headlineSmallDMSansBlack90001Bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.iemi,
                    style: TextStyle(
                      color: appTheme.gray70001,
                      fontSize: 20,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              _buildRowTicketNo(context),
              Expanded(
                  flex: 2,
                  child: Container(
                      child: type1data == null
                          ? ListView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Container(
                                    height: 60,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 5),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(index == 0
                                                    ? 'Program A'
                                                    : "Program B"),
                                                CircularProgressIndicator(),
                                                CustomElevatedButton(
                                                    isDisabled: true,
                                                    buttonTextStyle:
                                                        CustomTextStyles
                                                            .titleMediumWhiteA70001,
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ViewScedule(
                                                                        iemi: widget
                                                                            .iemi,
                                                                        name: widget
                                                                            .name,
                                                                        type:
                                                                            index,
                                                                        type1data:
                                                                            type1data,
                                                                        id: widget
                                                                            .id,
                                                                      )));
                                                    },
                                                    width: 110.h,
                                                    buttonStyle:
                                                        CustomButtonStyles
                                                            .fillOnError,
                                                    text: 'View')
                                              ],
                                            ),
                                            Divider()
                                          ],
                                        )));
                              })
                          : ListView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                var check = type1data!.c.m;
                                return Container(
                                    height: 60,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(index == 0
                                                    ? 'Program A'
                                                    : "Program B"),
                                                Text(check[index] != 0
                                                    ? 'SET'
                                                    : 'NOT SET'),
                                                CustomElevatedButton(
                                                    isDisabled:
                                                        check[index] != 0
                                                            ? false
                                                            : true,
                                                    buttonTextStyle:
                                                        CustomTextStyles
                                                            .titleMediumWhiteA70001,
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      ViewScedule(
                                                                        iemi: widget
                                                                            .iemi,
                                                                        name: widget
                                                                            .name,
                                                                        type:
                                                                            index,
                                                                        type1data:
                                                                            type1data,
                                                                        id: widget
                                                                            .id,
                                                                      )));
                                                    },
                                                    width: 110.h,
                                                    buttonStyle:
                                                        check[index] != 0
                                                            ? CustomButtonStyles
                                                                .fillOrangeA
                                                            : CustomButtonStyles
                                                                .fillOnError,
                                                    text: 'View')
                                              ],
                                            ),
                                            Divider(),
                                          ],
                                        )));
                              }))),Padding(
                                padding: const EdgeInsets.only(bottom: 20.0,left: 10,right: 10),
                                child: CustomElevatedButton(text: 'Configure', buttonStyle: CustomButtonStyles.fillOrangeA,buttonTextStyle: CustomTextStyles.titleLargeWhiteA70001,  onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FrameTwentyScreen(token: widget.token, id: widget.id)));
                                        },),
                              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildRowTicketNo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(right: 1.h),
        padding: EdgeInsets.symmetric(
          horizontal: 14.h,
          vertical: 11.v,
        ),
        decoration: AppDecoration.fillGrayF.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder4,
            color: Colors.amber),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Program",
              style: theme.textTheme.titleLarge,
            ),
            Text(
              "Status",
              style: theme.textTheme.titleLarge,
            ),
            Text(
              'Action',
              style: theme.textTheme.titleLarge,
            )
          ],
        ),
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
              text: "My Programs",
            ),
          ],
        ),
      ),
      styleType: Style.bgGradientnamelightgreenA700namegreen800aa,
    );
  }
}
