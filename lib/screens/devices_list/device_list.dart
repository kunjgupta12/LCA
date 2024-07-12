import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lca/model/device.dart';
import 'package:lca/screens/home/frame_eight_page.dart';
import 'package:lca/screens/register_device/register_device.dart';
import 'package:lca/screens/schedule/schedule.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_elevated_button.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/floating_button.dart';
import 'package:lca/widgets/utils/notification.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../api/api.dart';
import '../../api/formatter.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../auth/signup.dart';

class DeeviceList extends StatefulWidget {
  DeeviceList({super.key});

  @override
  State<DeeviceList> createState() => _DeeviceListState();
}

String? token;
String? jsonString;

class _DeeviceListState extends State<DeeviceList> {
  final DeviceDataService dataService = DeviceDataService();
  late Future<List<dynamic>> futureData;
  void storedevice() async {
    print(token);
    final prefs = await SharedPreferences.getInstance();
    jsonString = prefs.getString('devicelist');

    token = prefs.getString('token');
    print('stored data:${jsonString}');
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    print(initialMessage);
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
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
    //print(message);
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    firebaseCloudMessaging_Listeners();

    // futureData = dataService.fetchDatafordevices();
    storedevice();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: RectangularFloatingActionButton(
          onPressed: () {
            
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FrameFifteenScreen()));
          },
          child:const  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Add Device',
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
        appBar: _buildAppBar(context),
        body: Sizer(builder: (context, orientation, deviceType) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 2,
            child: FutureBuilder<ApiResponse>(
              future: DeviceDataService().fetchDatafordevices(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data!.content.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data!.content[index];
                        String formattedTime =
                            formatTime(item.createdOn.toString());
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
                                  Text('Name: ${item.title}'),
                                  Text(item.imei),
                                  Text('Created On: ${formattedTime}'),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomElevatedButton(
                                    width: 160.h,
                                    buttonStyle: CustomButtonStyles.fillOrangeA,
                                    height: 40,
                                    text: 'Dashboard',
                                    buttonTextStyle:
                                        CustomTextStyles.titleSmallff000000,
                                    onPressed: () {
                                      print(token);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  //    FrameThirtythreePage())
                                                  FrameEightPage(
                                                      token: token.toString(),
                                                      valve_no: item.valveCount,
                                                      para:
                                                          '${item.address!.lat},${item.address!.long}',
                                                      iemi: item.imei,
                                                      name: item.title,
                                                      id: item.id)));
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomElevatedButton(
                                    width: 160.h,
                                    buttonStyle: CustomButtonStyles.fillOrangeA
                                        .copyWith(
                                            backgroundColor:
                                                WidgetStateProperty
                                                    .all<Color>(Color.fromRGBO(
                                                        218, 188, 255, 1))),
                                    height: 40,
                                    text: 'Schedules',
                                    buttonTextStyle:
                                        CustomTextStyles.titleSmallff000000,
                                    onPressed: () {
                                      print(token);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Schedule(
                                                    id: item.id,
                                                    token: token.toString(),
                                                  )
                                              //    FrameThirtythreePage())
                                              ));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )

                            

                            );
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          );
        }),
      ),
    );
  }

// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: EdgeInsets.only(
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
                  
                 
                  text: "My Devices",
                ),
              ],
            ),
          ),
        ),
      ),
      styleType: Style.bgGradientnamelightgreenA700namegreen800aa,
    );
  }
}
