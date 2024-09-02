import 'package:flutter/material.dart';
import 'package:lca/api/complaints.dart';
import 'package:lca/api/formatter.dart';
import 'package:lca/model/complaint/complaint_detail_model.dart';
import 'package:lca/widgets/app_decoration.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart'; // ignore_for_file: must_be_immutable
import 'package:get/get.dart';
class FrameNineteenPage extends StatefulWidget {
  String? token;
  FrameNineteenPage({Key? key, this.token})
      : super(
          key: key,
        );

  @override
  State<FrameNineteenPage> createState() => _FrameNineteenPageState();
}

class _FrameNineteenPageState extends State<FrameNineteenPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray100F4,
        appBar: _buildAppBar(context),
        body: Sizer(builder: (context, orientation, deviceType) {
          return SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 10.h,
                vertical: 23.v,
              ),
              child: Column(
                children: [
                  _buildRowNine(context),
                  SizedBox(height: 22.v),
                  _buildRowTicketNo(context),
                  SizedBox(height: 6.v),
                  Container(
                      height: 700.v,
                      margin: EdgeInsets.only(right: 1.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.h,
                        vertical: 14.v,
                      ),
                      decoration: AppDecoration.fillWhiteA700.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder4,
                      ),
                      child: FutureBuilder<ComplaintDetail>(
                          future: complaint(widget.token.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.content!.length,
                                  itemBuilder: (context, index) {
                                    var item = snapshot.data!.content![index];
                                    print("name ${item}");
                                    String formattedTime = formatTime(
                                        item.registeredDate.toString());
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: 2.h,
                                        right: 1.h,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.id.toString(),
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                          SizedBox(
                                            width: 50.h,
                                          ),
                                          Text(
                                            formattedTime,
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                          SizedBox(
                                            width: 50.h,
                                          ),
                                          Text(
                                            item.statusName.toString(),
                                            style: CustomTextStyles
                                                .titleMediumPoppinsRedA70001,
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            }
                            return CircularProgressIndicator();
                          })),
                  SizedBox(height: 5.v)
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitle(
        text: "My Complaints".tr,
      ),
      styleType: Style.bgGradientnamelightgreenA700namegreen800aa,
    );
  }

  /// Section Widget
  Widget _buildRowNine(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomElevatedButton(
          height: 78.v,
          width: 191.h,
          text: "Pending".tr,
          rightIcon: Container(
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.h, 12.v, 18.h, 18.v),
              child: FutureBuilder<int>(
                future: complaint_count(widget.token.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.fSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }
                  return Text('',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.fSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ));
                },
              ),
            ),
          ),
          buttonStyle: CustomButtonStyles.none,
          decoration: AppDecoration.ffd.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          buttonTextStyle: CustomTextStyles.titleLargePoppinsWhiteA70001,
        ),
        CustomElevatedButton(
          height: 78.v,
          width: 191.h,
          text: "Resolved",
          rightIcon: Container(
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.h, 12.v, 16.h, 18.v),
              child: FutureBuilder<int>(
                future: complaint_count_closed(widget.token.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ));
                  } else if (snapshot.hasError) {
                    return Center(child: GestureDetector(onTap: (){print(snapshot.error);},
                      child: Text('Error: ${snapshot.error}')));
                  } else if (snapshot.hasData) {
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.fSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }
                  return Text('',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30.fSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ));
                },
              ),
            ),
          ),
          buttonStyle: CustomButtonStyles.none,
          decoration: AppDecoration.ffd.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder10,
          ),
          buttonTextStyle: CustomTextStyles.titleLargePoppinsWhiteA70001,
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildRowTicketNo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1.h),
      padding: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.fillGrayF.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4, color: Colors.grey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Ticket No".tr,
            style: theme.textTheme.titleLarge,
          ),
          Text(
            "Date".tr,
            style: theme.textTheme.titleLarge,
          ),
          Padding(
            padding: EdgeInsets.only(right: 5.h),
            child: Text(
              "Status".tr,
              style: theme.textTheme.titleLarge,
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildStack2102Twenty(
    BuildContext context, {
    required String date,
    required String date1,
  }) {
    return SizedBox(
      height: 25.v,
      width: 66.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              date,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              date1,
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
              ),
            ),
          )
        ],
      ),
    );
  }
}
