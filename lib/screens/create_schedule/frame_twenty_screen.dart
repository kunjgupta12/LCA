import 'dart:async';

import 'package:lca/api/device/device_status_api.dart';
import 'package:lca/api/schedule.dart';
import 'package:lca/model/device_status/type4.dart';
import 'package:lca/model/schedule/CreateSchedule.dart';
import 'package:lca/screens/create_schedule/widgets/widget_a1.dart';
import 'package:lca/screens/create_schedule/widgets/widget_a2.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_elevated_button.dart';
import 'package:lca/widgets/custom_text_form_field.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/utils/messages.dart';
import 'package:lca/widgets/utils/showtoast.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:provider/provider.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/theme_helper.dart';
import 'package:flutter/material.dart';

ProgramB programB = ProgramB();
ProgramA programA = ProgramA();
Schedule schedule = Schedule();

Color _color = Colors.white;
int _selectedValue = 0;

class FrameTwentyScreen extends StatefulWidget {
  String? token;
  int? id;

  FrameTwentyScreen({Key? key, this.id, this.token})
      : super(
          key: key,
        );

  @override
  State<FrameTwentyScreen> createState() => _FrameTwentyScreenState();
}

bool isChecked = false;
TimeOfDay? a1_end = TimeOfDay(hour: 0, minute: 0);
TextEditingController pumpstarttime = TextEditingController();
String? token;
DeviceStatus? deviceStatus;
TextEditingController pumprechargetime = TextEditingController();

//inal GlobalKey<> childKey = GlobalKey<_A1State>();
class _FrameTwentyScreenState extends State<FrameTwentyScreen> {
  final GlobalKey<A1State> childKeya1 = GlobalKey<A1State>();
  late CreateSchedule createSchedule;
  Timer? _timer;
  int _remainingSeconds = 0; // 9 minutes in seconds

  Future<void> _handleLoadingChange() async {
    _startTimer();
  }

  void _startTimer() async {
    _remainingSeconds = 540;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds = _remainingSeconds - 1;
          createSchedule.time = createSchedule.time - 1;
          _overlayEntry!.markNeedsBuild();
        } else {
          _stopTimer();
          _overlayEntry!.remove();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * .2,
        left: MediaQuery.of(context).size.width * .25,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$_formattedTime',
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry? _overlayEntry;
  void _showOverlay(BuildContext context) {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void initState() {
    createSchedule = Provider.of<CreateSchedule>(context, listen: false);

    createSchedule.addListener(_handleLoadingChange);
    // TODO: implement initState
    super.initState();
  }

  GlobalKey<a1State> childKeya2 = GlobalKey<a1State>();
  @override
  void dispose() {
    // TODO: implement dispose

    WidgetsBinding.instance.addPostFrameCallback((_) {
      createSchedule.resetLoadingState();
      _remainingSeconds = 0;
    });
    _stopTimer();
    createSchedule.removeListener(_handleLoadingChange);
    _overlayEntry!.remove();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Sizer(builder: (context, orientation, deviceType) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
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
                      _selectedValue == 0
                          ? a1(
                              key: childKeya1,
                              end: a1_end,
                              transition: _selectedValue,
                              onValueChanged: _handleValueChanged,
                            )
                          : a2(
                              starttime: a1_end,
                              id: widget.id,
                              key: childKeya2,
                            ),
                    ],
                  ),
                ),
                Consumer<CreateSchedule>(builder: (context, value, child) {
                  return CustomElevatedButton(
                    text: 'SUBMIT',
                    buttonStyle: value.isLoading
                        ? CustomButtonStyles.fillOrangeA.copyWith(
                            backgroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              // If the button is pressed, return green, otherwise blue
                              if (states.contains(WidgetState.pressed)) {
                                return Colors.grey;
                              }
                              return Colors.grey;
                            }),
                          )
                        : CustomButtonStyles.fillOrangeATL15.copyWith(
                            backgroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              // If the button is pressed, return green, otherwise blue
                              if (states.contains(WidgetState.pressed)) {
                                return Colors.green;
                              }
                              return Colors.green;
                            }),
                          ),
                    onPressed: () {
                      value.isLoading
                          ? showToast('Please wait for some time')
                          : setState(() {
                              showDialog(
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: Container(
                                              height: 220,
                                              width: 70,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Pump initial time',
                                                    style: CustomTextStyles
                                                        .titleSmallRobotoBlack90001,
                                                  ),
                                                  CustomTextFormField(
                                                    hintText:
                                                        'Pump initial time',
                                                    controller: pumpstarttime,
                                                    textInputType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      final number =
                                                          int.tryParse(value!);
                                                      if (value == 'null' ||
                                                          value.isEmpty ||
                                                          number! < 5 ||
                                                          number > 90) {
                                                        return 'Please enter in range of 5 to 90';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  Text(
                                                    'Pump recharge time',
                                                    style: CustomTextStyles
                                                        .titleSmallRobotoBlack90001,
                                                  ),
                                                  CustomTextFormField(
                                                    hintText:
                                                        'Pump recharge time',
                                                    controller:
                                                        pumprechargetime,
                                                    textInputType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      final number =
                                                          int.tryParse(value!);
                                                      if (value == 'null' ||
                                                          value.isEmpty ||
                                                          number! < 1 ||
                                                          number > 1440) {
                                                        return 'Please enter in range of 1 to 1440';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Start from today?",
                                                        style: CustomTextStyles
                                                            .titleMediumBluegray900,
                                                      ),
                                                      Checkbox(
                                                        value: isChecked,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            isChecked = value!;
                                                            print(isChecked);
                                                          });
                                                        },
                                                        activeColor: isChecked
                                                            ? Colors.green
                                                            : Colors.red,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: CustomTextStyles
                                                      .titleLargeRedA70002,
                                                )),
                                            TextButton(
                                                onPressed: () async {
                                                  _selectedValue == 0
                                                      ? childKeya1.currentState!
                                                          .updateA()
                                                      : childKeya2.currentState!
                                                          .updateB();
                                                  schedule = Schedule(
                                                      programA:
                                                          programA.programId ==
                                                                  null
                                                              ? null
                                                              : programA,
                                                      programB:
                                                          programB.programId ==
                                                                  null
                                                              ? null
                                                              : programB,
                                                      useToday: isChecked,
                                                      pit: int.tryParse(
                                                          pumpstarttime.text
                                                              .toString()),
                                                      prt: int.tryParse(
                                                          pumprechargetime.text
                                                              .toString()));
                                                  print(widget.token);

                                                  deviceStatus =
                                                      await device_detail(
                                                          widget.id.toString());

                                                  if (deviceStatus != null) {
                                                    if (deviceStatus!.c!.ms ==
                                                        1) {
                                                      value.createSchedule(
                                                          widget.token
                                                              .toString(),
                                                          widget.id!.toInt(),
                                                          schedule);
                                                      showmessages(context);
                                                      _showOverlay(context);
                                                    } else {
                                                      showToast(
                                                          'Mains off/Power Off');
                                                    }
                                                  } else {
                                                    showToast(
                                                        'Device not configured');
                                                  }
                                                },
                                                child: Text(
                                                  'Confirm',
                                                  style: CustomTextStyles
                                                      .bodyLargeDMSansBluegray500,
                                                )),
                                          ],
                                        );
                                      }));
                            });
                    },
                    height: 50,
                    width: 305,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      //   color: value.isLoading ?Colors.grey: Colors.green
                    ),
                    buttonTextStyle:
                        CustomTextStyles.headlineSmallPoppinsWhiteA70001,
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: AppDecoration.bg,
      child: Column(
        children: [
          CustomAppBar(
            height: 30,
            title: AppbarSubtitle(
              onTap: () {
                Navigator.pop(context);
              },
              text: "< Back",
              margin: EdgeInsets.only(left: 6),
            ),
          ),
          SizedBox(height: 25),
          Container(
            decoration: AppDecoration.outlineBlack,
            child: Text(
              "Create Program",
              style: theme.textTheme.displayMedium,
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 315,
            margin: const EdgeInsets.only(
              left: 57,
              right: 62,
            ),
            child: Text(
              "Please Select the program and mode to create schedule",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.bodyLargeDMSansRegular,
            ),
          ),
          SizedBox(height: 39),
        ],
      ),
    );
  }

  void _handleValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  /// Section Widget
  Widget _buidProgramsGrid(BuildContext context) {
    List day = [
      'Program A',
      'Program B',
    ];
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 47,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      index != 0
                          ? childKeya1.currentState!.updateA()
                          : childKeya2.currentState!.updateB();
                      // selectedindex = index.toString();
                      _handleValueChanged(index);
                    });
                  },
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
                              day[index],
                              style: TextStyle(
                                color: _selectedValue == index
                                    ? appTheme.whiteA700
                                    : appTheme.black900,
                                fontSize: 16,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      )),
                      decoration: _selectedValue == index
                          ? BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadiusStyle.roundedBorder10,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            )
                          : BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadiusStyle.roundedBorder10,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white54.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
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

  /// Section Widget
}
