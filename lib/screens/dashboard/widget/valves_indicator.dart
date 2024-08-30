import 'package:flutter/material.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/size_utils.dart';

/// Section Widget
Widget buildValveColumn3(p, BuildContext context, type4p, int num, int status,
    int rsf, int duration, int balanace, int complete, int vn, int card_index) {
  if (complete == 1) {
    return Padding(
        padding: EdgeInsets.only(right: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Valve ${num}",
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 2.v),
          Container(
            decoration: BoxDecoration(
                color: duration != 0 ? appTheme.green600 : Colors.grey,
                borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width,
            height: 10,
          ),
        ]));
  }
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
          if (p == 'A' && type4p == 'B')
            Container(
              decoration: BoxDecoration(
                  color: appTheme.green600,
                  borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              height: 10,
            )
          else if (p == 'B' && type4p == 'A')
            Container(
              decoration: BoxDecoration(
                  color: appTheme.blue900,
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
                      color: appTheme.green600,
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
  if (card_index == 0 && vn >= 24 && rsf == 0) {
    return Padding(
        padding: EdgeInsets.only(right: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Valve ${num}",
            style: theme.textTheme.bodyLarge,
          ),
          SizedBox(height: 2.v),
          Container(
            decoration: BoxDecoration(
                color: duration != 0 ? appTheme.green600 : Colors.grey,
                borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width,
            height: 10,
          ),
        ]));
  }
  return Padding(
      padding: EdgeInsets.only(right: 10.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Valve ${num}",
          style: theme.textTheme.bodyLarge,
        ),
        SizedBox(height: 2.v),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey[600], borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width,
          height: 10,
        ),
      ]));
}
