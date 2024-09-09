import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:lca/api/device/device_status_api.dart';
import 'package:lca/api/schedule/get_schedule.dart';
import 'package:lca/api/schedule/schedule_provider.dart';
import 'package:lca/model/device_status/type4.dart';
import 'package:lca/model/schedule/CreateSchedule.dart';
import 'package:lca/screens/create_schedule/widgets/widget_a1.dart';
import 'package:lca/screens/create_schedule/widgets/widget_a2.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_elevated_button.dart';
import 'package:lca/widgets/custom_text_form_field.dart';
import 'package:lca/widgets/custom_text_style.dart';
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
String get formattedTime {
  final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
  final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

int _remainingSeconds = 540; // 9 minutes in seconds

class FrameTwentyScreen extends StatefulWidget {
  final String? token;
  final int? id;
  int valve;
  FrameTwentyScreen({Key? key, this.id, this.token, required this.valve})
      : super(key: key);

  @override
  State<FrameTwentyScreen> createState() => _FrameTwentyScreenState();
}

bool isChecked = false;
TimeOfDay? a1_end = TimeOfDay(hour: 0, minute: 0);

class _FrameTwentyScreenState extends State<FrameTwentyScreen> {
  final GlobalKey<A1State> childKeya1 = GlobalKey<A1State>();
  final TextEditingController pumpstarttime = TextEditingController();
  final TextEditingController pumprechargetime = TextEditingController();
  final GlobalKey<a1State> childKeya2 = GlobalKey<a1State>();

  late CreateScheduleProvider createSchedule;
  Timer? _timer;

  int _selectedValue = 0;
  DeviceStatus? deviceStatus;

  @override
  void initState() {
    super.initState();
    createSchedule =
        Provider.of<CreateScheduleProvider>(context, listen: false);
    createSchedule.addListener(_handleLoadingChange);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      createSchedule.resetLoadingState();
      _remainingSeconds = 0;
    });
    _stopTimer();
    createSchedule.removeListener(_handleLoadingChange);
  
Navigator.pop(context);
    super.dispose();
  }

  Future<void> _handleLoadingChange() async {
    _startTimer();
  }

  void _startTimer() {
    _remainingSeconds = 540;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;

         // overlayEntry!.markNeedsBuild();
        } else {
          _stopTimer();
       
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _handleValueChanged(int value) {
    setState(() {
      _selectedValue = value;
    });
  }

  Future<void> _onSubmit() async {
    if (createSchedule.isLoading) {
      showToast(context, 'Please wait for some time');
    } else {
      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: SizedBox(
                height: 220,
                width: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pump initial time'.tr,
                      style: CustomTextStyles.titleSmallRobotoBlack90001,
                    ),
                    CustomTextFormField(
                      hintText: 'Pump initial time'.tr,
                      controller: pumpstarttime,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        final number = int.tryParse(value!);
                        if (value.isEmpty ||
                            number == null ||
                            number < 5 ||
                            number > 90) {
                          return 'Please enter in range of 5 to 90';
                        }
                        return null;
                      },
                    ),
                    Text(
                      'Pump recharge time'.tr,
                      style: CustomTextStyles.titleSmallRobotoBlack90001,
                    ),
                    CustomTextFormField(
                      hintText: 'Pump recharge time'.tr,
                      controller: pumprechargetime,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        final number = int.tryParse(value!);
                        if (value.isEmpty ||
                            number == null ||
                            number < 1 ||
                            number > 1440) {
                          return 'Please enter in range of 1 to 1440';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          "Start from today?".tr,
                          style: CustomTextStyles.titleMediumBluegray900,
                        ),
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          activeColor: isChecked ? Colors.green : Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel'.tr,
                    style: CustomTextStyles.titleLargeRedA70002,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_selectedValue == 0) {
                      childKeya1.currentState!.updateA();
                    } else {
                      childKeya2.currentState!.updateB();
                    }

                    schedule = Schedule(
                      programA: programA.startTime == null ? null : programA,
                      programB: programB.startTime == null ? null : programB,
                      useToday: isChecked,
                      pit: int.tryParse(pumpstarttime.text),
                      prt: int.tryParse(pumprechargetime.text),
                    );

                    deviceStatus = await device_detail(widget.id.toString());

                    if (deviceStatus != null) {
                      if (deviceStatus!.c!.ms == 1) {
                        createSchedule.createSchedule(
                            widget.token!, widget.id!, schedule, context);
                      } else {
                        showToast(context, 'Mains off/Power Off');
                      }
                    } else {
                      showToast(context, 'Device not configured');
                    }
                  },
                  child: Text(
                    'Confirm'.tr,
                    style: CustomTextStyles.bodyLargeDMSansBluegray500,
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: AppDecoration.bg,
      child: Column(
        children: [
          CustomAppBar(
            height: 30,
            title: AppbarSubtitle(
              onTap: () => Navigator.pop(context),
              text: "< Back".tr,
              margin: EdgeInsets.only(left: 6),
            ),
          ),
          SizedBox(height: 25),
          Container(
            decoration: AppDecoration.outlineBlack,
            child: Text(
              "Create Program".tr,
              style: theme.textTheme.displayMedium,
            ),
          ),
          SizedBox(height: 30),
     Container(
            width: 315,
            margin: const EdgeInsets.symmetric(horizontal: 62),
            child: Text(
              "Please Select the program and mode to create schedule".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: CustomTextStyles.bodyLargeDMSansRegular,
            ),
          ) ,
       SizedBox(height: 10,),   formattedTime =='09:00' ||   formattedTime =='00:00' ? Text(''): Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                formattedTime,
                style: TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProgramsGrid(BuildContext context) {
    List<String> day = ['Program A'.tr, 'Program B'.tr];

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.h),
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
            itemCount: day.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                        if (_selectedValue == 0) {
                    log( childKeya1.currentState!.updateA().startTime2.toString());
                    } else {
                    log( childKeya2.currentState!.updateB().startTime.toString());
                    }
                    setState(() {
                      index != 0
                          ? childKeya1.currentState!.updateA()
                          : childKeya2.currentState!.updateB();

                      _handleValueChanged(index);
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 202,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
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
                      ),
                    ),
                    decoration: BoxDecoration(
                      color:
                          _selectedValue == index ? Colors.blue : Colors.white,
                      borderRadius: BorderRadiusStyle.roundedBorder10,
                      boxShadow: [
                        BoxShadow(
                          color: _selectedValue == index
                              ? Colors.grey.withOpacity(0.5)
                              : Colors.white54.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Sizer(
          builder: (context, orientation, deviceType) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  _buildAppBar(context),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 28),
                    decoration: AppDecoration.ko.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder52,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "Program".tr,
                            style: CustomTextStyles
                                .headlineSmallDMSansBlack90001Bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildProgramsGrid(context),
                        _selectedValue == 0
                            ? a1(
                                valve: widget.valve,
                                key: childKeya1,
                                end: a1_end,
                                
                              )
                            : a2(
                                valve: widget.valve,
                                starttime: a1_end,
                                id: widget.id,
                                key: childKeya2,
                              ),
                      ],
                    ),
                  ),
                  Consumer<CreateScheduleProvider>(
                    builder: (context, value, child) {
                      return CustomElevatedButton(
                        text: 'SUBMIT'.tr,
                        buttonStyle: value.isLoading
                            ? CustomButtonStyles.fillOrangeA.copyWith(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.grey;
                                  }
                                  return Colors.grey;
                                }),
                              )
                            : CustomButtonStyles.fillOrangeATL15.copyWith(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.green;
                                  }
                                  return Colors.green;
                                }),
                              ),
                        onPressed: _onSubmit,
                        height: 50,
                        width: 305,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        buttonTextStyle:
                            CustomTextStyles.headlineSmallPoppinsWhiteA70001,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
