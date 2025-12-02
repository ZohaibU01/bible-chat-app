import 'package:bible_chat_app/MVC/view/home/home_verse_screens/yourVerseListenScreen.dart';
import 'package:bible_chat_app/MVC/view/prayer/audioPlayer.dart';
import 'package:bible_chat_app/components/image_widget.dart';
import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constant/navigation.dart';
import '../../controller/prayerController.dart';
import '../home/home_verse_screens/yourVerseReadScreen.dart';

class PrayerDetailScreen extends StatefulWidget {
  final String title;
  final String image;
  final String duration;
  final bool hasMultiplePrayers;
  final Prayer prayer;
  final List<Map<String, dynamic>> content; // Days or Weeks

  const PrayerDetailScreen({
    Key? key,
    required this.title,
    required this.image,
    required this.duration,
    required this.hasMultiplePrayers,
    required this.content,
    required this.prayer,
  }) : super(key: key);

  @override
  _PrayerDetailScreenState createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<PrayerDetailScreen>
    with SingleTickerProviderStateMixin {
  final ThemeHelper themeHelper = Get.find<ThemeHelper>();
  Map<int, bool> expandedSections = {}; // Tracks expanded states
  Map<int, bool> expandedDays = {}; // Tracks nested expanded states
  final PrayerController prayerController = Get.find<PrayerController>();

  @override
  Widget build(BuildContext context) {
    var textForStudy =
        "Begin your morning by offering God both the joys and the sorrows of the day ahead.";
    return AnnotatedRegion(
      value: themeHelper.systemUiOverlayStyleForhome,
      child: Scaffold(
        backgroundColor: themeHelper.bgcolor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildPlanInfo(),
              _buildStartButton(),
              if (!widget.hasMultiplePrayers) ...[
                _buildPrayIntentionButton(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Text(
                    textForStudy,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      
                      fontWeight: FontWeight.w400,
                      height: 1.71,
                    ),
                  ),
                ),
              ]
              else
                _buildContentList(),
            ],
          ),
        ),
        bottomNavigationBar: prayerController.lastPlayedStepUrl.isEmpty
            ? null
            : Obx(
                () {
              return Container(
                padding:
                EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                margin:
                EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
                decoration: BoxDecoration(
                  // color: themeHelper.colorPrimarywhite,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD93D), Color(0xFFFFA93C)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: SpringWidget(
                  onTap: () {
                    prayerController.selectPrayer(widget.prayer, widget.prayer.details[0]);
                    Get.to(AudioPlayerScreen());
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 40.sp,
                        width: 40.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.sp),
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: NetworkImage(
                                prayerController.lastPlayedStepUrl.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Icon(Icons.play_arrow, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10.sp),
                      Text(
                        "Confession Step",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            ),
      ),
    );
  }

  /// **Header with Image & Title**
  Widget _buildHeader() {
    var height = Get.height * 0.3;
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: ImageWidget(
              imageUrl: widget.image,
              height: height,
              width: double.infinity,
              boxfit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0.sp,
            left: 15.sp,
            child: _buildCircularIcon(
                Icons.arrow_back_ios_new_rounded, () => Get.back()),
          ),
          Positioned(
            top: 0.sp,
            right: 15.sp,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 45.sp, horizontal: 10.sp),
              child: SpringWidget(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(0.4), // Black background with transparency
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/share_icon.svg",
                    color: Colors.white,
                    height: 14.sp,
                    width: 14.sp,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20.sp,
            left: 20.sp,
            child: SizedBox(
              width: Get.width * 0.7,
              child: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Reusable Circular Icon Button**
  Widget _buildCircularIcon(IconData icon, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 45.sp, horizontal: 10.sp),
      child: SpringWidget(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(4.sp),
          decoration: BoxDecoration(
            color: Colors.black
                .withOpacity(0.4), // Black background with transparency
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16.sp,
          ),
        ),
      ),
    );
  }

  /// **Plan Info (Duration & Enrolled Count)**
  Widget _buildPlanInfo() {
    var textForStudy =
        "Experience a uniquely transformative 7-day Bible study that unveils the heart of Christlike communication, guiding you toward deeper connections and healthier relationships.  Through carefully chosen Scripture passages, you'll learn how to reflect Jesus in everyday interactions.  Each day weaves together rich theological insights, plus the wonders of neuroscience and psychology, to empower you to live abundantly in Him. As you journey with an open heart and rely on the Holy Spirit's gentle leading, you'll cultivate empathy, love, and understanding-both in your words and in the relationships God has placed in your life.";
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/playlist_icon.svg",
                  color: themeHelper.colorwhite.withValues(alpha: 0.5),
                  height: 12.sp),
              SizedBox(width: 5.sp),
              Text(
                "PrayLists",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                  
                  fontWeight: FontWeight.w500,
                ),
              ),
              // SizedBox(width: 15.sp),
              // SvgPicture.asset("assets/icons/enrollments.svg",
              //     color: themeHelper.colorwhite, height: 16.sp),
              // SizedBox(width: 5.sp),
              // const Text(
              //   "30,038 enrolled",
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 14,
              //     
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 14.sp,
          ),
          SizedBox(
            width: Get.width * 0.7,
            child: Text(
              "Confession Guide",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 14.sp,
          ),
          Text(
            widget.prayer.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              
              fontWeight: FontWeight.w400,
              height: 1.71,
            ),
          ),
        ],
      ),
    );
  }

  /// **Play Next Session Button**
  Widget _buildStartButton() {
    return SpringWidget(
      onTap: () {
        prayerController.selectPrayer(widget.prayer, widget.prayer.details[0]);
        Navigation.getInstance.bottomToTop_PageNavigation(
            context,
            AudioPlayerScreen());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 20.sp),
          decoration: BoxDecoration(
            color: themeHelper.colorPrimarywhite,
            // gradient: LinearGradient(
            //   begin: Alignment(0.00, 0.50),
            //   end: Alignment(1.00, 0.50),
            //   colors: [const Color(0xFFFFF020), const Color(0xFFFFEABE)],
            // ),
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/play_icon.svg",
                  color: Colors.black, height: 20.sp),
              SizedBox(width: 18.sp),
              Text(
                "Play Next Session",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  
                  fontWeight: FontWeight.w600,
                  height: 1.05,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Play Next Session Button**
  Widget _buildPrayIntentionButton() {
    return SpringWidget(
      onTap: () {
        // Navigation.getInstance
        //     .bottomToTop_PageNavigation(context, const SaveReminderScreen());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 20.sp),
          decoration: BoxDecoration(
            color: Color(0xFF1D1D1D),
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/prayer_tab_icon.svg",
                  color: Colors.white, height: 20.sp),
              SizedBox(width: 18.sp),
              Text(
                "Pray For An Intention",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  
                  fontWeight: FontWeight.w600,
                  height: 1.05,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Content List (Study: Days, Reading: Weeks with Days)**
  Widget _buildContentList() {
    return Column(
      children: widget.prayer.details.asMap().entries.map((entry) {
        int index = entry.key;
        PrayerDetail detail = entry.value;

        return _buildDayTile(index, detail);
      }).toList(),
    );
  }

  Widget _buildDayTile(int index, PrayerDetail detail) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 6.sp),
      child: Container(
        decoration: BoxDecoration(
          color: themeHelper.ContainerColor,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 12.sp),

            // Yellow Play Icon
            SpringWidget(
              onTap: () {
                prayerController.selectPrayer(widget.prayer, detail);
                Navigation.getInstance.bottomToTop_PageNavigation(
                  context,
                  AudioPlayerScreen(),
                );
              },
              child: SvgPicture.asset(
                "assets/icons/play_icon.svg",
                color: themeHelper.colorPrimarywhite,
                height: 20.sp,
              ),
            ),

            SizedBox(width: 22.sp),

            // Text Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.featuring,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  detail.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "12 min", // Optional: Replace with dynamic duration if available
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),

            Spacer(),

            Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 20.sp,
            )
          ],
        ),
      ),
    );
  }


  /// **Reading Plan: Week Tile with Nested Days**
  Widget _buildWeekTile(int index, String weekTitle, List<String> days) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              expandedSections[index] = !(expandedSections[index] ?? false);
            });
          },
          child:
          _buildExpandableTile(weekTitle, expandedSections[index] ?? false),
        ),
        if (expandedSections[index] ?? false)
          ...days.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  expandedDays[entry.key] = !(expandedDays[entry.key] ?? false);
                });
              },
              child: _buildSubExpandableTile(
                "DAY ${entry.key + 1}",
                expandedDays[entry.key] ?? false,
                // isNested: true,
              ),
            );
          }).toList(),
      ],
    );
  }

  /// **Reusable Expandable Tile**
  Widget _buildExpandableTile(String title, bool isExpanded,
      {bool isNested = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isNested ? 20.sp : 20.sp, vertical: 5.sp),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isExpanded && !isNested
              ? themeHelper.colorDarkSecondaryBlue
              : isNested
                  ? themeHelper.colorPrimaryDarkBlue
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 12.sp, vertical: isNested ? 12.sp : 20.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(title.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 2.sp),
                Container(
                  width: isNested ? 40.sp : 48.sp,
                  height: 2.sp,
                  color: Colors.yellow,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(6),
              ),
              child: AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **Nested Expandable Tile for Days inside Weeks**
  Widget _buildSubExpandableTile(String title, bool isExpanded) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5.sp),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: themeHelper.colorPrimaryDarkBlue,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 18.sp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.sp),
                        Container(
                          width: 40.sp,
                          height: 2.sp,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 26.sp,
                    ),
                    Text(
                      title.replaceAll("DAY", "Proverb"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizeTransition(
              sizeFactor: isExpanded
                  ? const AlwaysStoppedAnimation(1.0)
                  : const AlwaysStoppedAnimation(0.0),
              child: isExpanded
                  ? Padding(
                      padding: EdgeInsets.only(top: 18.sp, bottom: 10.sp),
                      child: SpringWidget(
                        onTap: () {
                          Navigation.getInstance.RightToLeft_PageNavigation(
                              context,
                              Yourversereadscreen(
                                title: title.replaceAll("DAY", "Proverb"),
                                background: "title1bg.png",
                                icon: "book.svg",
                                verse_ref: 'Isaiah 41:10',
                                heading: "Proverbs   18:21",
                                mints: "   •1 MIN",
                                verse:
                                    "Fear not, for I am with you; Be not dismayed, for I am your God. I will strengthen you, Yes, I will help you, I will uphold you with My righteous right hand.",
                                showProgress: false,
                              ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title.replaceAll("DAY", "Proverb"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 16.sp),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
