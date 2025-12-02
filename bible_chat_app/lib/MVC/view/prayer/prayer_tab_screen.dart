import 'package:bible_chat_app/MVC/view/home/chatScreen.dart';
import 'package:bible_chat_app/MVC/view/prayer/prayerDetailScreen.dart';
import 'package:bible_chat_app/components/image_widget.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/prayerController.dart';

class PrayerTabScreen extends StatefulWidget {
  const PrayerTabScreen({super.key});

  @override
  _PrayerTabScreenState createState() => _PrayerTabScreenState();
}

class _PrayerTabScreenState extends State<PrayerTabScreen> {

  final PrayerController controller = Get.put(PrayerController());

  final ThemeHelper themeHelper = Get.find<ThemeHelper>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themHelper) {
      return Obx(
              () =>
              AnnotatedRegion(
                value: themHelper.systemUiOverlayStyleForhome,
                child: Scaffold(
                  backgroundColor: themHelper.bgcolor,
                  body: SingleChildScrollView(
                    child: _buildPrayerTab(),
                  ),
                ),
              )
      );
    });
  }

  Widget _buildPrayerTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50.sp),
        _buildHeader(),
        SizedBox(height: 20.sp),
        // _buildTabs(),
        // SizedBox(height: 20.sp),
        _buildSearchBar(),
        SizedBox(height: 20.sp),
        // buildPinnedPrayerCard(
        //   imageUrl: "https://drive.google.com/uc?export=view&id=1RVXpLfg-EeoWvRbRVni-S3miq3lgGIPJ",
        //   title: "Lent Pray40: The Way",
        //   subtitle: "Join the Challenge",
        //   sessionCount: "47 sessions",
        // ),
        if (controller.pinnedPrayers.isNotEmpty)
          CarouselSlider.builder(
            itemCount: controller.pinnedPrayers.length,
            itemBuilder: (context, index, realIdx) {
              final pinned = controller.pinnedPrayers[index];
              return buildPinnedPrayerCard(
                prayer: pinned,
              );
            },
            options: CarouselOptions(
              height: 360.sp,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              autoPlay: false,
            ),
          ),
        ...controller.categories.map((cat) =>
            _buildCategoriesWithPrayerCards(cat.name, cat.id),).toList()
      ],
    ).paddingOnly(bottom: Get.width * 0.3);
  }

  Widget buildPinnedPrayerCard({
    required Prayer prayer,
  }) {
    return Container(
      // width: 180.sp,
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: SpringWidget(
        onTap: () {
          final content = prayer.details.map((d) =>
          {
            "title": d.featuring ?? "Prayer"
          }).toList();

          Get.to(() =>
              PrayerDetailScreen(
                title: prayer.title,
                image: prayer.coverImg,
                duration: prayer.details.length == 1 ? "${prayer.details.length} session" : "${prayer.details.length} sessions",
                hasMultiplePrayers: prayer.hasMultiplePrayer,
                content: content,
                prayer: prayer,
              ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.sp),
              child: ImageWidget(
                imageUrl: prayer.coverImg,
                height: 230.sp,
                width: double.infinity,
                boxfit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.sp),
            Text(
              prayer.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 4.sp),
            Text(
              prayer.description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 2.sp),
            Text(
              "${prayer.details.length} session",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return HeaderWidget(title: "Prayer",);
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 20.sp),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Text(
    //         "Plans",
    //         style: TextStyle(
    //           color: Colors.white,
    //           fontSize: 24.sp,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       SpringWidget(
    //           onTap: () {},
    //           child: Icon(
    //             Icons.person_outline_rounded,
    //             color: themeHelper.backgoundcolor,
    //           ))
    //     ],
    //   ),
    // );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Container(
        decoration: BoxDecoration(
          color: themeHelper.ContainerColor,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
        child: TextField(
          onChanged: controller.updateSearchQuery,
          style: TextStyle(color: Colors.white, fontSize: 17.sp),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 8.sp, bottom: 8.sp, top: 8.sp),
              child: SizedBox(
                width: 20.sp,
                height: 20.sp,
                child: SvgPicture.asset(
                  "assets/icons/search_icon.svg",
                  color: themeHelper.colorwhite.withOpacity(0.5),
                ),
              ),
            ),
            hintText: "Search prayers by title",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 17.sp),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }


  Widget _buildCategoriesWithPrayerCards(String title, int categoryId) {
    final prayers = controller.prayersByCategory[categoryId.toString()] ?? [];
    final filtered = controller.searchQuery.isEmpty
        ? prayers
        : prayers.where((prayer) =>
        prayer.title.toLowerCase().contains(controller.searchQuery.value)).toList();

    if (filtered.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20.sp),
        SizedBox(
          height: 120.sp,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20.sp),
            itemCount: prayers.length,
            separatorBuilder: (context, index) => SizedBox(width: 10.sp),
            itemBuilder: (context, index) {
              final prayer = filtered[index];
              return _buildDynamicPrayerCard(prayer);
            }
          ),
        ),
        SizedBox(height: 20.sp),
      ],
    );
  }

  Widget _buildDynamicPrayerCard(Prayer prayer) {
    return SpringWidget(
      onTap: () {
        final content = prayer.details.map((d) =>
        {
          "title": d.featuring ?? "Prayer"
        }).toList();

        Get.to(() =>
            PrayerDetailScreen(
              title: prayer.title,
              image: prayer.coverImg,
              duration: prayer.details.length == 1 ? "${prayer.details.length} session" : "${prayer.details.length} sessions",
              hasMultiplePrayers: prayer.hasMultiplePrayer,
              content: content,
              prayer: prayer,
            ));
      },
      child: Container(
        width: 150.sp,
        height: 120.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            ImageWidget(
              imageUrl: prayer.coverImg,
              width: double.infinity,
              height: double.infinity,
              boxfit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: 10.sp, vertical: 8.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.sp),
                    bottomRight: Radius.circular(12.sp),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
                child: Text(
                  prayer.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}


class StudyPlan {
  final String title;
  final double progress;
  final String image;

  StudyPlan({
    required this.title,
    required this.progress,
    required this.image,
  });

  factory StudyPlan.fromJson(Map<String, dynamic> json) {
    return StudyPlan(
      title: json["title"],
      progress: json["progress"],
      image: json["image"],
    );
  }
}

class StudyTopic {
  final String title;
  final String image;

  StudyTopic({
    required this.title,
    required this.image,
  });

  factory StudyTopic.fromJson(Map<String, dynamic> json) {
    return StudyTopic(
      title: json["title"],
      image: json["image"],
    );
  }
}


class ReadingPlan {
  final String title;
  final String duration;
  final String image;

  ReadingPlan({
    required this.title,
    required this.duration,
    required this.image,
  });

  factory ReadingPlan.fromJson(Map<String, dynamic> json) {
    return ReadingPlan(
      title: json["title"],
      duration: json["duration"],
      image: json["image"],
    );
  }
}



