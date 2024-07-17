import 'package:intl/intl.dart';
import 'package:lca/api/device_status_api.dart';
import 'package:lca/model/type1.dart';
import 'package:lca/model/type2.dart';
import 'package:lca/screens/create_schedule/widgets/widget_a1.dart';
import 'package:lca/screens/create_schedule/widgets/widget_a2.dart';
import 'package:lca/widgets/custom_image.dart';
import 'package:lca/widgets/custom_outlined_button.dart';
import 'package:lca/widgets/custom_text_form_field.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/image_constant.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:lca/widgets/utils/size_utils.dart';

import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/theme_helper.dart';
import 'package:flutter/material.dart';

class ViewScedule extends StatefulWidget {
  String? token;
  int? id;
  type2? type2data;
  ViewScedule({Key? key, this.id, this.token, this.type2data})
      : super(
          key: key,
        );

  @override
  State<ViewScedule> createState() => _ViewScheduleState();
}

String getTimeString(int value) {
  final int hour = value ~/ 60;
  final int minutes = value % 60;
  return hour !=0 ?
      '${hour.toString().padLeft(2, "0")}hr ${minutes.toString().padLeft(2, "0")}min' :'${minutes.toString().padLeft(2, "0")} min';
}
String ampm(int minutes){
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    // Create a DateTime object for today's date with the calculated hours and minutes
    DateTime time = DateTime(2020, 1, 1, hours, remainingMinutes);

    // Format the DateTime object to a 12-hour format with AM/PM
    String formattedTime = DateFormat.jm().format(time);
return formattedTime;
}
//inal GlobalKey<> childKey = GlobalKey<_A1State>();
class _ViewScheduleState extends State<ViewScedule> {
  final GlobalKey<A1State> childKeya1 = GlobalKey<A1State>();
  GlobalKey<a1State> childKeya2 = GlobalKey<a1State>();

  @override
  Widget build(BuildContext context) {
    int? _selectedButtonIndex = widget.type2data!.c!.m;
   

    return SafeArea(child:
        Scaffold(body: Sizer(builder: (context, orientation, deviceType) {
      return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: FutureBuilder<type1>(
              future: valve_detail_type1(widget.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                int value;
                widget.type2data!.typeId == 2
                    ? value = snapshot.data!.c.wa
                    : value = snapshot.data!.c.wb; // Example value

                if (value == 1) {
                  checkedday = [1, 1, 1, 1, 1, 1, 1];
                } else {
                  if (value >= 128) {
                    value = value - 128;

                    checkedday[6] = 1;
                  }
                  if (value >= 64) {
                    value = value - 64;
                    checkedday[5] = 1;
                  }
                  if (value >= 32) {
                    value = value - 32;
                    checkedday[4] = 1;
                  }
                  if (value >= 16) {
                    value = value - 16;
                    checkedday[3] = 1;
                  }
                  if (value >= 8) {
                    value = value - 8;
                    checkedday[2] = 1;
                  }

                  if (value >= 4) {
                    value = value - 4;
                    checkedday[1] = 1;
                  }
                  if (value >= 2) {
                    value = value - 2;
                    checkedday[0] = 1;
                  }
                }
                 int endtimetime=0;
    for (int i = 0; i < snapshot.data!.c.vc; i++) {
      endtimetime = endtimetime + widget.type2data!.c.vd![i];
    }
                return Column(children: [
                  _buildAppBar(context),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.only(
                        left: 5.h,
                        right: 5,
                        bottom: 5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 28,
                      ),
                      decoration: AppDecoration.ko.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder52,
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Program:",
                                    style: CustomTextStyles
                                        .headlineSmallDMSansBlack90001Bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    height: 45,
                                    width: 110,
                                    child: Center(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.type2data!.typeId == 2
                                                ? "Program A"
                                                : "Program B",
                                            style: TextStyle(
                                              color: appTheme.black900,
                                              fontSize: 16,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder10,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Days",
                                    style: CustomTextStyles
                                        .headlineSmallDMSansBlack90001Bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                /*    Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "to follow the schedule",
                                  style: CustomTextStyles.bodyLargeDMSans,
                                ),
                              ),*/
                                SizedBox(height: 7),
                                _buildDaysGrid(context),
                                SizedBox(height: 45),
                                Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "Mode:",
                                          style: CustomTextStyles
                                              .headlineSmallDMSansBlack90001Bold,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        widget.type2data!.c!.m == 1
                                            ? Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: const Offset(
                                                              0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: MaterialButton(
                                                          elevation: 2,
                                                          color:
                                                              _selectedButtonIndex ==
                                                                      1
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          77,
                                                                          152,
                                                                          221)
                                                                  : Colors
                                                                      .white,
                                                          onPressed: () {},
                                                          child: Container(
                                                            width: 120,
                                                            height: 100,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: [
                                                                  CustomImageView(
                                                                    imagePath:
                                                                        ImageConstant
                                                                            .imgirrigation,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Text(
                                                                    "Irrigation",
                                                                    style:
                                                                        TextStyle(
                                                                      color: appTheme
                                                                          .black900,
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          'DM Sans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: const Offset(
                                                              0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: MaterialButton(
                                                          color:
                                                              _selectedButtonIndex ==
                                                                      2
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      224,
                                                                      153,
                                                                      153)
                                                                  : Colors
                                                                      .white,
                                                          onPressed: () {},
                                                          child: Container(
                                                            width: 120,
                                                            height: 100,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: [
                                                                  CustomImageView(
                                                                    imagePath:
                                                                        ImageConstant
                                                                            .fert,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Text(
                                                                    "Fertigation",
                                                                    style:
                                                                        TextStyle(
                                                                      color: appTheme
                                                                          .black900,
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          'DM Sans',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                      ]),
                                ),
                                SizedBox(height: 41),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 5, bottom: 25, right: 5),
                                        child: Text(
                                          "Start Time  : ",
                                          style: theme.textTheme.titleLarge,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          //    _selectTime(context);
                                        },
                                        child: CustomTextFormField(
                                          autofocus: false,
                                          focusNode: FocusNode(),
                                          controller: starttime,
                                          enabled: false,
                                          width: 120,
                                          hintText:
                                              widget.type2data!.typeId == 2
                                                  ?ampm(
                                                      snapshot.data!.c.st[0])
                                                  : ampm(
                                                      snapshot.data!.c.st[2]),
                                          hintStyle:
                                              CustomTextStyles.titleMediumLibreFranklinOnPrimary,
                                           textInputType: TextInputType.number,
                                         
                                          contentPadding: EdgeInsets.only(
                                              left: 10, top: 20),
                                          //contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
                                        ),
                                      ),
                                    
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 31),
                                Padding(
                                  padding: EdgeInsets.only(left: 3),
                                  child: Text(
                                    "Valve Duration  : ",
                                    style: CustomTextStyles
                                        .headlineSmallDMSansBlack90001Bold,
                                  ),
                                ),
                                SizedBox(height: 27),
                                _selectedButtonIndex == 1
                                    ? _durationtwo(context, snapshot.data!.c.vc)
                                    : (_selectedButtonIndex == 2
                                        ? _durationfour(
                                            context, snapshot.data!.c.vc)
                                        : _durationtwo(
                                            context, snapshot.data!.c.vc)),
                                SizedBox(height: 25),
                                Container(
                                    width: 286,
                                    margin: EdgeInsets.only(left: 45),
                                    child: Text(
                                            "Total Time for valves is ${getTimeString(endtimetime)}",  
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyles
                                                .bodyLargeDMSans,
                                          )),
                                SizedBox(height: 25),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 25,
                                        ),
                                        child: Text(
                                          "End Time  : ",
                                          style: theme.textTheme.titleLarge,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 26.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: CustomTextFormField(
                                          width: 140.h,
                                          enabled: false,
                                      hintStyle: 
    CustomTextStyles.titleMediumLibreFranklinOnPrimary,
                                         
                                          hintText:  widget.type2data!.typeId == 2
                                                  ? ampm(
                                                      snapshot.data!.c.st[0]+endtimetime)
                                                  : ampm(
                                                      snapshot.data!.c.st[2]+endtimetime),    contentPadding: EdgeInsets.only(
                                              left: 20, top: 20),
                                          //contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 35),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 5,
                                          bottom: 25,
                                        ),
                                        child: Text(
                                          "Start Time 2 : ",
                                          style: theme.textTheme.titleLarge,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                      ),
                                      CustomTextFormField(
                                        width: 140.h,
                                        enabled: false,
                                        hintStyle:
                                             CustomTextStyles.titleMediumLibreFranklinOnPrimary,
                                         
                                        hintText: widget.type2data!.typeId == 2
                                            ? ampm(
                                                snapshot.data!.c.st[1])
                                            : ampm(
                                                snapshot.data!.c.st[3]),
                                        contentPadding:
                                            EdgeInsets.only(left: 20, top: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          ]))
                ]);
              }));
    })));
  }

  String convertTime(TimeOfDay time) {
    int hours = time.hour;
    int minutes = time.minute;

    // Convert minutes more than 60 to valid hours and minutes
    while (minutes >= 60) {
      hours += 1;
      minutes -= 60;
    }

    // Adjust hours to be within 24-hour format

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
  }

  Widget _durationtwo(BuildContext context, int vc) {
    return SizedBox(
      height: vc * 70,
      width: 500.h,
      child: ListView.builder(

          //  scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vc,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 10, right: 5),
                    child: Text(
                      "V${index + 1} : ",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  _buildValveOne(context, index),
                ],
              ),
            );
          }),
    );
  }

  List days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thrusday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List checkedday = [0, 0, 0, 0, 0, 0, 0];
  Widget _buildDaysGrid(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: 22.h,
          right: 30.h,
        ),
        child: Container(
          height: 220,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 47,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              String day = days[index];
              //    Color _colorContainer = dayColors[day] ?? Colors.white;
              return Align(
                alignment: Alignment.center,
                child: Ink(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 250.v,
                      width: 1552.h,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(180, 246, 202, 1),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              days[index],
                              style: TextStyle(
                                color: appTheme.black900,
                                fontSize: 16,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: checkedday[index] == 0
                                      ? Colors.white
                                      : Colors.red),
                            )
                          ],
                        ),
                      )),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildValveOne(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          width: 150,
          hintStyle: CustomTextStyles.bodyMediumInter,
          enabled: false,
          textInputType: TextInputType.number,
          hintText: "${getTimeString(widget.type2data!.c.vd![index])}",
          contentPadding: EdgeInsets.only(left: 10, top: 20),
          // contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
        ),
      ],
    );
  }

  Widget _durationfour(BuildContext context, int vc) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.center,
          children: [SizedBox(width: 10,),
            Text(
              'Prewet',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Fertilize',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Flush',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Total',
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        Container(
          height: vc * 40.h,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: vc,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                        right: 9,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "V${index + 1}: ",
                            style: theme.textTheme.titleLarge,
                          ),
                    
                          for (var i = 0; i < 3; i++)
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                         style: CustomTextStyles.titleLargeGray50003,
            
                                 i == 0
                                      ? '${widget.type2data!.c.pwd![index].toString()}min'
                                      : i == 1
                                          ? '${widget.type2data!.c.frtd![index]}min'
                                              .toString()
                                          : '${widget.type2data!.c.frtd![index]}min'
                                              .toString(),
                               
                    
                                  // contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
                                ),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              getTimeString(widget.type2data!.c.vd![index]),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          //  _dropdown(context),
                        ],
                      ),
                    ),Divider()
                  ],
                );
              }),
        ),
      ],
    );
  }

  String _calculateTotal(List<TimeOfDay> times) {
    int totalHours = 0;
    int totalMinutes = 0;
    times.forEach((time) {
      totalHours += time.hour;
      totalMinutes += time.minute;
    });
    totalHours += totalMinutes ~/ 60;
    totalMinutes %= 60;
    return '${totalHours.toString().padLeft(2, '0')}:${totalMinutes.toString().padLeft(2, '0')}';
  }

  int totalhfer = 0;
  int totalmfer = 0;

  /// Section Widget
  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: AppDecoration.bg,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CustomAppBar(
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  )),
              height: 40,
              centerTitle: true,
              title: AppbarSubtitle(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Program",
                margin: EdgeInsets.only(left: 6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buidProgramsGrid(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: 15.h,
          right: 30.h,
        ),
        child: Container(
          height: 50,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 47,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      height: 45,
                      width: 202,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.type2data!.typeId == 2
                                  ? "Program A"
                                  : "Program B",
                              style: TextStyle(
                                color: appTheme.black900,
                                fontSize: 16,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      )),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
