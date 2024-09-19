import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lca/model/device_status/type1.dart';
import 'package:lca/screens/dashboard/widget/valves_indicator.dart';
import 'package:lca/widgets/app_decoration.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_outlined_button.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/utils/size_utils.dart';

Widget valve(
  int valveCount,
  dynamic status,
  dynamic dataProvider,
  type1? type1Data,
  String p,
  int type,
  int indexV,
) {
  Widget buildStartTimeLabel(index_v) {
        if ((status.vn <= 11&&index_v==0)  ||
                              (status.vn >= 24 && status.vn <= 35&&index_v==1))
                        return     Container(
                              decoration: AppDecoration.outlinePrimary,
                              child: Text(
                                "Start Time 1".tr,
                                style: CustomTextStyles.titleMediumBluegray900,
                              ),
                            );
                            if ((status.vn >= 12  && status.vn <= 23 && index_v==0) ||
                              (status.vn >= 36 && status.vn <= 47&& index_v==1))
                      return      Container(
                              decoration: AppDecoration.outlinePrimary,
                              child: Text(
                                "Start Time 2".tr,
                                style: CustomTextStyles.titleMediumBluegray900,
                              ),
                            );
                            return SizedBox.shrink();
  }

  Widget buildProgramLabel() {
    return Container(
      decoration: AppDecoration.outlinePrimary,
      child: Text(
        indexV == 0 ? "Program A".tr : "Program B".tr,
        style: CustomTextStyles.headlineSmallRedA70001,
      ),
    );
  }

  Widget buildActionButton() {
    return CustomOutlinedButton(
      width: 152.h,
      text: type == 1 ? "Irrigation".tr : "Fertilization".tr,
      buttonStyle: CustomButtonStyles.outlineWhiteATL15.copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) => Colors.white),
      ),
      buttonTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
    );
  }

  Widget buildValveGrid() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 47.v,
        crossAxisCount: 2,
        mainAxisSpacing: 18.h,
        crossAxisSpacing: 18.h,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: valveCount,
      itemBuilder: (context, index) {
        return buildValveColumn3(
          p,
          context,
          status.p,
          index + 1,
          status.v ?? 0,
          status.rsf ?? 0,
          indexV == 0
              ? dataProvider.type2a!.c.vd![index]
              : dataProvider.type3b!.c.vd![index],
          status.bal!.toInt(),
          status.sc,
          status.vn,
          indexV,
        );
      },
    );
  }

  return ConstrainedBox(
    constraints: BoxConstraints(maxHeight: 400.h),
    child: Container(
      margin: EdgeInsets.only(left: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 16.v),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProgramLabel(),
                    buildStartTimeLabel(indexV),
              
                  ],
                ),
                buildActionButton(),
              ],
            ),
          ),
          SizedBox(height: 21.v),
          SizedBox(height: 7.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: buildValveGrid(),
          ),
          SizedBox(height: 7.v),
        ],
      ),
    ),
  );
}
