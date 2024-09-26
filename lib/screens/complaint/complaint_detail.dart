import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lca/api/complaints.dart';
import 'package:lca/model/complaint/complaint_register_model.dart';
import 'package:lca/widgets/app_decoration.dart';
import 'package:lca/widgets/custom_button_style.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'package:get/get.dart';
class FrameThirtyfiveScreen extends StatefulWidget {
  String token;
  String iemi;
  String? name;
  int? device_id;
  String? problem;
  int? problem_id;
  String? note;
   FrameThirtyfiveScreen({required this.token,
    Key? key,required this.iemi,this.name,this.note,this.problem,this.device_id,this.problem_id})
      : super(
          key: key,
        );

  @override
  State<FrameThirtyfiveScreen> createState() => _FrameThirtyfiveScreenState();
}

class _FrameThirtyfiveScreenState extends State<FrameThirtyfiveScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: null,
        body: Sizer(
          builder: (context, orientation, deviceType) {
         return SingleChildScrollView(
           child: Stack(
             alignment: Alignment.topCenter,
             children: [
               _buildBackColumn(context),
               Align(
                 alignment: Alignment.bottomCenter,
                 child: Container(
                   margin: EdgeInsets.only(
                     left: 29.h,
                     right: 29.h,
                   top: 200,
                    bottom: 50
                   ),
                   padding: EdgeInsets.symmetric(
                     horizontal: 14.h,
                     vertical: 41.v,
                   ),
               decoration: AppDecoration.outlinePrimary2.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),    child: Column(
                     mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Align(
                         alignment: Alignment.center,
                         child: Text(
                           "Complaint Details".tr,
                           style:
                            TextStyle(color: Colors.black,fontSize: 25)
                         ),
                       ),
                       SizedBox(height: 28.v),
                       Text(
                         "Device IMEI".tr,
                         style: theme.textTheme.titleMedium,
                       ),
                       SizedBox(height: 6.v),
                       Padding(
                         padding: EdgeInsets.only(left: 6.h),
                         child: Text(
                           widget.iemi.toString(),
                           style: CustomTextStyles.titleMediumBluegray900,
                         ),
                       ),
                       SizedBox(height: 25.v),
                       Text(
                         "Device Name".tr,
                         style: theme.textTheme.titleMedium,
                       ),
                       SizedBox(height: 7.v),
                       Padding(
                         padding: EdgeInsets.only(left: 6.h),
                         child: Text(
                           widget.name.toString(),
                           style: CustomTextStyles.titleMediumBluegray900,
                         ),
                       ),
                       SizedBox(height: 26.v),
                       Text(
                         "Problem".tr,
                         style: theme.textTheme.titleMedium,
                       ),
                       SizedBox(height: 7.v),
                       Padding(
                         padding: EdgeInsets.only(left: 6.h),
                         child: Text(
                           widget.problem.toString(),
                           style: CustomTextStyles.titleMediumBluegray900,
                         ),
                       ),
                       SizedBox(height: 26.v),
                       Text(
                         "Note".tr,
                         style: theme.textTheme.titleMedium,
                       ),
                       SizedBox(height: 9.v),
                       Container(
                         width: 301.h,
                         margin: EdgeInsets.only(
                           left: 6.h,
                           right: 3.h,
                         ),
                         child: Text(
                           widget.note.toString(),
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                           style: CustomTextStyles.titleMediumBluegray900
                               .copyWith(
                             height: 1.7,
                           ),
                         ),
                       ),
                       SizedBox(height: 25.v),
                       Padding(
                         padding: EdgeInsets.only(left: 6.h),
                         child: Text(
                           "Are all the details correct?".tr,
                           style: CustomTextStyles.titleMediumPoppinsRedA70001,
                         ),
                       ),
                       SizedBox(height: 1.v),
                       Padding(
                         padding: EdgeInsets.only(left: 6.h),
                         child: Text(
                           "Click Submit to confirm.".tr,
                           style:
                               CustomTextStyles.titleMediumPoppinsRedA70001
                         ),
                       ),
                       SizedBox(height: 73.v),
                       CustomElevatedButton(
                        onPressed: () {
                          register_complaint(widget.token, widget.device_id!.toString(), widget.note.toString(), widget.problem_id!.toString());
                       
                        },
                         width: 211.h,
                         height: 60.v,
                         text: "SUBMIT".tr,  buttonTextStyle: CustomTextStyles.headlineSmallPoppinsWhiteA70001,
                   
                         buttonStyle: CustomButtonStyles.outlineWhiteATL15,
                         //decoration: CustomButtonStyles.outlineWhiteATL15,
                         alignment: Alignment.center,
                       ),
                       SizedBox(height: 22.v),
                       CustomElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                         width: 211.h,
                         height: 60.v,
                         text: "EDIT".tr,
                         buttonStyle: CustomButtonStyles.outlineWhiteATL15.copyWith(
                          backgroundColor:   WidgetStateProperty.resolveWith((states) {
                        return Colors.purple;})
                        ,),
                      buttonTextStyle: CustomTextStyles.headlineSmallPoppinsWhiteA70001,
                         alignment: Alignment.center,
                       ),
                       
                     ],
                   ),
                 ),
               ),
            //   _buildColumn(context)
             ],
           ),
         );}
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBackColumn(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.h,
          vertical: 9.v,
        ),
        decoration: AppDecoration.bg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: Text(
                  "< Back".tr,
                  style: CustomTextStyles.titleMediumBluegray900,
                ),
              ),
            ),
            SizedBox(height: 25.v),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 10.h),
                        //    decoration: AppDecoration.outlineOnPrimaryContainer,
                child: Text(
                  "Register Complaint".tr,
                  style: theme.textTheme.displayMedium,
                  //style: CustomTextStyles.titleLargeGray50003,
                ),
              ),
            ),
            SizedBox(height: 15.v),
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: Text(
                  "Please Fill Out The Form To Register Your Complaint".tr,
                  style: CustomTextStyles.bodyLargeDMSans,
                ),
              ),
            ),
            SizedBox(height: 60.v)
          ],
        ),
      ),
    );
  }
}