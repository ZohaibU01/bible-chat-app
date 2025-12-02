import 'dart:async';
import 'dart:math';

import 'package:bible_chat_app/MVC/controller/homeController.dart';
import 'package:bible_chat_app/MVC/controller/prayerController.dart';
import 'package:bible_chat_app/MVC/controller/onboardingController.dart';
import 'package:bible_chat_app/MVC/view/home/home_verse_screens/yourVerseListenScreen.dart';
import 'package:bible_chat_app/MVC/view/home/home_verse_screens/yourVerseReadScreen.dart';
import 'package:bible_chat_app/MVC/view/home/home_verse_screens/yourjourneyScreen.dart';
import 'package:bible_chat_app/MVC/view/home/profileScreen.dart';
import 'package:bible_chat_app/components/progressLineWidget.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/components/verse_widget.dart';
import 'package:bible_chat_app/constant/constants.dart';
import 'package:bible_chat_app/constant/navigation.dart';
import 'package:bible_chat_app/data/mockData.dart';
import 'package:bible_chat_app/helper/data_storage.dart';
import 'package:flutter/material.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../prayer/prayerDetailScreen.dart';
// import 'package:skeletonizer/skeletonizer.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  @override
  final homecontroller = Get.put(Homecontroller());
  final PrayerController controller = Get.put(PrayerController());

  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(initState: (state) {
      Timer(
        Duration(seconds: 1),
        () {
          homecontroller.progressLine.value = 100.0;
        },
      );
    }, builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleForhome,
        child: Scaffold(
          backgroundColor: themecontroller.bgcolor,
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Constants.screenPadding.sp),
            child: Column(
              children: [
                SizedBox(
                  height: 70.sp,
                ),
                headerwidget(),
                SizedBox(
                  height: 20.sp,
                ),
                WeekCalendar(
                  onDatChanged: (selectedDate) {
                    homecontroller.onPlanChanged(selectedDate);
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress today',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '100%',
                          style: TextStyle(
                              color: themecontroller.colorPrimaryyellow,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.sp),
                      child: Obx(() => progressLine(
                          height: 5,
                          percentage: homecontroller.progressLine.value)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Obx(() => homecontroller.isLoadingTodayPlan.value
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        height: 600,
                        child: Column(
                          children: [
                            homePageSlider(homecontroller: homecontroller),
                            SizedBox(height: 10),
                            SpringWidget(
                              onTap: () {
                                List<Map<String, dynamic>> readingPlanContent =
                                    [
                                  {
                                    "title": "Week 1",
                                    "days": [
                                      "Proverbs 1",
                                      "Proverbs 2",
                                      "Proverbs 3",
                                      "Proverbs 4",
                                      "Proverbs 5",
                                      "Proverbs 6",
                                      "Proverbs 7"
                                    ]
                                  },
                                  {
                                    "title": "Week 2",
                                    "days": [
                                      "Proverbs 8",
                                      "Proverbs 9",
                                      "Proverbs 10",
                                      "Proverbs 11",
                                      "Proverbs 12",
                                      "Proverbs 13",
                                      "Proverbs 14"
                                    ]
                                  },
                                  {
                                    "title": "Week 3",
                                    "days": [
                                      "Proverbs 15",
                                      "Proverbs 16",
                                      "Proverbs 17",
                                      "Proverbs 18",
                                      "Proverbs 19",
                                      "Proverbs 20",
                                      "Proverbs 21"
                                    ]
                                  },
                                  {
                                    "title": "Week 4",
                                    "days": [
                                      "Proverbs 22",
                                      "Proverbs 23",
                                      "Proverbs 24",
                                      "Proverbs 25",
                                      "Proverbs 26",
                                      "Proverbs 27",
                                      "Proverbs 28"
                                    ]
                                  }
                                ];

                                Navigation.getInstance
                                    .bottomToTop_PageNavigation(
                                  context,
                                  PrayerDetailScreen(
                                    title: homecontroller
                                        .selectedPlan.value!.prayer.title,
                                    image: homecontroller
                                        .selectedPlan.value!.prayer.coverImg,
                                    duration: "30 Days",
                                    hasMultiplePrayers: homecontroller.selectedPlan
                                            .value!.prayer.hasMultiplePrayer ==
                                        1,
                                    content: readingPlanContent,
                                    prayer: homecontroller
                                        .selectedPlan.value!.prayer,
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 180.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      homecontroller.selectedPlan.value?.prayer
                                              .coverImg ??
                                          "",
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.sp, vertical: 20.sp),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      homecontroller.selectedPlan.value?.prayer
                                              .title ??
                                          "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
              ],
            ),
          ),
        ),
      );
    });
  }
}

class homePageSlider extends StatelessWidget {
  const homePageSlider({
    super.key,
    required this.homecontroller,
  });

  final Homecontroller homecontroller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200.sp,
          child: PageView(
            onPageChanged: (value) {
              print(value);
              homecontroller.currentSliderindex.value = value;
            },
            children: [
              //--second slide
              homesliderItemWidget(
                  background: "tile4.png",
                  heading: "Spiritual Journal ",
                  icon: "bird.svg",
                  mainAlignment: MainAxisAlignment.spaceBetween,
                  children: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'How is your relationship\nwith God today?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigation.getInstance
                                    .RightToLeft_PageNavigation(
                                        context, myjourneyscreen());
                              },
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.all(12.sp),
                                  child: Icon(
                                    Icons.arrow_outward_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.sp)),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
              //--second slide
              homesliderItemWidget(
                background: "tile1.png",
                heading: "Your Verse",
                icon: "book.svg",
                color: Colors.white,
                mainAlignment: MainAxisAlignment.spaceBetween,
                children: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Text(
                          homecontroller.selectedPlan.value!.devotionals.first
                              .verseReference,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: Row(
                            children: MockData.verseList
                                .map((e) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.sp, vertical: 5.sp),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(20.sp),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.sp, vertical: 7.sp),
                                        child: Text(
                                          e['name'],
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Row(
                            children: [
                              Expanded(
                                child: SpringWidget(
                                  onTap: () {
                                    Navigation.getInstance
                                        .RightToLeft_PageNavigation(
                                            context,
                                            Yourverselistenscreen(
                                              background: "title1bg.png",
                                              icon: "book.svg",
                                              verse_ref: 'Isaiah 41:10',
                                              heading: "Your Verse",
                                              mints: "  1 MIN",
                                              verse:
                                                  "Fear not, for I am with you; Be not dismayed, for I am your God. I will strengthen you, Yes, I will help you, I will uphold you with My righteous right hand.",
                                            ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.white.withValues(alpha: 0.3),
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.sp, vertical: 10.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/headphone.svg",
                                          height: 15.sp,
                                          width: 15.sp,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        Text(
                                          "listen",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                child: SpringWidget(
                                  onTap: () {
                                    Navigation.getInstance
                                        .RightToLeft_PageNavigation(
                                            context,
                                            Yourversereadscreen(
                                              background: "title1bg.png",
                                              icon: "book.svg",
                                              verse_ref: 'Isaiah 41:10',
                                              heading: "Your Verse",
                                              mints: "  1 MIN",
                                              verse:
                                                  "Fear not, for I am with you; Be not dismayed, for I am your God. I will strengthen you, Yes, I will help you, I will uphold you with My righteous right hand.",
                                            ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.white.withValues(alpha: 0.3),
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.sp, vertical: 10.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/study.svg",
                                          height: 15.sp,
                                          width: 15.sp,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        Text(
                                          "Read",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              //--third slide
              homesliderItemWidget(
                background: "tile2.png",
                heading: "Tailored Devotional",
                icon: "pen.svg",
                color: Colors.white,
                children: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Text(
                          homecontroller.selectedPlan.value!.devotionals.last
                              .verseReference,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: Row(
                            children: MockData.TailoredList.map((e) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.sp, vertical: 5.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.1),
                                      border: Border.all(color: Colors.white),
                                      borderRadius:
                                          BorderRadius.circular(20.sp),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.sp, vertical: 7.sp),
                                    child: Text(
                                      e['name'],
                                      style: TextStyle(
                                          fontSize: 10.sp, color: Colors.white),
                                    ),
                                  ),
                                )).toList(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Row(
                            children: [
                              Expanded(
                                child: SpringWidget(
                                  onTap: () {
                                    Navigation.getInstance
                                        .RightToLeft_PageNavigation(
                                            context,
                                            Yourverselistenscreen(
                                              background: "title2bg.png",
                                              icon: "pen.svg",
                                              heading: "Tailored Devotional",
                                              mints: "  3 MIN",
                                              verse_ref: '',
                                              verse:
                                                  "In this verse, God provides a profound reassurance to His people. He reminds us not to fear, for He is with us. This simple yet powerful promise is a cornerstone of the Christian faith. It assures us of God's unwavering presence, no matter the challenges we face. Reflecting on this, it is essential to understand that fear is a natural human response. We often encounter situations ",
                                            ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.white.withValues(alpha: 0.3),
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.sp, vertical: 10.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/headphone.svg",
                                          height: 15.sp,
                                          width: 15.sp,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        Text(
                                          "listen",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                child: SpringWidget(
                                  onTap: () {
                                    Navigation.getInstance
                                        .RightToLeft_PageNavigation(
                                            context,
                                            Yourversereadscreen(
                                              background: "title2bg.png",
                                              icon: "pen.svg",
                                              heading: "Tailored Devotional",
                                              mints: "  3 MIN",
                                              verse_ref: '',
                                              verse:
                                                  "In this verse, God provides a profound reassurance to His people. He reminds us not to fear, for He is with us. This simple yet powerful promise is a cornerstone of the Christian faith. It assures us of God's unwavering presence, no matter the challenges we face. Reflecting on this, it is essential to understand that fear is a natural human response. We often encounter situations ",
                                            ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.white.withValues(alpha: 0.3),
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.sp, vertical: 10.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/study.svg",
                                          height: 15.sp,
                                          width: 15.sp,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5.sp,
                                        ),
                                        Text(
                                          "Read",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              //--fourth slide
              // homesliderItemWidget(
              //   background: "tile3.png",
              //   heading: "Today’s Prayer",
              //   icon: "hands.svg",
              //   color: Colors.white,
              //   children: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 10.sp),
              //           child: Text(
              //             'Prayer for Healing\nRelationships',
              //             style: TextStyle(
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 15.sp),
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.all(10.sp),
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: SpringWidget(
              //                 onTap: () {
              //                   Navigation.getInstance
              //                       .RightToLeft_PageNavigation(
              //                           context,
              //                           Yourverselistenscreen(
              //                             background: "title3bg.png",
              //                             icon: "hands.svg",
              //                             heading: "Today’s Prayer",
              //                             mints: "  3 MIN",
              //                             verse_ref: '',
              //                             verse:
              //                                 "Heavenly Father, I come before You with an open heart, seeking Your guidance and strength as I embark on this journey of faith and understanding. Help me to fully embrace Your love and wisdom, to see Your hand at work in every aspect of my life. May Your Word be a lamp unto my feet and a light unto my path, guiding me through each day with clarity and purpose.",
              //                           ));
              //                 },
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                       color: Colors.white.withValues(alpha: 0.2),
              //                       borderRadius: BorderRadius.circular(10.sp)),
              //                   padding: EdgeInsets.symmetric(
              //                       horizontal: 20.sp, vertical: 10.sp),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       SvgPicture.asset(
              //                         "assets/icons/headphone.svg",
              //                         height: 15.sp,
              //                         width: 15.sp,
              //                         color: Colors.white,
              //                       ),
              //                       SizedBox(
              //                         width: 5.sp,
              //                       ),
              //                       Text(
              //                         "listen",
              //                         style: TextStyle(
              //                             color: Colors.white, fontSize: 12.sp),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 10.sp,
              //             ),
              //             Expanded(
              //               child: SpringWidget(
              //                 onTap: () {
              //                   Navigation.getInstance
              //                       .RightToLeft_PageNavigation(
              //                           context,
              //                           Yourversereadscreen(
              //                             background: "title3bg.png",
              //                             icon: "hands.svg",
              //                             heading: "Today’s Prayer",
              //                             mints: "  3 MIN",
              //                             verse_ref: '',
              //                             verse:
              //                                 "Heavenly Father, I come before You with an open heart, seeking Your guidance and strength as I embark on this journey of faith and understanding. Help me to fully embrace Your love and wisdom, to see Your hand at work in every aspect of my life. May Your Word be a lamp unto my feet and a light unto my path, guiding me through each day with clarity and purpose.",
              //                           ));
              //                 },
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                       color: Colors.white.withValues(alpha: 0.2),
              //                       borderRadius: BorderRadius.circular(10.sp)),
              //                   padding: EdgeInsets.symmetric(
              //                       horizontal: 20.sp, vertical: 10.sp),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       SvgPicture.asset(
              //                         "assets/icons/study.svg",
              //                         height: 15.sp,
              //                         width: 15.sp,
              //                         color: Colors.white,
              //                       ),
              //                       SizedBox(
              //                         width: 5.sp,
              //                       ),
              //                       Text(
              //                         "Read",
              //                         style: TextStyle(
              //                             color: Colors.white, fontSize: 12.sp),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: MockData.homesliderindexList
                .map(
                  (e) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.sp, vertical: 10.sp),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      height: 5.sp,
                      width: e == homecontroller.currentSliderindex.value
                          ? 25.sp
                          : 10.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          color: e == homecontroller.currentSliderindex.value
                              ? Colors.amber
                              : Colors.white.withOpacity(0.3)),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class homesliderItemWidget extends StatelessWidget {
  homesliderItemWidget({
    super.key,
    required this.heading,
    this.color,
    required this.icon,
    required this.background,
    required this.children,
    this.mainAlignment,
    this.crossAlignment,
  });

  final String heading;
  final Color? color;
  final String icon;
  final String background;
  final Widget? children;
  final MainAxisAlignment? mainAlignment;
  final CrossAxisAlignment? crossAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/images/${background}",
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Column(
            mainAxisAlignment: mainAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment: crossAlignment ?? CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: SvgPicture.asset(
                  "assets/icons/${icon}",
                  color: color ?? Colors.black,
                  height: 20.sp,
                  width: 20.sp,
                ),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: heading,
                        style: TextStyle(
                            color: color ?? Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "  1 MIN",
                        style: TextStyle(
                            color: color ?? Colors.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                trailing: Text(
                  "Done".toUpperCase(),
                  style: TextStyle(
                      color: color ?? Colors.black,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: children ?? SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}

class headerwidget extends StatelessWidget {
  const headerwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () =>  Row(
            children: [
              SpringWidget(
                onTap: () {
                  Navigation.getInstance.RightToLeft_PageNavigation(context, Profilescreen());
                },
                child: CircleAvatar(
                    backgroundColor: HexColor('#FFF021').withValues(alpha: 0.3),
                    radius: 20.sp,
                    child: Text(
                      DataStroge.userName.value[0],
                      style: TextStyle(
                          color: HexColor('#FFF021'),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    )),
              ),
              SizedBox(
                width: 10.sp,
              ),
              Text(
                'Welcome,',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 90.sp,
                child: Text(
                  '${DataStroge.userName.value}!',
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.sp)),
          padding: EdgeInsets.all(5.sp),
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/calendar.svg",
                height: 15.sp,
                width: 15.sp,
                color: Colors.white,
              ),
              SizedBox(
                width: 10.sp,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20.sp)),
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/fire.svg",
                      height: 15.sp,
                      width: 15.sp,
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Text(
                      '1',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class WeekCalendar extends StatefulWidget {
  const WeekCalendar({super.key, required this.onDatChanged});

  final Function(String) onDatChanged;

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  late List<Map<String, dynamic>> days;
  late String selectedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedDate = DateFormat('yyyy-MM-dd').format(now);

    final int currentWeekday = now.weekday; // Monday = 1, Sunday = 7
    final startOfWeek = now.subtract(Duration(days: currentWeekday - 1));

    // Generate days with `isStreak`
    days = List.generate(7, (index) {
      final date = startOfWeek.add(Duration(days: index));
      final DateTime today = DateTime.now();
      return {
        "day": DateFormat.E().format(date)[0],
        "date": DateFormat.d().format(date),
        "fullDate": DateFormat('yyyy-MM-dd').format(date),
        "isStreak": (date.isAfter(DateTime(today.year, today.month, today.day)))
            ? false
            : Random().nextBool(), // Replace with actual logic
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: days.map((day) => _buildDayItem(day)).toList(),
    );
  }

  Widget _buildDayItem(Map<String, dynamic> day) {
    bool isSelected = day["fullDate"] == selectedDate;
    bool isStreak = day["isStreak"] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          final DateTime selected = DateTime.parse(day["fullDate"]);
          final DateTime today = DateTime.now();

          if (!selected.isAfter(DateTime(today.year, today.month, today.day))) {
            setState(() {
              selectedDate = day["fullDate"];
            });
            widget.onDatChanged(selectedDate);
          }
        },
        child: Column(
          children: [
            Text(
              day["day"],
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/circledate.svg",
                  height: 30.sp,
                  width: 30.sp,
                  color: isSelected
                      ? Colors.yellow
                      : Colors.white.withOpacity(0.4),
                ),
                isStreak
                    ? SvgPicture.asset(
                        "assets/icons/fire.svg",
                        height: 10.sp,
                        width: 10.sp,
                      )
                    : Text(
                        day["date"],
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
