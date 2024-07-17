import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lca/api/device_status_api.dart';
import 'package:lca/api/schedule.dart';
import 'package:lca/model/getschedule.dart';
import 'package:lca/model/type2.dart';
import 'package:lca/model/type3.dart';
import 'package:lca/screens/create_schedule/frame_twenty_screen.dart';
import 'package:lca/screens/view_schedule/view_schedule.dart';
import 'package:lca/widgets/app_bar/appbar_title.dart';
import 'package:lca/widgets/app_bar/custom_app_bar.dart';
import 'package:lca/widgets/app_decoration.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_elevated_button.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/floating_button.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/size_utils.dart';

class Schedule extends StatefulWidget {
  String token;
  int id;
  Schedule({super.key, required this.id, required this.token});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RectangularFloatingActionButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Add Program',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
            Icon(
              Icons.add,
              color: Colors.white,
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FrameTwentyScreen(token: widget.token, id: widget.id)));
        },
      ),
      appBar: _buildAppBar(context),
      body: Sizer(builder: (context, orientation, deviceType) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRowTicketNo(context),
              Expanded(
                flex: 1,
                child: FutureBuilder<type2>(
                    future: valve_detail_typea(widget.id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                            height: 40,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 25.0, right: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Program A'),
                                        Text('NOT SET'),
                                        CustomElevatedButton(width: 100,buttonTextStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FrameTwentyScreen(
                                                              token:
                                                                  widget.token,
                                                              id: widget.id)));
                                            },
                                            text: 
                                              'Create',buttonStyle: CustomButtonStyles.fillOrangeATL15,
                                             ),
                                      ],
                                    ),
                                  ],
                                )));
                      }
                      if (snapshot.hasData) {
                        return Container(
                            height: 50,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Program A'),
                                        Text('SET'),
                                        CustomElevatedButton(buttonTextStyle: CustomTextStyles.titleMediumWhiteA70001,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewScedule(id: widget.id,
                                                            type2data:
                                                                snapshot.data,
                                                          )));
                                            },width: 90,buttonStyle: CustomButtonStyles.fillOrangeA,
                                            text: 
                                              'View',
                                            )
                                      ],
                                    ),
                                    Divider()
                                  ],
                                )));
                      }
                      return Text('');
                    }),
              ),
              Expanded(
                flex: 1,
                child: FutureBuilder<type2>(
                    future: valve_detail_typeb(widget.id.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                            height: 50,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 25.0, right: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Program B'),
                                        Text('NOT SET'),
                                        CustomElevatedButton(buttonTextStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          FrameTwentyScreen(
                                                              token:
                                                                  widget.token,
                                                              id: widget.id)));
                                            },width: 100,
                                            text: 
                                              'Create',buttonStyle: CustomButtonStyles.fillOrangeATL15,
                                            )
                                      ],
                                    ),
                                  ],
                                )));
                      }
                      if (snapshot.hasData) {
                        return Container(
                            height: 50,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Program B'),
                                        Text('SET'),
                                        CustomElevatedButton(buttonTextStyle: CustomTextStyles.titleMediumWhiteA70001,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewScedule(
                                                            type2data:
                                                                snapshot.data,
                                                            id: widget.id,
                                                          )));
                                            },width: 90,buttonStyle: CustomButtonStyles.fillOrangeA,
                                            text:
                                              'View',
                                             )
                                      ],
                                    ),
                                  ],
                                )));
                      }
                      return Text('');
                    }),
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
