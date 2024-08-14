import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lca/api/device/functions.dart';
import 'package:lca/api/device/device_status_api.dart';
import 'package:lca/api/device/devices.dart';
import 'package:lca/model/device_status/type4.dart';
import 'package:lca/model/device_status/type1.dart';
import 'package:lca/screens/device/update_device.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_elevated_button.dart';
import 'package:lca/widgets/custom_floating_button.dart';
import 'package:lca/widgets/floating_button.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/weather/weather_api.dart';
import '../../model/weather/weather_model.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/image_constant.dart';
import '../../widgets/theme_helper.dart';
// ignore_for_file: must_be_immutable
import 'package:get/get.dart';

class FrameEightPage extends StatefulWidget {
  int? devices;
  String? para;
  String? iemi;
  String? name;
  int? id;
  int? valve_no;
  String? token;
  FrameEightPage(
      {Key? key,
      this.devices,
      this.para,
      this.iemi,
      this.name,
      this.token,
      this.valve_no,
      this.id})
      : super(
          key: key,
        );

  @override
  State<FrameEightPage> createState() => _FrameEightPageState();
}

type1? type1data;
Future<Weather>? _futureWeatherData;
Future<DeviceStatus>? details;

class _FrameEightPageState extends State<FrameEightPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<DeviceProvider>(context, listen: false)
        .DataProvider(widget.id.toString());

    // details =
    // Devices().device_detail(widget.token.toString(), widget.id.toString());
    _startTimer();

    _futureWeatherData = fetchData(widget.para.toString());
    getWeatherData(); // Adjust the query as needed
  }

  Timer? _timer;

  @override
  void dispose() {
    _stopTimer();
    deviceStatus = null;
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 3), (timer) {
      Provider.of<DeviceProvider>(context, listen: false)
          .DataProvider(widget.id.toString());
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<DeviceProvider>(context, listen: false).refreshData(),
          child: Sizer(builder: (context, orientation, deviceType) {
            return SizedBox(
              width: SizeUtils.width,
              child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 5.v),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5.h,
                      right: 5.h,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.h,
                        vertical: 7.v,
                      ),
                      decoration: AppDecoration.outlinePrimary1.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder41,
                          color: Colors.grey.shade300),
                      child: Column(
                        children: [
                          _buildTemperatureSection(
                              context, widget.para.toString()),
                          SizedBox(height: 14.v),
                          _buildLoranImage(context),
                          SizedBox(
                            height: 20.h,
                          ),
                          Consumer<DeviceProvider>(
                              builder: (context, dataprovider, snapshot) {
                            if (dataprovider.data == null) {
                              return const Center(
                                  child: Text(
                                'No Live Data...',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.green),
                              ));
                            } else if (deviceStatus != null) {
                              var status = dataprovider.data!.c!;

                              return Container(
                                margin: EdgeInsets.only(
                                  left: 10.h,
                                  right: 10.h,
                                  bottom: 24.v,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 5.h,
                                        right: 5.h,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 22.h,
                                              vertical: 6.v,
                                            ),
                                            decoration: AppDecoration
                                                .outlinePrimary4
                                                .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder10,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 11.v),
                                                CustomImageView(
                                                  imagePath:
                                                      ImageConstant.imgClock,
                                                  height: 73.adaptSize,
                                                  width: 73.adaptSize,
                                                  color: status.ms == 1
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                                SizedBox(height: 14.v),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 0.1.h),
                                                  child: status.ms == 1
                                                      ? Text("Power On".tr,
                                                          style: TextStyle(
                                                              fontSize: 23,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.green))
                                                      : Text("Power off".tr,
                                                          style: TextStyle(
                                                              fontSize: 23,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.red)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 153.v,
                                            width: 168.h,
                                            margin: EdgeInsets.only(left: 19.h),
                                            decoration: AppDecoration
                                                .outlinePrimary5
                                                .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .roundedBorder10,
                                                    color: Colors.indigo[900]),
                                            child: Column(
                                              children: [
                                                CustomImageView(
                                                  imagePath: status.rs == 0
                                                      ? ImageConstant.imgRain2
                                                      : ImageConstant
                                                          .imgRaining,
                                                  height: 100.adaptSize,
                                                  fit: BoxFit.fitHeight,
                                                  width: 106.adaptSize,
                                                  alignment: Alignment.center,
                                                ),
                                                Text(
                                                  status.rs == 0
                                                      ? 'No Rain'.tr
                                                      : 'Raining'.tr,
                                                  style: CustomTextStyles
                                                      .headlineSmallLilitaOneWhiteA70001,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 31.v),
                                    Center(
                                        child: status.lf == 0
                                            ? Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Image.asset(
                                                          'assets/images/lowflow.gif',
                                                          height: 120,
                                                          width: 370.h,
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ])
                                            : Container(
                                                color: Color.fromRGBO(
                                                    180, 200, 199, 1),
                                                height: 120,
                                                child: Center(
                                                  child: Text(
                                                    'Low Flow'.tr,
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ),
                                                width: 370.h,
                                              )),
                                    SizedBox(height: 27.v),
                                    FutureBuilder<type1?>(
                                        future: valve_detail_type1(
                                            widget.id.toString()),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'));
                                          }

                                          return Container(
                                            width: 550.h,
                                            height:widget.valve_no!=null ? widget.valve_no! * 38 :100,
                                            child: PageView(children: [
                                              if (snapshot.data!.c.m[0] != 0)
                                                _valve(
                                                    dataprovider.data!.c!,
                                                    dataprovider,
                                                    snapshot.data,
                                                    'A',
                                                    snapshot.data!.c.m[0]),
                                              if (snapshot.data!.c.m[1] != 0)
                                                _valve(
                                                    dataprovider.data!.c!,
                                                    dataprovider,
                                                    snapshot.data,
                                                    'B',
                                                    snapshot.data!.c.m[1]),
                                            ]),
                                          );
                                        }),
                                    SizedBox(height: 8.v)
                                  ],
                                ),
                              );
                            }
                            return const CircularProgressIndicator();
                          }),
                        ],
                      ),
                    ),
                  )),
            );
          }),
        ),
      ),
    );
  }

  Widget _valve(status, dataprovider, type1? type1data, String p, type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgArrowLeft,
          color: Colors.green,
          height: 20.v,
          width: 12.h,
          margin: EdgeInsets.only(
            top: 192.v,
            right: 5,
            bottom: 210.v,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 2.h),
            padding: EdgeInsets.symmetric(
              horizontal: 1.h,
              vertical: 16.v,
            ),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12.h, left: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: AppDecoration.outlinePrimary,
                        child: Text(
                          "Program".tr + p,
                          style: CustomTextStyles.headlineSmallRedA70001,
                        ),
                      ),
                      CustomOutlinedButton(
                        width: 148.h,
                        text: type == 1 ? "Irrigation".tr : "Fertilization".tr,
                        buttonStyle:
                            CustomButtonStyles.outlineWhiteATL15.copyWith(
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            return Colors.white;
                          }),
                        ),
                        buttonTextStyle:
                            CustomTextStyles.titleMediumWhiteA70001,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 21.v),
                SizedBox(height: 7.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 47.v,
                      crossAxisCount: 2,
                      mainAxisSpacing: 18.h,
                      crossAxisSpacing: 18.h,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.valve_no,
                    itemBuilder: (context, index) {
                      return _buildValveColumn3(p,
                          context,status.p,
                          index + 1,
                          status.v ?? 0,
                          status.rsf ?? 0,
                          status.p == 'A'
                              ? dataprovider.type2a!.c.vd![index]
                              : dataprovider.type3b!.c.vd![index],
                          status.bal!.toInt(),
                          status.sc);
                    },
                  ),
                ),
                SizedBox(height: 7.v),
              ],
            ),
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgarrowright,
          color: Colors.green,
          height: 20.v,
          width: 12.h,
          margin: EdgeInsets.only(
            top: 192.v,
            left: 5,
            bottom: 210.v,
          ),
        ),
      ],
    );
  }

  Future<Weather?> getWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('weather');
    print('stored data:${jsonString}');
    if (jsonString != null) {
      return Weather.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  /// Section Widget
  Widget _buildTemperatureSection(BuildContext context, String data) {
    return _futureWeatherData == null
        ? const CircularProgressIndicator(
            color: Colors.green,
          )
        : FutureBuilder<Weather?>(
            future: _futureWeatherData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                var datafetch = snapshot.data!;
                return Container(
                  margin: EdgeInsets.only(
                    left: 2.h,
                    right: 4.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 9.h,
                    vertical: 3.v,
                  ),
                  decoration:
                      AppDecoration.gradientTealToErrorContainer.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder15,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                "http:${datafetch.current!.condition!.icon}",
                                height: 100.adaptSize,
                                width: 80.adaptSize,
                              ),
                              Text(
                                "${datafetch.current!.tempC.toString()} °C",
                                style: theme.textTheme.displayLarge!
                                    .copyWith(fontSize: 44),
                              ),
                              Container(
                                width: 110.h,
                                margin: EdgeInsets.only(
                                  left: 18.h,
                                  top: 17.v,
                                  bottom: 10.v,
                                ),
                                child: Text(
                                  "High : ${datafetch.forecast!.forecastday![0].day!.maxtempC} C\nLow : ${datafetch.forecast!.forecastday![0].day!.mintempC} C",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 55.h),
                          child: Text(
                            "${datafetch.location!.name} | Feels like ${datafetch.current!.feelslikeC} °C",
                            style: theme.textTheme.titleMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.v),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(right: 2.h),
                          child: Text(
                            "${datafetch.current!.condition!.text} ",
                            style: CustomTextStyles.titleMediumWhiteA70001,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50.h,
                          right: 54.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgWind,
                              height: 30.adaptSize,
                              width: 30.adaptSize,
                              margin: EdgeInsets.only(
                                top: 5.v,
                                bottom: 2.v,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 5.h,
                                top: 2.v,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${datafetch.current!.windKph} km/h",
                                    style: theme.textTheme.titleSmall!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Wind",
                                    style: CustomTextStyles.bodySmall12_1,
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 105.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgRain2,
                                    height: 30.adaptSize,
                                    width: 30.adaptSize,
                                    margin: EdgeInsets.only(bottom: 6.v),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.v),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          " ${datafetch.forecast!.forecastday![0].day!.avghumidity}%",
                                          style: theme.textTheme.titleSmall!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "Humidity",
                                          style: CustomTextStyles.bodySmall12_1,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 17.v),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 50.h,
                          right: 48.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 120.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgRain,
                                    height: 30.adaptSize,
                                    width: 30.adaptSize,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 1.h),
                                        child: Text(
                                          "${datafetch.forecast!.forecastday![0].day!.dailyChanceOfRain}",
                                          style: theme.textTheme.titleSmall!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Text(
                                        "Chance(Rain)",
                                        style: theme.textTheme.bodySmall,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            CustomImageView(
                              imagePath: ImageConstant.imgDewPoint,
                              height: 30.adaptSize,
                              width: 30.adaptSize,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${datafetch.forecast!.forecastday![0].day!.totalprecipMm}",
                                    style: theme.textTheme.titleSmall!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Precipitation",
                                    style: theme.textTheme.bodySmall,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 17.v)
                    ],
                  ),
                );
              }
              return Text("error");
            });
  }

// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: AppDecoration.gradientTealToErrorContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder15,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppbarTitle(
                text: "DASHBOARD".tr,
                margin: EdgeInsets.symmetric(vertical: 6.h),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.grey.shade100,
                                  title:
                                      Text('IEMI: ${widget.iemi.toString()}'),
                                  content: Container(
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomElevatedButton(
                                            text: 'Update Device'.tr,
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateDevice(
                                                            id: widget.id,
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
                                            onPressed: () => Devices().deleteDevice(
                                                widget.id.toString(),context),
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
                              },
                            ),
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                          size: 45,
                        )),
                    Text(
                      'Settings'.tr,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      //  styleType: Style.bgGradientnamelightgreenA700namegreen800aa,
    );
  }

  Widget _buildLoranImage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 3.h,
        right: 4.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 26.h,
        vertical: 16.v,
      ),
      decoration: AppDecoration.outlinePrimary2.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 2.h,
              top: 6.v,
              bottom: 8.v,
            ),
            child: _buildLoranInfo(
              context,
              dynamicText1: widget.name.toString(),
              dynamicText2: widget.iemi.toString(),
            ),
          ),
          SizedBox(
            width: 75.h,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgRectangle4281,
            height: 85.v,
            width: 66.h,
            margin: EdgeInsets.only(top: 4.v),
          ),
        ],
      ),
    );
  }

  int? num;

  /// Section Widget
  Widget _buildValveColumn3(p,BuildContext context,type4p, num, int status, int rsf,
      int duration, int balanace, int complete) {
         if (complete == 1){
       return      Padding(
          padding: EdgeInsets.only(right: 10.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Valve ${num}",
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: 2.v),
            Container(
              decoration: BoxDecoration(
                  color:duration !=0 ? Colors.green[600] : Colors.grey,
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              height: 10,
            ),
          ]));}
   else if (rsf == 1) {
      if (duration != 0) {
        return Padding(
          padding: EdgeInsets.only(right: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Valve ${num}",
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: 2.v),
            
             
                 if(p=='A'&&type4p =='B')
                 Container(
                  decoration: BoxDecoration(
                      color: appTheme.green600,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                ) else if(p=='B'&&type4p =='A')
                 Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                )
              else if (num == status)
                Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: appTheme.blue900,
                          borderRadius: BorderRadius.circular(10)),
                      width: 150.h,
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),

                      width: 150.h *
                          (duration - balanace) /
                          duration, // here you can define your percentage of progress, 0.2 = 20%, 0.3 = 30 % .....
                      height: 10,
                    ),
                  ],
                )
              else if (num < status)
                Container(
                  decoration: BoxDecoration(
                      color: appTheme.green600,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                )
              else if (num > status)
                Container(
                  decoration: BoxDecoration(
                      color: appTheme.blue900,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                )
            ],
          ),
        );
      }
    } else if (rsf == 0) {
      return Padding(
          padding: EdgeInsets.only(right: 10.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Valve ${num}",
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: 2.v),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              height: 10,
            ),
          ]));
    }

    return CircularProgressIndicator();
  }

  /// Common widget
  Widget _buildLoranInfo(
    BuildContext context, {
    required String dynamicText1,
    required String dynamicText2,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dynamicText1,
          style: theme.textTheme.headlineSmall!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: 6.v),
        Text(
          dynamicText2,
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        )
      ],
    );
  }
}
