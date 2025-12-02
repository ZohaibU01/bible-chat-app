import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/onboarding/AgeScreen.dart';
import 'package:bible_chat_app/components/round_button.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/components/stepProgressBar.dart';
import 'package:bible_chat_app/components/verse_widget.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/data/mockData.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Sliderscreen extends StatelessWidget {
  Sliderscreen({super.key});

  @override
  final onboardingcontroller = Get.put(Onboardingcontroller());
  List<Widget> sliderItems = [
    firstslide(),
    Secondslide(),
    thirdslide(),
  ];
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
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: Column(
                  children: [
                    Expanded(
                      child: 
                      // GestureDetector(
                        // onHorizontalDragEnd: (details) {
                        //   if (details.primaryVelocity! < 0) {
                        //     // Swipe Left - Increment index
                        //     if (onboardingcontroller.currentSliderindex.value <
                        //         sliderItems.length - 1) {
                        //       onboardingcontroller.currentSliderindex.value++;
                        //     }
                        //   } else if (details.primaryVelocity! > 0) {
                        //     // Swipe Right - Decrement index
                        //     if (onboardingcontroller.currentSliderindex.value >
                        //         0) {
                        //       onboardingcontroller.currentSliderindex.value--;
                        //     }
                        //   }
                        // },
                        // child: 
                        Obx(() => AnimatedSwitcher(
                              duration:
                                  Duration(seconds: 1), // Smooth fade effect
                              transitionBuilder: (widget, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: widget,
                                );
                              },
                              child: sliderItems[onboardingcontroller
                                  .currentSliderindex.value],
                            )),
                      // ),
                    ),

                    // Expanded(
                    //   child: PageView(
                    //     onPageChanged: (value) {
                    //       print(value);
                    //       onboardingcontroller.currentSliderindex.value = value;
                    //     },
                    //     children: [
                    //       firstslide(),
                    //       Secondslide(),
                    //       thirdslide(),
                    //     ],
                    //   ),
                    // ),
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
                          if (onboardingcontroller.currentSliderindex.value ==
                              sliderItems.length - 1) {
                            Navigation.getInstance.RightToLeft_PageNavigation(
                                context, Agescreen());
                          } else {
                            onboardingcontroller.currentSliderindex.value++;
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class firstslide extends StatelessWidget {
  firstslide({
    super.key,
  });
  final onboardingcontroller = Get.put(Onboardingcontroller());
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'slide',
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.sp,
            ),
            SvgPicture.asset(
              "assets/icons/heading1.svg",
              height: 80.sp,
              width: 80.sp,
            ),
            SizedBox(
              height: 30.sp,
            ),
            Container(
              width: 300.sp,
              height: 420.sp,
              decoration: BoxDecoration(
                  color: HexColor('#FFFFFF').withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.sp)),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      "Get personalized guidance to\n overcome life's challenges.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    verse_widget(
                      background: "tile1.png",
                      heading: "Your Verse",
                      icon: "book.svg",
                      isexpendable: false,
                      isArrowvisile: false,
                      children: [],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    verse_widget(
                      background: "tile2.png",
                      heading: "Personalized Devotional ",
                      icon: "pen.svg",
                      children: [],
                      isexpendable: false,
                      isArrowvisile: false,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    verse_widget(
                      background: "tile3.png",
                      heading: "Prayer Of The Day ",
                      icon: "hands.svg",
                      isexpendable: false,
                      isArrowvisile: false,
                      children: [],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    verse_widget(
                      background: "tile4.png",
                      heading: "Spiritual Journal ",
                      icon: "bird.svg",
                      color: Colors.black,
                      isexpendable: false,
                      isArrowvisile: false,
                      children: [],
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: MockData.OnboardingsliderindexList.map(
                          (e) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.sp, vertical: 20.sp),
                            child: Container(
                              height: 5.sp,
                              width: e ==
                                      onboardingcontroller
                                          .currentSliderindex.value
                                  ? 25.sp
                                  : 15.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: e ==
                                          onboardingcontroller
                                              .currentSliderindex.value
                                      ? Colors.amber
                                      : Colors.white.withOpacity(0.3)),
                            ),
                          ),
                        ).toList(),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Secondslide extends StatelessWidget {
  Secondslide({
    super.key,
  });
  final onboardingcontroller = Get.put(Onboardingcontroller());
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'slide',
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.sp,
            ),
            SvgPicture.asset(
              "assets/icons/heading2.svg",
              height: 80.sp,
              width: 80.sp,
            ),
            SizedBox(
              height: 30.sp,
            ),
            Container(
              width: 300.sp,
              height: 430.sp,
              decoration: BoxDecoration(
                  color: HexColor('#FFFFFF').withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.sp)),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      "Get personalized guidance to\n overcome life's challenges.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor('#000428').withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20.sp)),
                      child: Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: HexColor('#000428').withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.sp),
                                      bottomRight: Radius.circular(15.sp),
                                      topLeft: Radius.circular(15.sp))),
                              padding: EdgeInsets.all(20.sp),
                              child: Text(
                                'How can I overcome\ntemptation?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: HexColor('#000428').withOpacity(0.2),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.sp),
                                      bottomRight: Radius.circular(15.sp),
                                      topRight: Radius.circular(15.sp))),
                              padding: EdgeInsets.all(10.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '"Submit yourselves, then, to God. Resist the devil, and he will flee from you."',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: 5.sp,
                                  ),
                                  Text(
                                    'James 4:7',
                                    style: TextStyle(
                                        color: HexColor('#FFCA35'),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5.sp,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.sp),
                                            color: HexColor('#00A6FB')),
                                        child: Padding(
                                          padding: EdgeInsets.all(12.sp),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/like.svg",
                                                height: 12.sp,
                                                width: 12.sp,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 5.sp,
                                              ),
                                              SvgPicture.asset(
                                                "assets/icons/dislike.svg",
                                                height: 12.sp,
                                                width: 12.sp,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.sp),
                                            color: HexColor('#00A6FB')),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.sp),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/copy.svg",
                                                height: 10.sp,
                                                width: 10.sp,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 5.sp,
                                              ),
                                              Text(
                                                'Copy',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.sp),
                                            color: HexColor('#00A6FB')),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.sp),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/share2.svg",
                                                height: 10.sp,
                                                width: 10.sp,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 5.sp,
                                              ),
                                              Text(
                                                'Share',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: MockData.OnboardingsliderindexList.map(
                          (e) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.sp, vertical: 20.sp),
                            child: Container(
                              height: 5.sp,
                              width: e ==
                                      onboardingcontroller
                                          .currentSliderindex.value
                                  ? 25.sp
                                  : 15.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  color: e ==
                                          onboardingcontroller
                                              .currentSliderindex.value
                                      ? Colors.amber
                                      : Colors.white.withOpacity(0.3)),
                            ),
                          ),
                        ).toList(),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class thirdslide extends StatelessWidget {
  thirdslide({
    super.key,
  });
  final onboardingcontroller = Get.put(Onboardingcontroller());
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'slide',
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.sp,
            ),
            SvgPicture.asset(
              "assets/icons/heading3.svg",
              height: 80.sp,
              width: 80.sp,
            ),
            SizedBox(
              height: 30.sp,
            ),
            Container(
              width: 300.sp,
              height: 420.sp,
              decoration: BoxDecoration(
                  color: HexColor('#FFFFFF').withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.sp)),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      "Get personalized guidance to\n overcome life's challenges.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor('#0667A6'),
                          borderRadius: BorderRadius.circular(20.sp)),
                      child: Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/gradient.png",
                                    ),
                                  ),
                                  // color: HexColor('#000428').withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15.sp)),
                              padding: EdgeInsets.all(10.sp),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/pen.svg",
                                        height: 20.sp,
                                        width: 20.sp,
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Text(
                                        'Personalized Devotional ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '. 3 MIN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30.sp,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Personalized Devotional ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.sp,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.sp, vertical: 5.sp),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.sp),
                                          border: Border.all(
                                              color: Colors.white
                                                  .withValues(alpha: 0.5)),
                                        ),
                                        child: Text('Faith',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.sp, vertical: 5.sp),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.sp),
                                          border: Border.all(
                                              color: Colors.white
                                                  .withValues(alpha: 0.5)),
                                        ),
                                        child: Text('Grace',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                            )),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.sp,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp, vertical: 5.sp),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                        border: Border.all(
                                            color: Colors.white
                                                .withValues(alpha: 0.5)),
                                      ),
                                      child: Text('Salvation',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.sp,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: MockData.OnboardingsliderindexList.map(
                          (e) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.sp, vertical: 20.sp),
                            child: Container(
                              height: 5.sp,
                              width: e ==
                                      onboardingcontroller
                                          .currentSliderindex.value
                                  ? 25.sp
                                  : 15.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),
                                  color: e ==
                                          onboardingcontroller
                                              .currentSliderindex.value
                                      ? Colors.amber
                                      : Colors.white.withOpacity(0.3)),
                            ),
                          ),
                        ).toList(),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
