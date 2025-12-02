import 'dart:async';

import 'package:bible_chat_app/components/customRangeSlider.dart';
import 'package:bible_chat_app/components/progressLineWidget.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/homeController.dart';

class Yourverselistenscreen extends StatelessWidget {
  Yourverselistenscreen({
    super.key,
    required this.heading,
    required this.mints,
    required this.icon,
    required this.verse,
    required this.background,
    required this.verse_ref,
  });

  final String heading;
  final String background;
  final String mints;
  final String icon;
  final String verse;
  final String verse_ref;
  @override
  final homecontroller = Get.put(Homecontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(initState: (state) {
      Timer(
        Duration(microseconds: 900),
        () {
          homecontroller.journeyprogressLine.value = 100.0;
        },
      );
    }, builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStylesplash,
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/${background}",
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 50.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Text(
                      "Your Journey",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        homecontroller.journeyprogressLine.value = 0.0;
                        homecontroller.journeyslider.value = 50.0;
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress today',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => Text(
                            homecontroller.journeyprogressLine.value == 0.0
                                ? '0 %'
                                : '100 %',
                            style: TextStyle(
                                color: themecontroller.colorPrimaryyellow,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.sp),
                      child: Obx(() => progressLine(
                          height: 5,
                          backContainerColor: Colors.white,
                          percentage:
                              homecontroller.journeyprogressLine.value)),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/${icon}",
                        color: Colors.white,
                        height: 20.sp,
                        width: 20.sp,
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: heading.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "  ${mints} MIN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                       verse,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text(
                        verse_ref,
                        style: TextStyle(
                            color: themecontroller.colorPrimaryyellow,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        progressLine(
                          percentage: 20.sp,
                          height: 5,
                          backContainerColor:
                              Colors.white.withValues(alpha: 0.2),
                          frontContainerColor: Colors.white,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "00:01",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "02:00",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/share.svg",
                              height: 20.sp,
                              width: 20.sp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 150.sp,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/back.svg",
                                    height: 20.sp,
                                    width: 20.sp,
                                    color: Colors.white,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/play.svg",
                                    height: 20.sp,
                                    width: 20.sp,
                                    color: Colors.white,
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/forword.svg",
                                    height: 20.sp,
                                    width: 20.sp,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/icons/restart.svg",
                              height: 20.sp,
                              width: 20.sp,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
