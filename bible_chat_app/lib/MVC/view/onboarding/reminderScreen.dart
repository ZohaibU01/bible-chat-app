import 'dart:async';
import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/onboarding/analyzingGoal1_Screen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/selectPlanScreen.dart';
import 'package:bible_chat_app/components/progressLineWidget.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Reminderscreen extends StatelessWidget {
  Reminderscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        initState: (state) {},
        builder: (themecontroller) {
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
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 100.sp,
                      ),
                      Text(
                        'We’ll send you a\nreminder before you\nfree trial ends.',
                        textAlign: TextAlign.center,
                        style: themecontroller.customTextStyle(
                            fontSize: 33.sp,
                            letterSpacingPercent: -3,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(
                              "assets/images/bell.gif",
                            ),
                          ),
                        ),
                      )),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.done,
                                color: themecontroller.colorPrimaryyellow,
                                size: 25.sp,
                              ),
                              SizedBox(
                                width: 5.sp,
                              ),
                              Text(
                                'No Payment Due Now',
                                style: TextStyle(
                                    fontSize: 15.sp, color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          RoundButton(
                            // gradient: true,
                            margin: 0,
                            backgroundColor: themecontroller.colorPrimarywhite,
                            height: 45.sp,
                            borderRadius: 10.sp,
                            title: 'Continue for Free',
                            borderColor: Colors.transparent,
                            borderWidth: 1.sp,
                            iconColor: themecontroller.colorwhite,
                            textColor: Colors.black.withOpacity(0.8),
                            onTap: () async {
                              Navigation.getInstance.RightToLeft_PageNavigation(
                                  context, Selectplanscreen());
                            },
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Text(
                            "7-days free, then \$49.99/yr (~\$4.17/mo)",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white.withValues(alpha: 0.6)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40.sp,
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
