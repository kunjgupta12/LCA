import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lca/api/config.dart';
import 'package:lca/api/device/device_list.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/api/formatter.dart';
import 'package:lca/api/language_shared_pref.dart';
import 'package:lca/main.dart';
import 'package:lca/model/device/device.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lca/screens/dashboard/frame_eight_page.dart';
import 'package:lca/screens/device/register_device.dart';
import 'package:lca/screens/language_select/language_page.dart';
import 'package:lca/screens/schedule/schedule_home.dart';
import 'package:lca/widgets/app_bar/appbar_title.dart';
import 'package:lca/widgets/app_bar/custom_app_bar.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_elevated_button.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/floating_button.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceListScreen extends StatefulWidget {
  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

String? token;
String? jsonString;

class _DeviceListScreenState extends State<DeviceListScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Device> _devices = [];
  int _pageNumber = 0;
  bool _isLoading = false;
  bool _hasMoreData = true;
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    print(initialMessage);
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void storedevice() async {
    print(token);
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
    print('stored token:${token}');
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void firebaseCloudMessaging_Listeners() {
    messaging.getToken().then((token) {
      print(token);
    });
    print(messaging.getNotificationSettings());
  }

  void _handleMessage(RemoteMessage message) {
    print(message.data);
  }
String? stored_lang_home;
  @override
  void initState() {
    super.initState();
    storedevice();
    stored_lang_home=getlang().toString();
    _scrollController.addListener(_scrollListener);
    setupInteractedMessage();
    firebaseCloudMessaging_Listeners();
    _fetchMoreData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchMoreData();
    }
  }

  Future<void> _fetchMoreData() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    try {
      ApiResponse response = await fetchDevices(_pageNumber);
      setState(() {
        log(response.lastPage.toString());
        _devices.addAll(response.content);
        _pageNumber++;
        _hasMoreData = !response.lastPage;
      });
    } catch (e) {
      print('Error fetching devices: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool select = false;
  int selectedOption = 0;
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: Container(
                      width: 100.h,
                      height: 200.v,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: stored_lang_home=='null'
                                        ? 
                                         Colors.yellow :Colors.white
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          child: Text(
                                            locale[index]['name'],
                                            style: TextStyle(
                                                color: selectedOption == index
                                                    ? Colors.black
                                                    : Colors.green,
                                                fontSize: 18),
                                          ),
                                          onPressed: () {
                                            selectedOption = index;

                                            setState(() {
                                              selectedOption = index;
                                            });
                                            print('local ${locale[index]['locale']}');
                                            print(locale_stored.toString());
                                            updateLanguage(
                                                locale[index]['locale']);
                                          }),

                                      /// Text(locale[index]['name']),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: locale.length),
                      ),
                    )));
          },
          icon: Icon(Icons.language),
        )
      ],
      title: Padding(
        padding: const EdgeInsets.only(
          left: 2,
          top: 27,
          bottom: 3,
        ),
        child: GestureDetector(
          onTap: () {},
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppbarTitle(
                  text: "My Devices".tr,
                ),
              ],
            ),
          ),
        ),
      ),
      styleType: Style.bgGradientnamelightgreenA700namegreen800aa,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Material(
        child: Scaffold(
          appBar: _buildAppBar(context),
          floatingActionButton: RectangularFloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FrameFifteenScreen()));
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Add Device'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ),
                    Icon(
                      Icons.add, color: Colors.white,
                      //  color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height * 2,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _devices.length + (_hasMoreData ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _devices.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  Device device = _devices[index];

                  String formattedTime =
                      formatTime(device.createdOn.toString());

                  return Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${"Name".tr}: ${device.title}"),
                            Text(device.imei),
                            Text('${"Created On".tr}: ${formattedTime}'),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomElevatedButton(
                              width: 160.h,
                              buttonStyle: CustomButtonStyles.fillOrangeA,
                              height: 40,
                              text: 'Dashboard'.tr,
                              buttonTextStyle:
                                  CustomTextStyles.titleSmallff000000,
                              onPressed: () {
                                print(token);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        //    FrameThirtythreePage())
                                        FrameEightPage(
                                            token: token.toString(),
                                            valve_no: device.valveCount,
                                            para:
                                                '${device.address!.lat},${device.address!.long}',
                                            iemi: device.imei,
                                            name: device.title,
                                            id: device.id)));
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomElevatedButton(
                              width: 160.h,
                              buttonStyle: CustomButtonStyles.fillOrangeA
                                  .copyWith(
                                      backgroundColor: WidgetStateProperty.all<
                                              Color>(
                                          Color.fromRGBO(218, 188, 255, 1))),
                              height: 40,
                              text: 'Program'.tr,
                              buttonTextStyle:
                                  CustomTextStyles.titleSmallff000000,
                              onPressed: () {
                                print(token);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Schedule(
                                          id: device.id,valve:device.valveCount,
                                          token: token.toString(),
                                          iemi: device.imei,
                                          name: device.title,
                                        )));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ));
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}

