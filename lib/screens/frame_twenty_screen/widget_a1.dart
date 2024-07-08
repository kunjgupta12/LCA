import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lca/api/api.dart';
import 'package:lca/model/schedule_model.dart';
import 'package:lca/screens/frame_twenty_screen/frame_twenty_screen.dart';
import 'package:lca/screens/register_device/register_device.dart';
import 'package:lca/widgets/custom_image.dart';
import 'package:lca/widgets/custom_outlined_button.dart';
import 'package:lca/widgets/custom_text_form_field.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/image_constant.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:lca/widgets/utils/size_utils.dart';

/// Section Widget
///
///
int? _selectedButtonIndex = 1;
TimeOfDay _selectedTime = TimeOfDay(hour: 00, minute: 00);
TimeOfDay _selectedTime2 = TimeOfDay(hour: 00, minute: 00);
TextEditingController starttime = TextEditingController();
TextEditingController starttime2 = TextEditingController();
List<List<TimeOfDay>> selectedTimefer = List.generate(
    12,
    (index) => [
          TimeOfDay(hour: 0, minute: 0),
          TimeOfDay(hour: 0, minute: 0),
          TimeOfDay(hour: 0, minute: 0)
        ]);
List<TimeOfDay> selectedTimes =
    List.generate(12, (index) => TimeOfDay(hour: 0, minute: 0));
int? totalm = 0;
int? totalh = 0;

class a1 extends StatefulWidget {
  int? transition;
  TimeOfDay? end;
  final ValueChanged<int> onValueChanged;
  a1({Key? key, this.end, this.transition, required this.onValueChanged})
      : super(key: key);

  @override
  A1State createState() => A1State();
}

class A1State extends State<a1> {
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        print("${_selectedTime.hour}:${_selectedTime.minute}");

        //schedule=Schedule(programA: ProgramA(startTime:"${_selectedTime.hour.toString}:${_selectedTime.minute}"));
        starttime.text = _selectedTime.hour.toString().padLeft(2, '0') +
            ":" +
            _selectedTime.minute.toString().padLeft(2, '0');
      });
    }
  }

  Future<void> _selectTime2(BuildContext context) async {
    final TimeOfDay? picked2 = await showTimePicker(
      context: context,
      initialTime: _selectedTime2,
    );
    if (picked2 != null && picked2 != _selectedTime2) {
      if (picked2.hour * 60 + picked2.minute >
              totalh! * 60 +
                  totalm! +
                  _selectedTime.hour.toInt() * 60 +
                  _selectedTime.minute &&
          _selectedButtonIndex == 1) {
        setState(() {
          _selectedTime2 = picked2;
          print(_selectedTime2.hour * 60 + _selectedTime2.minute > 0);
          starttime2.text = _selectedTime2.hour.toString().padLeft(2, '0') +
              ":" +
              _selectedTime2.minute.toString().padLeft(2, '0');

          a1_end = TimeOfDay(
              hour: picked2.hour + totalh!, minute: picked2.minute + totalm!);
        });
      }
      if (picked2.hour * 60 + picked2.minute >
              totalhfer * 60 +
                  totalmfer +
                  _selectedTime.hour.toInt() * 60 +
                  _selectedTime.minute &&
          _selectedButtonIndex == 2) {
        setState(() {
          _selectedTime2 = picked2;
          a1_end = TimeOfDay(
              hour: picked2.hour + totalhfer,
              minute: picked2.minute + totalmfer);
          starttime2.text = _selectedTime2.hour.toString().padLeft(2, '0') +
              ":" +
              _selectedTime2.minute.toString().padLeft(2, '0');
          // totalh = _selectedTime.hour;
          // totalh += _selectedTime.hour.toInt();
        });
      } else if (picked2.hour * 60 + picked2.minute <
                  totalh! * 60 +
                      totalm! +
                      _selectedTime.hour.toInt() * 60 +
                      _selectedTime.minute &&
              _selectedButtonIndex == 1 ||
          picked2.hour * 60 + picked2.minute >
                  totalhfer * 60 +
                      totalmfer +
                      _selectedTime.hour.toInt() * 60 +
                      _selectedTime.minute &&
              _selectedButtonIndex == 2) {
        showToast("Please select after end time");
      }
    }
  }

  List<Color> _colorContainera1 = List.generate(7, (index) => Colors.white);
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Select Days",
              style: CustomTextStyles.headlineSmallDMSansBlack90001Bold,
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "to follow the schedule",
              style: CustomTextStyles.bodyLargeDMSans,
            ),
          ),
          SizedBox(height: 7),
          _buildDaysGrid(context),
          SizedBox(height: 45),
          Text(
            "Mode",
            style: CustomTextStyles.headlineSmallDMSansBlack90001Bold,
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: MaterialButton(
                              elevation: 2,
                              color: _selectedButtonIndex == 1
                                  ? Color.fromARGB(255, 77, 152, 221)
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  _selectedButtonIndex = 1;
                                  print(_selectedButtonIndex);
                                });
                              },
                              child: Container(
                                width: 120,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgirrigation,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Irrigation",
                                        style: TextStyle(
                                          color: appTheme.black900,
                                          fontSize: 18,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: MaterialButton(
                              color: _selectedButtonIndex == 2
                                  ? const Color.fromARGB(255, 224, 153, 153)
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  _selectedButtonIndex = 2;
                                  print(_selectedButtonIndex);
                                });
                              },
                              child: Container(
                                width: 120,
                                height: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.fert,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Fertigation",
                                        style: TextStyle(
                                          color: appTheme.black900,
                                          fontSize: 18,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
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
          /*  SizedBox(height: 45),
          Text(
            "Program title",
            style: CustomTextStyles.headlineSmallDMSansBlack90001Bold,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Give your schedule a name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),*/
          SizedBox(height: 41),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 25, right: 5),
                  child: Text(
                    "Start Time  : ",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: CustomTextFormField(
                    autofocus: false,
                    focusNode: FocusNode(),
                    controller: starttime,
                    enabled: false,
                    width: 120,
                    hintText: "00:00 hrs",
                    hintStyle: CustomTextStyles.bodyMediumInter,
                    fillColor: Colors.white,
                    textInputType: TextInputType.number,
                    borderDecoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: BorderSide(color: Colors.grey)),
                    contentPadding: EdgeInsets.only(left: 10, top: 20),
                    //contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 18,
                  ),
                  child: IconButton(
                      onPressed: () {
                        _selectTime(context);
                      },
                      icon: Icon(
                        Icons.alarm,
                        color: Colors.green,
                      )),
                )
              ],
            ),
          ),
          SizedBox(height: 31),
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              "Valve Duration  : ",
              style: CustomTextStyles.headlineSmallDMSansBlack90001Bold,
            ),
          ),
          SizedBox(height: 27),
          _selectedButtonIndex == 1
              ? _durationtwo(context)
              : (_selectedButtonIndex == 2
                  ? _durationfour(context)
                  : _durationtwo(context)),
          SizedBox(height: 25),
          Container(
              width: 236,
              margin: EdgeInsets.only(left: 55),
              child: _selectedButtonIndex == 1
                  ? Text(
                      "Total Time for valves is \n${totalh! /* + _selectedTime.hour.toInt()*/} hours and ${totalm! /* + _selectedTime.minute.toInt()*/} minutes",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodyLargeDMSans,
                    )
                  : Text(
                      "Total Time for valves is \n${totalhfer /* + _selectedTime.hour.toInt()*/} hours and ${totalmfer! /* + _selectedTime.minute.toInt()*/} minutes",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodyLargeDMSans,
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
                  onTap: () {
                    setState(() {});
                  },
                  child: CustomTextFormField(
                    width: 110.h,
                    enabled: false,
                    hintStyle: CustomTextStyles.bodyMediumInter,

                    hintText: _selectedButtonIndex == 1
                        ? totalh! +
                                    _selectedTime.hour.toInt() +
                                    totalm! +
                                    _selectedTime.minute.toInt() ==
                                0
                            ? '00:00 hrs'
                            : '${convertTime(TimeOfDay(hour: totalh! + _selectedTime.hour, minute: totalm! + _selectedTime.minute.toInt()))} '

                        /*      ':' +
                                '${totalm! + _selectedTime.minute.toInt()}'
                                    .toString()
                                    .padLeft(2, '0')*/
                        : totalhfer +
                                    _selectedTime.hour.toInt() +
                                    totalmfer +
                                    _selectedTime.minute.toInt() ==
                                00
                            ? '00:00 hrs'
                            : '${convertTime(TimeOfDay(hour: totalhfer! + _selectedTime.hour, minute: totalmfer! + _selectedTime.minute.toInt()))} ',
                    fillColor: Colors.white,
                    borderDecoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: BorderSide(color: Colors.grey)),
                    contentPadding: EdgeInsets.only(left: 20, top: 20),
                    //contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectTime2(context);
                    });
                  },
                  child: CustomTextFormField(
                    width: 110.h,
                    enabled: false,
                    hintStyle: CustomTextStyles.bodyMediumInter,

                    hintText: _selectedButtonIndex == 1
                        ? totalh! +
                                    _selectedTime.hour.toInt() +
                                    totalm! +
                                    _selectedTime.minute.toInt() ==
                                0
                            ? '00:00 hrs'
                            : '${_selectedTime2.hour.toInt()}'
                                    .toString()
                                    .padLeft(2, '0') +
                                ':' +
                                '${_selectedTime2.minute.toInt()}'
                                    .toString()
                                    .padLeft(2, '0')
                        : totalhfer +
                                    _selectedTime.hour.toInt() +
                                    totalmfer +
                                    _selectedTime.minute.toInt() ==
                                0
                            ? '00:00 hrs'
                            : '${_selectedTime2.hour.toInt()}'
                                    .toString()
                                    .padLeft(2, '0') +
                                ':' +
                                '${_selectedTime2.minute.toInt()}'
                                    .toString()
                                    .padLeft(2, '0'),
                    fillColor: Colors.white,
                    borderDecoration: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: BorderSide(color: Colors.grey)),
                    contentPadding: EdgeInsets.only(left: 20, top: 20),
                    //contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedTime2 = TimeOfDay(hour: 0, minute: 0);
                        _selectedButtonIndex == 1
                            ? a1_end = TimeOfDay(
                                hour: totalh! + _selectedTime.hour.toInt(),
                                minute: totalm! + _selectedTime.minute.toInt())
                            : a1_end = TimeOfDay(
                                hour: totalhfer + _selectedTime.hour.toInt(),
                                minute:
                                    totalmfer! + _selectedTime.minute.toInt());
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 25,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Reset',
                            style: CustomTextStyles.bodyLargeDMSansRegular,
                          ),
                          Icon(
                            Icons.replay,
                            color: Colors.black,
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
          (a1_end!.hour >= 24 && a1_end!.minute >= 0)
              /*    (_selectedButtonIndex == 1 &&
                      totalh! + _selectedTime.hour + _selectedTime2.hour >=
                          24 &&
                      totalm! + _selectedTime.minute + _selectedTime2.minute >=
                          0) ||
                  (_selectedButtonIndex == 2 &&
                      totalhfer + _selectedTime.hour + _selectedTime2.hour >=
                          24 &&
                      totalmfer +
                              _selectedTime.minute +
                              _selectedTime2.minute >=
                          0)*/
              ? Center(
                  child: Text(
                  'Time exceeds 24 hours',
                  style: CustomTextStyles.titleMediumPoppinsRedA70001,
                ))
              : SizedBox(height: 4),
          SizedBox(
            height: 10,
          ),
          //   _buildCreateButton(context, widget.transition!.toInt()),
        ],
      );
    });
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

  ProgramA updateA() {
    setState(() {
      //transitioon==1;
      _selectedTime.hour * 60 + _selectedTime.minute > 0
          ? _selectedButtonIndex == 1
              ? programA = ProgramA(
                  mode: true,
                  monday: _colorContainera1[0] == Colors.red ? true : false,
                  tuesday: _colorContainera1[1] == Colors.red ? true : false,
                  wednesday: _colorContainera1[2] == Colors.red ? true : false,
                  thrusday: _colorContainera1[3] == Colors.red ? true : false,
                  friday: _colorContainera1[4] == Colors.red ? true : false,
                  saturday: _colorContainera1[5] == Colors.red ? true : false,
                  sunday: _colorContainera1[6] == Colors.red ? true : false,
                  startTime2: _selectedTime2.hour * 60 + _selectedTime2.minute >
                          0
                      ? "${_selectedTime2.hour.toString().padLeft(2, '0')}:${_selectedTime2.minute.toString().padLeft(2, '0')}"
                      : null,
                  startTime:
                      "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}",
                  programId: 1,
                  valve1: [
                    selectedTimes[0].hour * 60 + selectedTimes[0].minute
                  ],
                  valve2: [
                    selectedTimes[1].hour * 60 + selectedTimes[1].minute
                  ],
                  valve10: [
                    selectedTimes[9].hour * 60 + selectedTimes[9].minute
                  ],
                  valve11: [
                    selectedTimes[10].hour * 60 + selectedTimes[10].minute
                  ],
                  valve12: [
                    selectedTimes[11].hour * 60 + selectedTimes[11].minute
                  ],
                  valve3: [
                    selectedTimes[2].hour * 60 + selectedTimes[2].minute
                  ],
                  valve4: [
                    selectedTimes[3].hour * 60 + selectedTimes[3].minute
                  ],
                  valve5: [
                    selectedTimes[4].hour * 60 + selectedTimes[4].minute
                  ],
                  valve6: [
                    selectedTimes[5].hour * 60 + selectedTimes[5].minute
                  ],
                  valve7: [
                    selectedTimes[6].hour * 60 + selectedTimes[6].minute
                  ],
                  valve8: [
                    selectedTimes[7].hour * 60 + selectedTimes[7].minute
                  ],
                  valve9: [
                    selectedTimes[8].hour * 60 + selectedTimes[8].minute
                  ],
                )
              : programA = ProgramA(
                  mode: false,
                  monday: _colorContainera1[0]! == Colors.red ? true : false,
                  tuesday: _colorContainera1[1] == Colors.red ? true : false,
                  wednesday: _colorContainera1[2] == Colors.red ? true : false,
                  thrusday: _colorContainera1[3] == Colors.red ? true : false,
                  friday: _colorContainera1[4] == Colors.red ? true : false,
                  saturday: _colorContainera1[5] == Colors.red ? true : false,
                  sunday: _colorContainera1[6] == Colors.red ? true : false,
                  startTime2: _selectedTime2.hour * 60 + _selectedTime2.minute >
                          0
                      ? "${_selectedTime2.hour.toString().padLeft(2, '0')}:${_selectedTime2.minute.toString().padLeft(2, '0')}"
                      : null,
                  startTime:
                      "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}",
                  programId: 1,
                  valve1: [
                    selectedTimefer[0][0].hour * 60 +
                        selectedTimefer[0][0].minute,
                    selectedTimefer[0][1].hour * 60 +
                        selectedTimefer[0][1].minute,
                    selectedTimefer[0][2].hour * 60 +
                        selectedTimefer[0][2].minute
                  ],
                  valve2: [
                    selectedTimefer[1][0].hour * 60 +
                        selectedTimefer[1][0].minute,
                    selectedTimefer[1][1].hour * 60 +
                        selectedTimefer[1][1].minute,
                    selectedTimefer[1][2].hour * 60 +
                        selectedTimefer[1][2].minute
                  ],
                  valve10: [
                    selectedTimefer[9][0].hour * 60 +
                        selectedTimefer[9][0].minute,
                    selectedTimefer[9][1].hour * 60 +
                        selectedTimefer[9][1].minute,
                    selectedTimefer[9][2].hour * 60 +
                        selectedTimefer[9][2].minute
                  ],
                  valve11: [
                    selectedTimefer[10][0].hour * 60 +
                        selectedTimefer[10][0].minute,
                    selectedTimefer[10][1].hour * 60 +
                        selectedTimefer[10][1].minute,
                    selectedTimefer[10][2].hour * 60 +
                        selectedTimefer[10][2].minute
                  ],
                  valve12: [
                    selectedTimefer[11][0].hour * 60 +
                        selectedTimefer[11][0].minute,
                    selectedTimefer[11][1].hour * 60 +
                        selectedTimefer[11][1].minute,
                    selectedTimefer[11][2].hour * 60 +
                        selectedTimefer[11][2].minute
                  ],
                  valve3: [
                    selectedTimefer[2][0].hour * 60 +
                        selectedTimefer[2][0].minute,
                    selectedTimefer[2][1].hour * 60 +
                        selectedTimefer[2][1].minute,
                    selectedTimefer[2][2].hour * 60 +
                        selectedTimefer[2][2].minute
                  ],
                  valve4: [
                    selectedTimefer[3][0].hour * 60 +
                        selectedTimefer[3][0].minute,
                    selectedTimefer[3][1].hour * 60 +
                        selectedTimefer[3][1].minute,
                    selectedTimefer[3][2].hour * 60 +
                        selectedTimefer[3][2].minute
                  ],
                  valve5: [
                    selectedTimefer[4][0].hour * 60 +
                        selectedTimefer[4][0].minute,
                    selectedTimefer[4][1].hour * 60 +
                        selectedTimefer[4][1].minute,
                    selectedTimefer[4][2].hour * 60 +
                        selectedTimefer[4][2].minute
                  ],
                  valve6: [
                    selectedTimefer[5][0].hour * 60 +
                        selectedTimefer[5][0].minute,
                    selectedTimefer[5][1].hour * 60 +
                        selectedTimefer[5][1].minute,
                    selectedTimefer[5][2].hour * 60 +
                        selectedTimefer[5][2].minute
                  ],
                  valve7: [
                    selectedTimefer[6][0].hour * 60 +
                        selectedTimefer[6][0].minute,
                    selectedTimefer[6][1].hour * 60 +
                        selectedTimefer[6][1].minute,
                    selectedTimefer[6][2].hour * 60 +
                        selectedTimefer[6][2].minute
                  ],
                  valve8: [
                    selectedTimefer[7][0].hour * 60 +
                        selectedTimefer[7][0].minute,
                    selectedTimefer[7][1].hour * 60 +
                        selectedTimefer[7][1].minute,
                    selectedTimefer[7][2].hour * 60 +
                        selectedTimefer[7][2].minute
                  ],
                  valve9: [
                    selectedTimefer[8][0].hour * 60 +
                        selectedTimefer[8][0].minute,
                    selectedTimefer[8][1].hour * 60 +
                        selectedTimefer[8][1].minute,
                    selectedTimefer[8][2].hour * 60 +
                        selectedTimefer[8][2].minute
                  ],
                )
          : null;
    });
    return programA;
  }

  Widget _buildCreateButton(BuildContext context, int transitioon) {
    return Center(
      child: CustomOutlinedButton(
        onPressed: () {
          if (a1_end!.hour >= 24 && a1_end!.minute >= 0) {
            showToast('Time exceeds 24 hour');
          } else {
            widget.onValueChanged(1);
            updateA();
          }
        },
        height: 50,
        width: 305,
        text: "Next",
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.green),
        buttonTextStyle: CustomTextStyles.headlineSmallPoppinsWhiteA70001,
      ),
    );
  }

  Widget _durationtwo(BuildContext context) {
    return SizedBox(
      height: 850,
      width: 500.h,
      child: ListView.builder(

          //  scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 12,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
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
                    onTap: () {
                      setState(() {
                        _colorContainera1[index] =
                            _colorContainera1[index] == Colors.white
                                ? Colors.red
                                : Colors.white;
                      });
                    },
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
                                  color: _colorContainera1[index]),
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
    Future<void> _valvetime(BuildContext context, int index) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTimes[index],
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );
      if (picked != null && picked != selectedTimes[index]) {
        if (_selectedTime.hour + _selectedTime.minute != 0) {
          setState(() {
            selectedTimes[index] = picked;

            int totalHours = 0;
            int totalMinutes = 0;
            for (var time in selectedTimes) {
              totalHours += time.hour;
              totalMinutes += time.minute;
            }
            totalHours += totalMinutes ~/ 60;
            totalMinutes = totalMinutes % 60;
            totalh = totalHours;
            totalm = totalMinutes;
            a1_end = TimeOfDay(
                hour: totalh!.toInt() + _selectedTime.hour,
                minute: totalm! + _selectedTime.minute);
            print('${totalHours} ${totalMinutes}');
          });
        }
        if (_selectedTime.hour + _selectedTime.minute == 0) {
          showToast('Please select start time first');
        }
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          child: CustomTextFormField(
            width: 100,
            hintStyle: CustomTextStyles.bodyMediumInter,
            enabled: false,
            textInputType: TextInputType.number,
            hintText: selectedTimes[index].hour == 0
                ? '00 hrs'
                : "${selectedTimes[index].hour.toString().padLeft(2, '0')} hrs",
            contentPadding: EdgeInsets.only(left: 10, top: 20),
            fillColor: Colors.white,
            borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(color: Colors.grey)),

            // contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          child: CustomTextFormField(
            enabled: false,
            hintStyle: CustomTextStyles.bodyMediumInter,

            hintText: selectedTimes[index].minute == 0
                ? "00 mins"
                : "${selectedTimes[index].minute.toString().padLeft(2, '0')} mins",
            textInputType: TextInputType.number,
            fillColor: Colors.white,
            borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(color: Colors.grey)),
            contentPadding: EdgeInsets.only(left: 10, top: 20),
            //contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: IconButton(
            onPressed: () {
              _valvetime(context, index);
            },
            icon: Icon(
              Icons.alarm,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  Widget _durationfour(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 15,
            ),
            Text(
              'Prewet(hrs)',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Fertilize(hrs)',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Flush(hrs)',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Total',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        Container(
          height:1100.h,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 12,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12, right: 9, bottom: 4),
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
                          onTap: () => _selectTimefer(context, index, i),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: CustomTextFormField(
                              hintStyle: CustomTextStyles.bodyMediumInter,

                              width: 70,
                              enabled: false,
                              textInputType: TextInputType.number,
                              hintText: selectedTimefer[index][i].hour +
                                          selectedTimefer[index][i].minute ==
                                      0
                                  ? '00 hrs'
                                  : '${selectedTimefer[index][i].hour.toString().padLeft(2, '0')}:${selectedTimefer[index][i].minute.toString().padLeft(2, '0')}',
                              contentPadding: EdgeInsets.only(left: 2, top: 20),
                              fillColor: Colors.white,
                              borderDecoration: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9),
                                  borderSide: BorderSide(color: Colors.grey)),

                              // contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          '${_calculateTotal(selectedTimefer[index])} hrs',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      //  _dropdown(context),
                    ],
                  ),
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

  Future<void> _selectTimefer(
      BuildContext context, int rowIndex, int timeIndex) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimefer[rowIndex][timeIndex],
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    int totalHoursfer = 0;
    int totalMinutesfer = 0;
    if (picked != null && picked != selectedTimefer[rowIndex][timeIndex]) {
      if (_selectedTime.hour + _selectedTime.minute != 0) {
        if (totalHoursfer < 24) {
          setState(() {
            selectedTimefer[rowIndex][timeIndex] = picked;
            for (var i = 0; i < 12; i++) {
              for (var j = 0; j < 3; j++) {
                totalHoursfer += selectedTimefer[i][j].hour;
                totalMinutesfer += selectedTimefer[i][j].minute;
              }
            }
            totalHoursfer += totalMinutesfer ~/ 60;
            totalMinutesfer %= 60;
            totalmfer = totalMinutesfer;
            totalhfer = totalHoursfer;

            a1_end = TimeOfDay(
                hour: totalhfer!.toInt() + _selectedTime.hour,
                minute: totalmfer! + _selectedTime.minute);
          });
        }
      }
    }
    if (totalHoursfer > 24) {
      showToast('Time exceeds');
    }
    if (_selectedTime.hour + _selectedTime.minute == 0) {
      showToast('Please select start time first');
    }
  }
}
