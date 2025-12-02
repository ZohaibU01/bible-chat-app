import 'dart:async';
import 'dart:ffi';

import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/onboarding/personalized1_Screen.dart';
import 'package:bible_chat_app/components/progressLineWidget.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Analyzinggoal2screen extends StatelessWidget {
  Analyzinggoal2screen({super.key});

  @override
  final onboardingcontroller = Get.put(Onboardingcontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(initState: (state) {
      Timer(
        Duration(milliseconds: 300),
        () {
          onboardingcontroller.Goalsloading.value =
              double.parse(onboardingcontroller.questions
                  .firstWhere(
                    (e) => e.id == 7,
                  )
                  .weight
                  .toString());
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 100.sp,
                      ),
                      Container(
                        height: 120.sp,
                        width: 120.sp,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/appicon.png",
                                ))),
                      ),
                      SizedBox(
                        height: 50.sp,
                      ),
                      Text('Analyzing your Goals...',
                          style: themecontroller.customTextStyle(
                              fontSize: 24.sp,
                              letterSpacingPercent: -3,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Profile',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '100%',
                                style: TextStyle(
                                    color: themecontroller.colorPrimaryyellow,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.sp),
                            child: Obx(() => progressLine(
                                height: 5,
                                percentage:
                                    onboardingcontroller.profileloading.value)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Goals',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${onboardingcontroller.questions.firstWhere(
                                      (e) => e.id == 8,
                                    ).weight}%',
                                style: TextStyle(
                                    color: themecontroller.colorPrimaryyellow,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.sp),
                            child: Obx(() => progressLine(
                                height: 5,
                                percentage:
                                    onboardingcontroller.Goalsloading.value)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.sp),
                        child: Container(
                          padding: EdgeInsets.all(30.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/images/gradient2.png",
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'To move forward, please specify',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey.withValues(alpha: 0.7),
                                    fontSize: 12.sp),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Text(
                                onboardingcontroller.questions
                                    .firstWhere(
                                      (e) => e.id == 8,
                                    )
                                    .questionText,
                                // 'Would you like to receive specialized guidance tailored to your struggles?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp),
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Obx(
                                        () => SpringWidget(
                                          onTap: onboardingcontroller
                                                  .isLoading.value
                                              ? () {}
                                              : () async {
                                                  onboardingcontroller
                                                      .questionid.value = 8;
                                                  onboardingcontroller
                                                      .answers.value = "no";
                                                  await onboardingcontroller
                                                      .Submitanswer();
                                                  Navigation.getInstance
                                                      .RightToLeft_PageNavigation(
                                                          context,
                                                          Personalized1screen());
                                                },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: onboardingcontroller
                                                        .isLoading.value
                                                    ? Colors.white
                                                        .withValues(alpha: 0.5)
                                                    : Colors.white
                                                        .withValues(alpha: 0.2),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.sp)),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 7.sp),
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                  color: onboardingcontroller
                                                          .isLoading.value
                                                      ? Colors.white.withValues(
                                                          alpha: 0.5)
                                                      : Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Obx(
                                        () => SpringWidget(
                                          onTap: onboardingcontroller
                                                  .isLoading.value
                                              ? () {}
                                              : () async {
                                                  onboardingcontroller
                                                      .questionid.value = 8;
                                                  onboardingcontroller
                                                      .answers.value = "yes";
                                                  await onboardingcontroller
                                                      .Submitanswer();
                                                  Navigation.getInstance
                                                      .RightToLeft_PageNavigation(
                                                          context,
                                                          Personalized1screen());
                                                },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: onboardingcontroller
                                                        .isLoading.value
                                                    ? themecontroller
                                                        .colorPrimarywhite
                                                        .withValues(alpha: 0.5)
                                                    : themecontroller
                                                        .colorPrimarywhite,
                                                // gradient: themecontroller.btnGradient,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.sp)),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 7.sp),
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                  color: onboardingcontroller
                                                          .isLoading.value
                                                      ? Colors.black.withValues(
                                                          alpha: 0.5)
                                                      : Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
