import 'dart:async';

import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/onboarding/profileCompletion1_Screen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/spiritualScreen.dart';
import 'package:bible_chat_app/components/custom_textfiled.dart';
import 'package:bible_chat_app/components/progressLineWidget.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Strugglescreen extends StatelessWidget {
  Strugglescreen({super.key});

  @override
  final onboardingcontroller = Get.put(Onboardingcontroller());
  final FocusNode struggleFocusNode = FocusNode();

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(initState: (state) {
      Timer(
        Duration(milliseconds: 300),
        () {
          onboardingcontroller.progressLine.value = 100.0;
          struggleFocusNode.requestFocus();
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
            padding: EdgeInsets.symmetric(vertical: 40.sp),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 70.sp,
                        ),
                        Obx(() => progressLine(
                            percentage:
                                onboardingcontroller.progressLine.value)),
                        SizedBox(
                          height: 20.sp,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'The Bible has the',
                                style: themecontroller.customTextStyle(
                                    fontSize: 25.sp,
                                    letterSpacingPercent: -3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ' solution\n',
                                style: themecontroller.customTextStyle(
                                    fontSize: 25.sp,
                                    letterSpacingPercent: -3,
                                    color: themecontroller.colorPrimaryyellow,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text:
                                      'to all your problems. Let \nus know what you’re \nfacing, and we’ll help you \nheal.',
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
                            'Your Privacy is guaranteed and your \ninformation will remain confidential.',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w200)),
                        SizedBox(
                          height: 25.sp,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.5)),
                              borderRadius: BorderRadius.circular(20)),
                          child: CustomTextFieldWidget(
                            controller: onboardingcontroller.StruggleController,
                            hintText: 'Share your struggles...',
                            focusNode: struggleFocusNode,
                            onsubmit: () {},
                            TextColor: Colors.white.withValues(alpha: 0.4),
                            inputType: TextInputType.name,
                            label: '',
                            enabled: true,
                            maxLines: 7,
                            borderRadius: 20.sp,
                            fieldColor: Colors.black.withValues(alpha: 0.5),
                            height: 150.sp,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0.sp,
                  right: 0.sp,
                  bottom: -20.sp,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.sp, vertical: 20.sp),
                    child: Obx(
                      () =>  RoundButton(
                        // gradient: true,
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
                          onboardingcontroller.answers.value =
                              onboardingcontroller
                                  .StruggleController.value.text;
                          onboardingcontroller.questionid.value = 4;
                          await onboardingcontroller.Submitanswer();
                          Navigation.getInstance.RightToLeft_PageNavigation(
                              context, Spiritualscreen());
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
