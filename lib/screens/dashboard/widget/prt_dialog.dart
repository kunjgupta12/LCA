import 'package:flutter/material.dart';
import 'package:lca/api/device/device_status_api.dart';
import 'package:lca/widgets/custom_text_form_field.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:get/get.dart';
import 'package:lca/widgets/utils/size_utils.dart';


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

  final TextEditingController pumpstarttime = TextEditingController();
  final TextEditingController pumprechargetime = TextEditingController();
TimeOfDay? selectedTime;
  Future<void> prtsubmit(BuildContext context,id) async {
    /* if (createSchedule.isLoading) {
      showToast(context, 'Please wait for some time');
    } else {*/
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: SizedBox(
              height: 230,
              width: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pump initial time'.tr+"(Sec)",
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
                    'Pump recharge time'.tr+"(HH:MM)",
                    style: CustomTextStyles.titleSmallRobotoBlack90001,
                  ),
                  Row(
                    children: [
                      CustomTextFormField(width: 180.h,
                        hintText: 'Pump recharge time'.tr,
                        controller: pumprechargetime,
                        textInputType: TextInputType.number,hintStyle: TextStyle(fontSize: 16),
                     enabled: false,
                      ),Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: IconButton(
           onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      pumprechargetime.text=convertTime(TimeOfDay(hour: picked.hour,minute:picked.minute));
                      selectedTime = picked;
                    });
                  }},
          //ClockPainter()
          //  ,
            icon: Icon(
              Icons.alarm,
              color: Colors.green,
            ),
          ),
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
                 updatepump(id, context, (selectedTime!.hour*60+selectedTime!.minute).toString(), pumpstarttime.text,);
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
    // }
  }