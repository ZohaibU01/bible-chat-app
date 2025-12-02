import 'package:bible_chat_app/components/customRangeSlider.dart';
import 'package:bible_chat_app/components/progressLineWidget.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/homeController.dart';

class myjourneyscreen extends StatelessWidget {
  myjourneyscreen({super.key});

  @override
  final homecontroller = Get.put(Homecontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(
        initState: (state) {
          homecontroller.showNextbtn.value = false;
        },
        builder: (themecontroller) {
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
                      "assets/images/lightgradient.png",
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
                              color: Colors.black,
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
                            color: Colors.black,
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
                                  color: Colors.black,
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
                            "assets/icons/bird.svg",
                            color: Colors.black,
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
                                  text: "Spiritual journal".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "  1 MIN",
                                  style: TextStyle(
                                      color: Colors.black,
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
                            'How is your relationship\nwith God today?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                          Container(
                            padding: EdgeInsets.all(15.sp),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1.5,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.sp),
                            ),
                            child: Text(
                              'Slide to select',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/heartbrake.svg",
                            color: Colors.black,
                            height: 20.sp,
                            width: 20.sp,
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Expanded(
                            child: Obx(
                              () => GradientSlider(
                                value: homecontroller.journeyslider.value,
                                onChanged: (value) {
                                  homecontroller.journeyslider.value = value;
                                  if (homecontroller.journeyslider.value > 70) {
                                    homecontroller.journeyprogressLine.value =
                                        100.0;
                                    homecontroller.showNextbtn.value = true;
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          SvgPicture.asset(
                            "assets/icons/fireicon.svg",
                            color: Colors.black,
                            // height: 20.sp,
                            // width: 20.sp,
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: homecontroller.showNextbtn.value,
                        replacement: SizedBox(height: 55.sp,width: double.infinity,),
                        child: RoundButton(
                          gradient: false,
                          margin: 0,
                          backgroundColor: Colors.white,
                          height: 55.sp,
                          borderRadius: 10.sp,
                          title: 'Next',
                          borderColor: Colors.transparent,
                          borderWidth: 1.sp,
                          iconColor: themecontroller.colorwhite,
                          textColor: Colors.black,
                          onTap: () async {},
                        ),
                      ),
                    ),
                    SizedBox(height: 50.sp,),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
