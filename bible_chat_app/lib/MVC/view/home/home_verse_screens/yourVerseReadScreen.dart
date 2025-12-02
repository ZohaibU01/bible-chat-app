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

class Yourversereadscreen extends StatelessWidget {
  Yourversereadscreen(
      {super.key,
      required this.heading,
      required this.mints,
      required this.icon,
      required this.verse,
      required this.background,
      required this.verse_ref,
        this.showProgress = true,
        this.title = "Your Journey",
      });

  final String heading;
  final String title;
  final String background;
  final String mints;
  final String icon;
  final String verse;
  final String verse_ref;
  final bool showProgress;

  @override
  final homecontroller = Get.put(Homecontroller());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(initState: (state) {
      homecontroller.journeyprogressLine.value = 100.0;
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
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SpringWidget(
                      onTap: () {
                        Get.back();
                        homecontroller.journeyprogressLine.value = 0.0;
                        homecontroller.journeyslider.value = 50.0;
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.sp),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1), // Black background with transparency
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.sp,
                ),
                if(showProgress)
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
                              text: "${heading}".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${mints}",
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
                        '${verse}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Container(
                        width: 50.sp,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text(
                        "${verse_ref}",
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15.sp),
                          decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: SvgPicture.asset(
                            "assets/icons/share.svg",
                            color: Colors.white,
                            height: 20.sp,
                            width: 20.sp,
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(15.sp),
                            decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Chat to learn more",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                SvgPicture.asset(
                                  "assets/icons/message.svg",
                                  color: Colors.white,
                                  height: 20.sp,
                                  width: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Container(
                            padding: EdgeInsets.all(15.sp),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 20.sp,
                            )),
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
