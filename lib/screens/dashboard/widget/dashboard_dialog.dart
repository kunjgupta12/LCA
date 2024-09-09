import 'package:flutter/material.dart';
import 'package:lca/api/device/device_status_api.dart';
import 'package:lca/api/device/devices.dart';
import 'package:lca/screens/device/update_device.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_elevated_button.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:get/get.dart';
Widget settingdialog(BuildContext context,id,iemi){
return AlertDialog(
                                  backgroundColor: Colors.grey.shade100,
                                  title:
                                      Text('IMEI: ${iemi.toString()}'),
                                  content: Container(
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomElevatedButton(
                                            text: 'Flow Reset'.tr,
                                            onPressed: () async {
                                              resetValve(id,
                                            context);
                                            },
                                            height: 50,
                                            buttonTextStyle: CustomTextStyles
                                                .headlineSmallDMSansBlack90001Bold,
                                            buttonStyle: CustomButtonStyles
                                                .fillOrangeA
                                                .copyWith(
                                              backgroundColor:
                                                  WidgetStateProperty
                                                      .resolveWith((states) {
                                                // If the button is pressed, return green, otherwise blue
                                                if (states.contains(
                                                    WidgetState.pressed)) {
                                                  return Colors.white;
                                                }
                                                return Colors.white;
                                              }),
                                            ),
                                          ),
                                          Divider(),
                                          CustomElevatedButton(
                                            text: 'Update Device'.tr,
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateDevice(
                                                            id: id,
                                                          )));
                                            },
                                            height: 50,
                                            buttonTextStyle: CustomTextStyles
                                                .headlineSmallDMSansBlack90001Bold,
                                            buttonStyle: CustomButtonStyles
                                                .fillOrangeA
                                                .copyWith(
                                              backgroundColor:
                                                  WidgetStateProperty
                                                      .resolveWith((states) {
                                                // If the button is pressed, return green, otherwise blue
                                                if (states.contains(
                                                    WidgetState.pressed)) {
                                                  return Colors.white;
                                                }
                                                return Colors.white;
                                              }),
                                            ),
                                          ),
                                          Divider(),
                                          CustomElevatedButton(
                                            onPressed: () => Devices()
                                                .deleteDevice(
                                                    id.toString(),
                                                    context),
                                            text: 'Delete Device'.tr,
                                            height: 50,
                                            buttonTextStyle: CustomTextStyles
                                                .headlineSmallLilitaOneWhiteA70001,
                                            buttonStyle: CustomButtonStyles
                                                .fillOrangeA
                                                .copyWith(
                                              backgroundColor:
                                                  WidgetStateProperty
                                                      .resolveWith((states) {
                                                // If the button is pressed, return green, otherwise blue
                                                if (states.contains(
                                                    WidgetState.pressed)) {
                                                  return Colors.red;
                                                }
                                                return Colors.red;
                                              }),
                                            ),
                                          )
                                        ],
                                      )),
                                );
}