import 'dart:async';
import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/onboarding/analyzingGoal1_Screen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/reminderScreen.dart';
import 'package:bible_chat_app/components/BottomNav.dart';
import 'package:bible_chat_app/components/progressLineWidget.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/helper/data_storage.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Onetimeofferscreen extends StatelessWidget {
  Onetimeofferscreen({super.key});

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
                          Text(
                            'One Time Offer',
                            style: themecontroller.customTextStyle(
                                fontSize: 33.sp,
                                letterSpacingPercent: -3,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.sp, vertical: 10.sp),
                            child: Text(
                                'Even a small amount helps keep Genesis running to assist more believers in need!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 12.sp,
                                )),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 50.sp,
                              ),
                              Container(
                                height: 300.sp,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/gradient.png",
                                    ),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 70.sp,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Here’s a ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp),
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        Container(
                                          child: Text(
                                            '50% off',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.sp,
                                              vertical: 5.sp),
                                          decoration: BoxDecoration(
                                              color: themecontroller
                                                  .colorPrimarywhite,
                                              borderRadius:
                                                  BorderRadius.circular(20.sp)),
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        Text(
                                          ' Discount! 👏',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Container(
                                      child: Text(
                                        'Only \$2.50 / month!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.sp, vertical: 10.sp),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          // .withValues(alpha: 0.2),
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Text(
                                      'Lowest price ever',
                                      style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.7),
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 50.sp,
                            child: Padding(
                                padding: EdgeInsets.all(20.sp),
                                child: SvgPicture.asset(
                                  "assets/icons/handshake.svg",
                                  height: 40.sp,
                                  width: 40.sp,
                                )),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          RoundButton(
                            // gradient: true,
                            margin: 0,
                            backgroundColor: themecontroller.colorPrimarywhite,
                            height: 45.sp,
                            borderRadius: 10.sp,
                            title: 'Claim Your Offer Now!',
                            borderColor: Colors.transparent,
                            borderWidth: 1.sp,
                            iconColor: themecontroller.colorwhite,
                            textColor: Colors.black,
                            onTap: () async {
                              await DataStroge.getInstance.doneOnboarding();
                              Navigation.getInstance
                                  .pagePushAndReplaceNavigation(
                                      context, BottomNavBar());
                            },
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Text('No thanks',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w200)),
                          SizedBox(
                            height: 10.sp,
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

class planSelection extends StatelessWidget {
  const planSelection({
    super.key,
    required this.Price,
    required this.planName,
    required this.value,
    required this.onTap,
  });
  final String planName;
  final String Price;
  final bool value;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SpringWidget(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: value
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.sp),
              border: Border.all(width: 2.sp, color: Colors.white)),
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    planName,
                    style: TextStyle(color: Colors.white),
                  ),
                  Visibility(
                    visible: value,
                    replacement: Container(
                      width: 25.sp,
                      height: 25.sp,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2.sp, color: Colors.white)),
                    ),
                    child: CircleAvatar(
                      backgroundColor: HexColor('#FFCA35'),
                      radius: 12.sp,
                      child: Icon(
                        Icons.done,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.sp,
              ),
              Text(
                Price,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class planTile extends StatelessWidget {
  planTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.circleColor = Colors.white,
    required this.isglow,
  });

  final String title;
  final String subtitle;
  final String icon;
  final Color circleColor;
  final bool isglow;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isglow,
            child: AvatarGlow(
              startDelay: const Duration(seconds: 1),
              glowShape: BoxShape.circle,
              glowColor: circleColor,
              duration: const Duration(seconds: 3),
              curve: Curves.easeInOut,
              child: CircleAvatar(
                backgroundColor: circleColor,
                child: SvgPicture.asset(
                  "assets/icons/${icon}",
                  height: 12.sp,
                  width: 12.sp,
                  color: Colors.black,
                ),
              ),
            ),
            replacement: CircleAvatar(
              backgroundColor: circleColor,
              child: SvgPicture.asset(
                "assets/icons/${icon}",
                height: 12.sp,
                width: 12.sp,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 10.sp,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250.sp,
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                width: 270.sp,
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 12.sp, color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
