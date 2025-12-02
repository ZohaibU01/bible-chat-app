import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/onboarding/OneTimeOfferScreen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/analyzingGoal1_Screen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/freetrialScreen.dart';
import 'package:bible_chat_app/MVC/view/onboarding/reminderScreen.dart';
import 'package:bible_chat_app/components/progressLineWidget.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Selectplanscreen extends StatelessWidget {
  Selectplanscreen({super.key});

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
                      "assets/images/bg3.png",
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 70.sp,
                          ),
                          Obx(
                            () => Visibility(
                              visible:
                                  onboardingcontroller.SelectedPlan.value == 0,
                              replacement: Text(
                                  'How your 7-day free trial works.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold)),
                              child: Text(
                                  'Unlock the Power to\nOvercome Sin With God’s\nGuidance.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Obx(
                            () => Visibility(
                              visible:
                                  onboardingcontroller.SelectedPlan.value == 0,
                              replacement: Expanded(
                                  child: Stack(
                                children: [
                                  Positioned(
                                    top: 15.sp,
                                    left: 15.sp,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200.sp,
                                          width: 5.sp,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                        ),
                                        LayoutBuilder(
                                            builder: (context, constraints) {
                                          return Container(
                                            height: 80.sp,
                                            width: 5.sp,
                                            decoration: BoxDecoration(
                                                color: themecontroller
                                                    .colorPrimaryyellow),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      planTile(
                                        isglow: false,
                                        circleColor:
                                            themecontroller.colorPrimaryyellow,
                                        icon: "check.svg",
                                        title: 'install Genesis',
                                        subtitle:
                                            'You successfully created your profile.',
                                      ),
                                      SizedBox(
                                        height: 5.sp,
                                      ),
                                      planTile(
                                        isglow: true,
                                        circleColor:
                                            themecontroller.colorPrimaryyellow,
                                        icon: "lock.svg",
                                        title: 'Today: Get Instant Access',
                                        subtitle:
                                            'Unlimited chats, Personalized plans, Guided prayers, and access to Audio books.',
                                      ),
                                      SizedBox(
                                        height: 5.sp,
                                      ),
                                      planTile(
                                        isglow: false,
                                        icon: "bell.svg",
                                        title: 'Day 5: Trial reminder',
                                        subtitle:
                                            'We’ll send you a reminder that your trial is ending soon.',
                                      ),
                                      SizedBox(
                                        height: 5.sp,
                                      ),
                                      planTile(
                                        isglow: false,
                                        icon: "star.svg",
                                        title: 'Day 7: Trial ends',
                                        subtitle:
                                            'Your subscription will start on (Date).',
                                      )
                                    ],
                                  ),
                                ],
                              )),
                              child: Expanded(
                                  child: Column(
                                children: [
                                  checkplanTile(
                                    title: 'Find answers from the Bible',
                                    subtitle:
                                        'Use unlimited chats with our Bible chat feature.',
                                    circleColor:
                                        themecontroller.colorPrimaryyellow,
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  checkplanTile(
                                    title: 'Achieve Freedom from sin',
                                    subtitle:
                                        'We give you every tool you need to defeat sin',
                                    circleColor:
                                        themecontroller.colorPrimaryyellow,
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  checkplanTile(
                                    title:
                                        'Deepen your understanding of Scripture',
                                    subtitle:
                                        'Explore our library of Bible study plans and Audio books',
                                    circleColor:
                                        themecontroller.colorPrimaryyellow,
                                  )
                                ],
                              )),
                            ),
                          ),
                          Container(
                            height: 50.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color:
                                    HexColor("#404040").withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(20.sp)),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "I want to try the app for free",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                ),
                                Obx(() => Switch(
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor:
                                          const Color.fromARGB(255, 68, 68, 68),
                                      activeTrackColor: HexColor('#FFF021'),
                                      activeColor:
                                          const Color.fromARGB(255, 68, 68, 68),
                                      value:
                                          onboardingcontroller.isfreeApp.value,
                                      onChanged: (value) {
                                        onboardingcontroller.isfreeApp.value =
                                            value;
                                      },
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Column(
                            children: [
                              Obx(
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    planSelection(
                                      showoffer: false,
                                      onTap: () {
                                        // onboardingcontroller
                                        //         .isCheckedplan1.value =
                                        //     !onboardingcontroller
                                        //         .isCheckedplan1.value;

                                        // onboardingcontroller
                                        //     .isCheckedplan2.value = false;

                                        onboardingcontroller
                                            .SelectedPlan.value = 0;
                                      },
                                      value: onboardingcontroller
                                              .SelectedPlan.value ==
                                          0,
                                      planName: 'Monthly',
                                      Price: '\$9.99/mo',
                                    ),
                                    SizedBox(
                                      width: 10.sp,
                                    ),
                                    planSelection(
                                      showoffer: true,
                                      onTap: () {
                                        // onboardingcontroller
                                        //         .isCheckedplan2.value =
                                        //     !onboardingcontroller
                                        //         .isCheckedplan2.value;
                                        // onboardingcontroller
                                        //     .isCheckedplan1.value = false;

                                        onboardingcontroller
                                            .SelectedPlan.value = 1;
                                      },
                                      value: onboardingcontroller
                                              .SelectedPlan.value ==
                                          1,
                                      planName: 'Yearly',
                                      Price: '\$4.17/mo',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
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
                                  Obx(
                                    () => Visibility(
                                      visible: onboardingcontroller
                                              .SelectedPlan.value ==
                                          1,
                                      replacement: Text(
                                        'Cancel Anytime',
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.white),
                                      ),
                                      child: Text(
                                        'No Payment Due Now - Cancel Anytime',
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Obx(
                                () => RoundButton(
                                  // gradient: true,
                                  margin: 0,
                                  backgroundColor:
                                      themecontroller.colorPrimarywhite,
                                  height: 45.sp,
                                  btn_gradient: themecontroller.yellowGradient,
                                  borderRadius: 10.sp,
                                  title:
                                      onboardingcontroller.SelectedPlan.value ==
                                              1
                                          ? 'Redeem 7-days for \$0.00'
                                          : 'Start my Journey',
                                  borderColor: Colors.transparent,
                                  borderWidth: 1.sp,
                                  iconColor: themecontroller.colorwhite,
                                  textColor: Colors.black.withOpacity(0.8),
                                  onTap: () async {
                                    Navigation.getInstance
                                        .RightToLeft_PageNavigation(
                                            context, Onetimeofferscreen());
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Text(
                                "Just \$9.99 per month",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.white.withValues(alpha: 0.6)),
                              )
                            ],
                          ),
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
    required this.showoffer,
  });
  final String planName;
  final String Price;
  final bool value;
  final bool showoffer;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SpringWidget(
        onTap: onTap,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.sp),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                    color: value
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.black.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.sp),
                    border: Border.all(width: 2.sp, color: Colors.white)),
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
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
                                border: Border.all(
                                    width: 2.sp, color: Colors.white)),
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
            Visibility(
              visible: showoffer,
              child: Positioned(
                  top: 0,
                  right: 20.sp,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
                    decoration: BoxDecoration(
                        color: HexColor("#EE251E"),
                        borderRadius: BorderRadius.circular(15.sp)),
                    child: Column(
                      children: [
                        Text(
                          "7-days free",
                          style: TextStyle(color: Colors.white, fontSize: 8.sp),
                        ),
                        Text(
                          "+ SAVE 58%",
                          style: TextStyle(color: Colors.white, fontSize: 8.sp),
                        )
                      ],
                    ),
                  )),
            ),
          ],
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
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class checkplanTile extends StatelessWidget {
  checkplanTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.circleColor = Colors.white,
  });

  final String title;
  final String subtitle;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12.sp,
            backgroundColor: circleColor,
            child: SvgPicture.asset(
              "assets/icons/check.svg",
              height: 10.sp,
              width: 10.sp,
              color: Colors.black,
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

    // ListTile(
    //   leading: SpringWidget(
    //     onTap: onTap,
    //     child: Container(
    //       height: 30.sp,
    //       width: 30.sp,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(8.sp),
    //           border: Border.all(color: themecontroller.colorPrimaryyellow, width: 3.sp)),
    //       child: Visibility(
    //         visible: value,
    //         child: Icon(
    //           Icons.done_rounded,
    //           color: themecontroller.colorPrimaryyellow,
    //           size: 20.sp,
    //         ),
    //       ),
    //     ),
    //   ),
    //   title: Text(
    //     title,
    //     style: TextStyle(
    //         fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white),
    //   ),
    //   subtitle: Text(
    //     subtitle,
    //     style: TextStyle(fontSize: 12.sp, color: Colors.white),
    //   ),
    // );
  }
}
