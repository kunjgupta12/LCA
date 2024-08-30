import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lca/model/schedule/CreateSchedule.dart';
import 'package:lca/screens/create_schedule/frame_twenty_screen.dart';
import 'package:lca/screens/device/register_device.dart';
import 'package:lca/widgets/custom_image.dart';
import 'package:lca/widgets/custom_text_form_field.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/image_constant.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:lca/widgets/utils/size_utils.dart';

///
  List<Color> _colorContainera1 = List.generate(7, (index) => Colors.white);
  
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
  TimeOfDay? end;int valve;
  
  a1({Key? key, this.end, this.transition,required this.valve})
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
     starttime.text = convertTime(TimeOfDay(hour: _selectedTime.hour ,minute:_selectedTime.minute));
       
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
          starttime2.text = convertTime(TimeOfDay(hour: _selectedTime2.hour ,minute:_selectedTime2.minute));
       

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
          starttime2.text = convertTime(TimeOfDay(hour: _selectedTime2.hour ,minute:_selectedTime2.minute));
     
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
        showToast(context,"Please select after end time");
      }
    }
  }
@override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Select Days".tr,
                  style: CustomTextStyles.headlineSmallDMSansBlack90001Bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedTime = TimeOfDay(hour: 0, minute: 0);
                    starttime.text = '00:00';
                    for (int i = 0; i < _colorContainera1.length; i++) {
                      _colorContainera1[i] = Colors.white;
                    }for (int i = 0; i < 12; i++) {
                     selectedTimes[i]=TimeOfDay(hour: 00, minute: 00);
                    }totalh=0;
                    totalm=0;
                    total=0;
                    totalhfer=0;
                    totalmfer=0;
                    for (int i = 0; i < 12; i++) {
                     selectedTimefer[i][0]=TimeOfDay(hour: 00, minute: 00);
                           selectedTimefer[i][2]=TimeOfDay(hour: 00, minute: 00);
                    selectedTimefer[i][1]=TimeOfDay(hour: 00, minute: 00);
              
                    }
                    a1_end=TimeOfDay(hour: 00, minute: 00);
                  });
                  programA = ProgramA();
                },
                child: Row(
                  children: [
                    Text(
                      'Reset All'.tr,
                      style: CustomTextStyles.bodyLargeDMSansRegular,
                    ),
                   const Icon(
                      Icons.replay,
                      color: Colors.black,
                    )
                  ],
                ),
              )
              
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "to follow the schedule".tr,
              style: CustomTextStyles.bodyLargeDMSans,
            ),
          ),
          SizedBox(height: 7),
          _buildDaysGrid(context),
          SizedBox(height: 45),
          Text(
            "Mode".tr,
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
                                        "Irrigation".tr,
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
                                        "Fertigation".tr,
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
                    "Start Time: ".tr,
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
              "Valve Duration  : ".tr,
              style: CustomTextStyles.headlineSmallDMSansBlack90001Bold,
            ),
          ),
          SizedBox(height: 27),
          _selectedButtonIndex == 1
              ? _durationtwo(context)
              :  _durationfour(context)
               ,
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
                    "End Time  : ".tr,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  width: 26.h,
                ),
                GestureDetector(
            
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
                    "Start Time 2 : ".tr,
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
                            : convertTime(TimeOfDay(hour: _selectedTime2.hour ,minute:_selectedTime2.minute))
       
                        : totalhfer +
                                    _selectedTime.hour.toInt() +
                                    totalmfer +
                                    _selectedTime.minute.toInt() ==
                                0
                            ? '00:00 hrs'
                            : convertTime(TimeOfDay(hour: _selectedTime2.hour ,minute:_selectedTime2.minute))
       ,
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
                                    totalmfer + _selectedTime.minute.toInt());
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
                            'Reset'.tr,
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
            
              ? Center(
                  child: Text(
                  'Time exceeds 24 hours'.tr,
                  style: CustomTextStyles.titleMediumPoppinsRedA70001,
                ))
              : SizedBox(height: 4),
          SizedBox(
            height: 10,
          ),
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
    if (_selectedTime.hour * 60 + _selectedTime.minute > 0) {
      bool isModeTrue = _selectedButtonIndex == 1;
      List<bool> days = _colorContainera1.map((color) => color == Colors.red).toList();
      String? startTime2 = _selectedTime2.hour * 60 + _selectedTime2.minute > 0
          ? convertTime(TimeOfDay(hour: _selectedTime2.hour ,minute:_selectedTime2.minute))
         : null;
      String startTime =
        convertTime(TimeOfDay(hour: _selectedTime.hour ,minute:_selectedTime.minute));
       
      List<List<int>> valves = isModeTrue
          ? List.generate(12, (i) => [selectedTimes[i].hour * 60 + selectedTimes[i].minute])
          : List.generate(12, (i) => List.generate(3, (j) => selectedTimefer[i][j].hour * 60 + selectedTimefer[i][j].minute));

      programA = ProgramA(
        mode: isModeTrue,
        monday: days[0],
        tuesday: days[1],
        wednesday: days[2],
        thrusday: days[3],
        friday: days[4],
        saturday: days[5],
        sunday: days[6],
        startTime2: startTime2,
        startTime: startTime,
        programId: 1,
        valve1: valves[0],
        valve2: valves[1],
        valve3: valves[2],
        valve4: valves[3],
        valve5: valves[4],
        valve6: valves[5],
        valve7: valves[6],
        valve8: valves[7],
        valve9: valves[8],
        valve10: valves[9],
        valve11: valves[10],
        valve12: valves[11],
      );
    } 
  });

  return programA;
}

  Widget _durationtwo(BuildContext context) {
    return SizedBox(
      height: widget.valve*70,
      width: 500.h,
      child: ListView.builder(     physics: const NeverScrollableScrollPhysics(),
          itemCount:widget.valve,
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
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thrusday'.tr,
    'Friday'.tr,
    'Saturday'.tr,
    'Sunday'.tr
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
          showToast(context,'Please select start time first');
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
          height: widget.valve*70,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: widget.valve,
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
                                  :convertTime(TimeOfDay(hour: 
        selectedTimefer[index][i].hour,minute:selectedTimefer[index][i].minute)),
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
    return convertTime(TimeOfDay(hour: 
        totalHours,minute:totalMinutes));
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
      showToast(context,'Time exceeds');
    }
    if (_selectedTime.hour + _selectedTime.minute == 0) {
      showToast(context,'Please select start time first');
    }
  }
}
