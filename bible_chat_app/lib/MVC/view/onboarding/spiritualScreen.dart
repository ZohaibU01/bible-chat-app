import 'dart:async';

import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/onboarding/profileCompletion1_Screen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/struggleScreen.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Spiritualscreen extends StatelessWidget {
  Spiritualscreen({super.key});

  @override
  final onboardingcontroller = Get.put(Onboardingcontroller());

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
                  color: HexColor("#003180"),
                  // gradient: themecontroller.screenGradient,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/bg.png",
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.sp,
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.screenPadding),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Unlock Ultimate',
                                        style: themecontroller.customTextStyle(
                                            fontSize: 25.sp,
                                            letterSpacingPercent: -3,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: ' Peace\n',
                                        style: themecontroller.customTextStyle(
                                            fontSize: 25.sp,
                                            letterSpacingPercent: -3,
                                            color: themecontroller
                                                .colorPrimaryyellow,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: "in God's Guidance",
                                        style: themecontroller.customTextStyle(
                                            fontSize: 25.sp,
                                            letterSpacingPercent: -3,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.sp,
                              ),
                              Text(
                                  'Experience lasting freedom, clarity,\nand purpose in your spiritual life.',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w200))
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: Container(
                          // height: 500.sp,
                          // width: 300.sp,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    "assets/images/spiritualbg.png",
                                  ))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.sp, vertical: 20.sp),
                      child: RoundButton(
                        // gradient: true,
                        margin: 0,
                        backgroundColor: themecontroller.colorPrimarywhite,
                        height: 45.sp,
                        borderRadius: 10.sp,
                        title: 'Continue',
                        borderColor: Colors.transparent,
                        borderWidth: 1.sp,
                        sufixicon: Icons.arrow_forward_ios,
                        iconColor: Colors.black,
                        textColor: Colors.black,
                        onTap: () async {
                          Navigation.getInstance.RightToLeft_PageNavigation(
                              context, Profilecompletion1screen());
                        },
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
