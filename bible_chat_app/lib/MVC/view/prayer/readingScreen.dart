import 'dart:convert';

import 'package:bible_chat_app/components/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/spring_widget.dart';
import '../../../constant/theme.dart';
import '../../controller/prayerController.dart';
import '../../controller/readingController.dart';

class ReadingDetailScreen extends StatefulWidget {
  const ReadingDetailScreen({
    super.key,
    required this.backgroundImageUrl,
    required this.prayerDetail,
  });

  final String backgroundImageUrl;
  final PrayerDetail prayerDetail;

  @override
  State<ReadingDetailScreen> createState() => _ReadingDetailScreenState();
}

class _ReadingDetailScreenState extends State<ReadingDetailScreen> {
  final ReadingController readingController = Get.put(ReadingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD59652), // Background color
      body: Stack(
        children: [
          /// Main content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
              children: [
                SizedBox(height: 50.sp),

                /// Top Row (Close and TT)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCircularIcon(Icons.arrow_back, () {
                      Get.back();
                    }),
                    _buildCircularIcon(Icons.share, () {
                      _showFontAdjuster(context, readingController);
                    },text: "tT"),
                  ],
                ),

                SizedBox(height: 30.sp),

                /// Icon
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: ImageWidget(
                    imageUrl: widget.backgroundImageUrl,
                    height: 70.sp,
                    width: 70.sp,
                  ),
                ),

                SizedBox(height: 12.sp),

                /// Date
                Text(
                  "Fri Apr 04:",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14.sp,
                  ),
                ),

                /// Title
                Text(
                  widget.prayerDetail.featuring,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 20.sp),

                /// Paragraph
                Obx(()=> Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 100.sp),
                    child: Text(
                      widget.prayerDetail.prayerText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: readingController.verseFontSize.value,
                        height: 1.6,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding:
        EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        margin:
        EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD93D), Color(0xFFFFA93C)],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0)
          ),
        ),
        child: SpringWidget(
          onTap: (){
            Get.back();
          },
          child: Row(
            children: [
              Container(
                height: 40.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                  image: DecorationImage(
                    image: NetworkImage(widget.backgroundImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.play_arrow, color: Colors.white),
                ),
              ),
              SizedBox(width: 10.sp),
              Text(
                widget.prayerDetail.featuring,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Reusable Circular Icon Button**
  Widget _buildCircularIcon(IconData icon, VoidCallback onTap,
      {String text = ""}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.sp, horizontal: 10.sp),
      child: SpringWidget(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(4.sp),
          decoration: BoxDecoration(
            color: Colors.black
                .withOpacity(0.4), // Black background with transparency
            shape: BoxShape.circle,
          ),
          child: text.isNotEmpty
              ? Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                )
              : Icon(
                  icon,
                  color: Colors.white,
                  size: 16.sp,
                ),
        ),
      ),
    );
  }

  void _showFontAdjuster(BuildContext context, ReadingController controller) {
    final ThemeHelper themeController = Get.find<ThemeHelper>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: themeController.bgcolor,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                    ()=> Text(
                  "Adjust the font size",
                  style: TextStyle(
                    fontSize: controller.verseFontSize.value,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              Obx(() => SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white24,
                  thumbColor: Colors.white,
                  overlayColor: Colors.white30,
                  trackHeight: 2.0,
                ),
                child: Slider(
                  value: controller.verseFontSize.value,
                  min: 12,
                  max: 24,
                  divisions: 6,
                  label: "${controller.verseFontSize.value.toInt()}",
                  onChanged: (value) {
                    controller.updateFontSize(value);
                  },
                ),
              )),
              SizedBox(height: 10.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("T", style: TextStyle(color: Colors.white, fontSize: 12)),
                  Text("T", style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
