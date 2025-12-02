import 'dart:async';

import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/onboarding/AgeScreen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/bibleVersionScreen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/sliderScreen.dart';
import 'package:bible_chat_app/components/progressLineWidget.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/components/stepProgressBar.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/data/mockData.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Bibleversionscreen extends StatelessWidget {
  Bibleversionscreen({super.key});

  @override
  final onboardingcontroller = Get.put(Onboardingcontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(initState: (state) {
      Timer(
        Duration(milliseconds: 300),
        () {
          onboardingcontroller.progressLine.value = 40.0;
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
            padding: EdgeInsets.only(top: 20.sp),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 80.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: Obx(() => progressLine(
                            percentage:
                                onboardingcontroller.progressLine.value)),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text(
                        onboardingcontroller.questions
                            .firstWhere(
                              (e) => e.id == 2,
                            )
                            .questionText,
                        // 'What is your preferred\nBible version?',
                        textAlign: TextAlign.center,
                        style: themecontroller.customTextStyle(
                            fontSize: 25.sp,
                            letterSpacingPercent: -3,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Column(
                        children: onboardingcontroller.questions
                            .firstWhere(
                              (e) => e.id == 2,
                            )
                            .options!
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          var e = entry.value;

                          return TweenAnimationBuilder(
                            duration: Duration(
                                milliseconds:
                                    300 + (index * 100)), // Staggered delay
                            tween: Tween<Offset>(
                                begin: Offset(1.5, 0), end: Offset(0, 0)),
                            curve: Curves.easeOut,
                            builder: (context, Offset offset, child) {
                              return Transform.translate(
                                offset: offset *
                                    MediaQuery.of(context)
                                        .size
                                        .width, // Apply translation
                                child: SpringWidget(
                                  onTap: () {
                                    onboardingcontroller
                                        .Selected_BibleVersion.value = e.id;
                                    onboardingcontroller.answers.value =
                                        e.optionText;
                                  },
                                  child: Obx(
                                    () => AnimatedContainer(
                                      duration: Duration(milliseconds: 400),
                                      height: 60.sp,
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.sp, vertical: 5.sp),
                                      decoration: BoxDecoration(
                                        color: onboardingcontroller
                                                    .Selected_BibleVersion
                                                    .value ==
                                                e.id
                                            ? Colors.white
                                            : Colors.white
                                                .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(16.sp),
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 250.sp,
                                          child: Text(
                                            e.optionText,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: onboardingcontroller
                                                          .Selected_BibleVersion
                                                          .value ==
                                                      e.id
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 0.sp,
                  right: 0.sp,
                  bottom: 0.sp,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.sp, vertical: 20.sp),
                    child: Obx(
                      () => RoundButton(
                        gradient: false,
                        margin: 0,
                        backgroundColor: themecontroller.colorPrimarywhite,
                        height: 45.sp,
                        borderRadius: 10.sp,
                        title: 'Continue',
                        disabled: onboardingcontroller.isLoading.value,
                        loading: onboardingcontroller.isLoading.value,
                        borderColor: Colors.transparent,
                        borderWidth: 1.sp,
                        sufixicon: Icons.arrow_forward_ios,
                        iconColor: Colors.black,
                        textColor: Colors.black,
                        onTap: () async {
                          if (onboardingcontroller
                                  .Selected_BibleVersion.value !=
                              0) {
                            onboardingcontroller.questionid.value = 2;
                            await onboardingcontroller.Submitanswer();
                            Navigation.getInstance.RightToLeft_PageNavigation(
                                context, Sliderscreen());
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please Select Bible Version');
                          }
                        },
                      ),
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
