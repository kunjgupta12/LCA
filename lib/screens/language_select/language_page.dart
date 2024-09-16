import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lca/api/language_shared_pref.dart';
import 'package:lca/screens/auth/login.dart';
import 'package:lca/widgets/custom_text_style.dart';
import 'package:lca/widgets/image_constant.dart';
import 'package:get/get.dart';
final List locale = [
  {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
  {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
  {'name': 'मराठी', 'locale': Locale('mr', 'IN')},
  {'name': 'ગુજરાતી', 'locale': Locale('gu', 'IN')},
 // {'name': 'ಕನ್ನಡ', 'locale': Locale('kn', 'IN')},
 // {'name': 'தமிழ்', 'locale': Locale('ta', 'IN')},
//  {'name': 'తెలుగు', 'locale': Locale('te', 'IN')},
];


void updateLanguage(Locale locale)async {
  Get.back();

  Get.updateLocale(locale);
  log(locale.toString());
  save_pref(locale.toString());
  // locale_stored= await save_pref(locale.toString()).toString();
}


class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  bool select = false;
  int selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgFrameFive,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Select  Language',
                      style: CustomTextStyles.displayMedium48,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      width: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(locale[index]['name']),
                                    Radio(
                                        value: index,
                                        activeColor: Colors
                                            .green, // Change the active radio button color here
                                        fillColor: WidgetStateProperty.all(Colors
                                            .green), // Change the fill color when selected

                                        groupValue: selectedOption,
                                        onChanged: (value) {
                                          selectedOption = value as int;

                                          setState(() {
                                            selectedOption = value as int;
                                          });
                                          print(locale[index]['locale']);
                                          updateLanguage(
                                              locale[index]['locale']);
                                        }),

                                    /// Text(locale[index]['name']),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.blue,
                              );
                            },
                            itemCount: locale.length),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(FrameThirteenScreen());
                      },
                      child: Center(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color.fromARGB(255, 105, 194, 82))),
                            width: 150,
                            height: 50,
                            child: Center(
                              child: Text(
                                'Next',
                                style:
                                    CustomTextStyles.labelLargeRobotoBlack90001,
                              ),
                            )),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  buildLanguageDialog(BuildContext context) {
    AlertDialog(
      title: Text('Choose Your Language'),
      content: Container(
        width: double.maxFinite,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Text(locale[index]['name']),
                  onTap: () {
                    print(locale[index]['name']);
                    updateLanguage(locale[index]['locale']);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.blue,
              );
            },
            itemCount: locale.length),
      ),
    );
  }
}
