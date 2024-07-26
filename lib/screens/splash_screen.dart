import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lca/screens/bottom_nav/frame_nineteen_container_screen.dart';
import 'package:lca/screens/language_select/language_page.dart';
import 'package:lca/widgets/custom_image.dart';
import 'package:lca/widgets/image_constant.dart';
import 'package:get/get.dart';

import '../model/weather/weather_model.dart';

class FrameFiveScreen extends StatefulWidget {
  String? token;

  final Future<Weather>? futureWeatherData;
  FrameFiveScreen({Key? key, this.token, this.futureWeatherData})
      : super(
          key: key,
        );

  @override
  State<FrameFiveScreen> createState() => _FrameFiveScreenState();
}

class _FrameFiveScreenState extends State<FrameFiveScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      print(widget.token);

      (widget.token != null &&
              JwtDecoder.isExpired(widget.token.toString()) == false)
          ? {
              Get.offAll(FrameNineteenContainerScreen(
                futureWeatherData: widget.futureWeatherData,
              )),
            }
          : Get.offAll(const LanguageSelector());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgFrameFive,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgRectangle4284,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
