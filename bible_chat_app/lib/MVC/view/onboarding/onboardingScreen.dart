import 'dart:async';

import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Onboardingscreen extends StatelessWidget {
  Onboardingscreen({super.key});

  @override
  final onboardingcontroller = Get.put(Onboardingcontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(initState: (state) {
      onboardingcontroller.blinkAnimation(context);
    }, builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStylesplash,
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: themecontroller.screenGradient,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/bg.png",
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: onboardingcontroller.showlogo.value ? 1.0 : 0.0,
                    child: Column(
                      children: [
                        Hero(
                          tag: 'appicon',
                          child: Container(
                            height: 100.sp,
                            width: 100.sp,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/appicon.png",
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 90.sp,
                        ),
                        Text(
                          'Use Genesis to',
                          style: themecontroller.customTextStyle(
                            fontSize:
                                30.sp,
                            letterSpacingPercent: -3,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Obx(
                          () => AnimatedContainer(
                            duration: Duration(seconds: 5),
                            padding: EdgeInsets.all(10.sp),
                            decoration: BoxDecoration(
                                color:
                                    HexColor("#404040").withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Text(
                              onboardingcontroller.blinkText.value,
                              style: themecontroller.customTextStyle(
                                fontSize:
                                    30.sp,
                                letterSpacingPercent: -3,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
