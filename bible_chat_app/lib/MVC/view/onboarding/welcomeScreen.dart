import 'dart:async';

import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/onboarding/onboardingScreen.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/helper/data_storage.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Welcomescreen extends StatelessWidget {
  Welcomescreen({super.key});

  @override
  final onboardingcontroller = Get.put(Onboardingcontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(initState: (state) {
      Timer(
        Duration(seconds: 1),
        () async {
          await DataStroge.getInstance.getUserData();
          Navigation.getInstance
              .pagePushAndReplaceNavigationfade(context, Onboardingscreen());
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
                            height: 140.sp,
                            width: 140.sp,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/appicon.png",
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Text(
                          'Genesis - Bible Chat',
                          style: themecontroller.customTextStyle(
                            fontSize:
                                30.sp,
                            letterSpacingPercent: -3,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '"In the beginning God created the \nheavens and the earth."',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white
                                .withOpacity(0.5), // Corrected opacity method
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic, // Added italic style
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
