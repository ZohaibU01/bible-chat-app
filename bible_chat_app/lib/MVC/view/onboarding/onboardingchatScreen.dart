import 'dart:async';
import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/onboarding/donominationScreen.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hexcolor/hexcolor.dart';

class OnboardingChatScreen extends StatefulWidget {
  @override
  _OnboardingChatScreenState createState() => _OnboardingChatScreenState();
}

class _OnboardingChatScreenState extends State<OnboardingChatScreen> {
  @override
  final onboardingcontroller = Get.put(Onboardingcontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
      initState: (state) {
        Timer(
          Duration(seconds: 1),
          () {
            print("Done");
            onboardingcontroller.showmsg.value = true;
          },
        );
      },
      builder: (themeController) {
        return AnnotatedRegion(
          value: themeController.systemUiOverlayStylesplash,
          child: Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: themeController.screenGradient,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/bg.png",
                  ),
                ),
              ),
              child: Stack(
                // alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    top: 80.sp,
                    right: 0.sp,
                    left: 0.sp,
                    child: Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //--first message
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.sp),
                                    bottomLeft: Radius.circular(20.sp),
                                    bottomRight: Radius.circular(20.sp),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10.sp,horizontal: 30.sp),
                                child: Text(
                                  'How can I overcome temptation?',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor("#000428"),
                                  ),
                                )

                                //  AnimatedTextKit(
                                //   animatedTexts: [
                                //     TypewriterAnimatedText(
                                // 'How can I overcome temptation?',
                                // textStyle: TextStyle(
                                //   fontSize: 13.sp,
                                //   fontWeight: FontWeight.w400,
                                //   color: HexColor("#000428"),
                                // ),
                                //       speed: Duration(milliseconds: 70),
                                //     ),
                                //   ],
                                //   totalRepeatCount: 1,
                                //   pause: Duration(milliseconds: 1000),
                                //   displayFullTextOnTap: true,
                                //   stopPauseOnTap: true,
                                //   onFinished: () {
                                // print("Done");
                                // onboardingcontroller.showmsg.value = true;
                                //   },
                                // ),
                                ),

                            SizedBox(
                              height: 20,
                            ),
                            //--second message
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 10),
                              child: AnimatedOpacity(
                                opacity: onboardingcontroller.showmsg.value
                                    ? 1.0
                                    : 0.0,
                                duration: Duration(seconds: 1),
                                child: Visibility(
                                  visible: onboardingcontroller.showmsg.value,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: HexColor("#404040")
                                            .withValues(alpha: 0.5),
                                        borderRadius: BorderRadius.only(
                                          // topLeft: Radius.circular(20.sp),
                                          topRight: Radius.circular(20.sp),
                                          bottomLeft: Radius.circular(20.sp),
                                          bottomRight: Radius.circular(20.sp),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(15.sp),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AnimatedTextKit(
                                            animatedTexts: [
                                              TypewriterAnimatedText(
                                                cursor: "",
                                                "You can overcome temptation by seeking God and building spiritual discipline whenever you feel tempted. Strengthen your faith through daily prayer, scripture meditation, and a closer relationship with Him. When you prioritize God’s presence, sin loses its grip, and resistance becomes easier. When Jesus was tempted, He responded with scripture. You can do the same by memorizing verses that remind you of God’s strength and promises.\n\nAs it is written in 1 Corinthians 10:13, “God is\nfaithful; he will not let you be tempted beyond\nwhat you can bear. But when you are tempted,\nhe will also provide a way out so that you can\nendure it.”",
                                                textAlign: TextAlign.left,
                                                textStyle: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                                speed:
                                                    Duration(milliseconds: 10),
                                              ),
                                            ],
                                            totalRepeatCount: 1,
                                            pause: Duration(milliseconds: 1000),
                                            displayFullTextOnTap: true,
                                            stopPauseOnTap: true,
                                            onFinished: () {
                                              print("Done");
                                              onboardingcontroller
                                                  .showSharebtn.value = true;
                                            },
                                          ),
                                          SizedBox(
                                            height: 10.sp,
                                          ),
                                          AnimatedOpacity(
                                            duration: Duration(seconds: 1),
                                            opacity: onboardingcontroller
                                                    .showSharebtn.value
                                                ? 1.0
                                                : 0.0,
                                            child: Container(
                                              width: 80.sp,
                                              height: 35.sp,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 7.sp),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.sp),
                                                  color: Colors.white),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/icons/share.svg",
                                                    height: 15.sp,
                                                    width: 15.sp,
                                                    color: themeController
                                                        .colorPrimaryBlue,
                                                  ),
                                                  SizedBox(
                                                    width: 5.sp,
                                                  ),
                                                  Text(
                                                    'Share',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom Gradient & Button
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(20.sp),
                      decoration: BoxDecoration(
                          // gradient: LinearGradient(
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          //   colors: [
                          //     Colors.transparent,
                          //     themeController.colorPrimaryBlue.withOpacity(0.9),
                          //   ],
                          // ),
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Strengthen your relationship \nwith God",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          RoundButton(
                            gradient: false,
                            margin: 0,
                            backgroundColor:Colors.white,
                            height: 45.sp,
                            borderRadius: 10.sp,
                            title: 'Continue',
                            borderColor: Colors.transparent,
                            borderWidth: 1.sp,
                            sufixicon: Icons.arrow_forward_ios,
                            iconColor: Colors.black,
                            textColor: Colors.black,
                            onTap: () {
                              Navigation.getInstance
                                  .pagePushAndReplaceNavigation(
                                      context, Donominationscreen());
                            },
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
      },
    );
  }
}
