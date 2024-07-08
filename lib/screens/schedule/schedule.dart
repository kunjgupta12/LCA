import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lca/api/schedule.dart';
import 'package:lca/model/getschedule.dart';
import 'package:lca/screens/frame_twenty_screen/frame_twenty_screen.dart';
import 'package:lca/widgets/app_bar/appbar_title.dart';
import 'package:lca/widgets/app_bar/custom_app_bar.dart';
import 'package:lca/widgets/app_decoration.dart';
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
          child: Column(
            children: [
              _buildRowTicketNo(context),
              Expanded(
                child: FutureBuilder<List<GetSchedule>>(
                    future: schedule_get(widget.id, widget.token),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        return Container(
                          height: 200,
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 23),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data![index].program == 1
                                              ? 'Program A'
                                              : "Program B"),
                                          Text(snapshot.data![index].startTime.toString() =="null"
                                                
                                              ? 'NOT SET'
                                              : 'SET'),
                                        ],
                                      ),Divider()
                                    ],
                                  ),
                                );
                              }),
                        );
                      }
                      return CircularProgressIndicator();
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
            Padding(
              padding: EdgeInsets.only(right: 5.h),
              child: Text(
                "Status",
                style: theme.textTheme.titleLarge,
              ),
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
