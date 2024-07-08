import 'package:lca/screens/frame_twenty_screen/widget_a1.dart';
import 'package:lca/screens/frame_twenty_screen/widget_a2.dart';
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

int? _selectedButtonIndex;

class ViewScedule extends StatefulWidget {
  String? token;
  int? id;

  ViewScedule({Key? key, this.id, this.token})
      : super(
          key: key,
        );

  @override
  State<ViewScedule> createState() => _ViewScheduleState();
}

bool isChecked = false;
TimeOfDay? a1_end = TimeOfDay(hour: 0, minute: 0);
TextEditingController pumpstarttime = TextEditingController();

TextEditingController pumprechargetime = TextEditingController();

//inal GlobalKey<> childKey = GlobalKey<_A1State>();
class _ViewScheduleState extends State<ViewScedule> {
  final GlobalKey<A1State> childKeya1 = GlobalKey<A1State>();

  GlobalKey<a1State> childKeya2 = GlobalKey<a1State>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Scaffold(body: Sizer(builder: (context, orientation, deviceType) {
      return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(children: [
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
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Program",
                          style: CustomTextStyles
                              .headlineSmallDMSansBlack90001Bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buidProgramsGrid(context),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Select Days",
                              style: CustomTextStyles
                                  .headlineSmallDMSansBlack90001Bold,
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
                            style: CustomTextStyles
                                .headlineSmallDMSansBlack90001Bold,
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: MaterialButton(
                                              elevation: 2,
                                              color: _selectedButtonIndex == 1
                                                  ? Color.fromARGB(
                                                      255, 77, 152, 221)
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgirrigation,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Irrigation",
                                                        style: TextStyle(
                                                          color:
                                                              appTheme.black900,
                                                          fontSize: 18,
                                                          fontFamily: 'DM Sans',
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: MaterialButton(
                                              color: _selectedButtonIndex == 2
                                                  ? const Color.fromARGB(
                                                      255, 224, 153, 153)
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      CustomImageView(
                                                        imagePath:
                                                            ImageConstant.fert,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "Fertigation",
                                                        style: TextStyle(
                                                          color:
                                                              appTheme.black900,
                                                          fontSize: 18,
                                                          fontFamily: 'DM Sans',
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                    hintText: "00:00 hrs",
                                    hintStyle: CustomTextStyles.bodyMediumInter,
                                    fillColor: Colors.white,
                                    textInputType: TextInputType.number,
                                    borderDecoration: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(9),
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    contentPadding:
                                        EdgeInsets.only(left: 10, top: 20),
                                    //contentPadding: EdgeInsets.only(right: 4, left: 4, top: 10),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 18,
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        //          _selectTime(context);
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
                              style: CustomTextStyles
                                  .headlineSmallDMSansBlack90001Bold,
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

                                    hintText: '', fillColor: Colors.white,
                                    borderDecoration: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(9),
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    contentPadding:
                                        EdgeInsets.only(left: 20, top: 20),
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
                                CustomTextFormField(
                                  width: 110.h,
                                  enabled: false,
                                  hintStyle: CustomTextStyles.bodyMediumInter,
                                
                                  hintText: '',
                                  fillColor: Colors.white,
                                  borderDecoration: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
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
          ]));
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

  Widget _buildCreateButton(BuildContext context, int transitioon) {
    return Center(
      child: CustomOutlinedButton(
        onPressed: () {
          if (a1_end!.hour >= 24 && a1_end!.minute >= 0) {
            showToast('Time exceeds 24 hour');
          } else {}
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
                      setState(() {});
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
                                  color: Colors.white),
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

          print('${totalHours} ${totalMinutes}');
        });
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
          height: 1100.h,
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
                          onTap: () {},
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

  /// Section Widget
  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: AppDecoration.bg,
      child: Column(
        children: [
          CustomAppBar(
            height: 30,centerTitle: true,    
            title: AppbarSubtitle(
              onTap: () {
                Navigator.pop(context);
              },
              text:
              "Program",
          
              margin: EdgeInsets.only(left: 6),
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
          left: 22.h,
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
                              '',
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
