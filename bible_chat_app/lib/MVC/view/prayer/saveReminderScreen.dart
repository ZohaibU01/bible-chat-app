import 'package:bible_chat_app/components/spring_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constant/theme.dart';

class SaveReminderScreen extends StatefulWidget {
  const SaveReminderScreen({super.key});

  @override
  _SaveReminderScreenState createState() => _SaveReminderScreenState();
}

class _SaveReminderScreenState extends State<SaveReminderScreen> {
  TimeOfDay _selectedTime = TimeOfDay(hour: 10, minute: 0); // Default Time
  final ThemeHelper themeHelper = Get.find<ThemeHelper>();

  /// **Show Time Picker**
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.yellow,
              onSurface: Colors.white,
              surface: themeHelper.colorNavyBlue
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeHelper.bgcolor, // Dark Background
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// **Close Button**
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 28.sp,top: 40.sp),
              child: SpringWidget(
                onTap: (){
                  Get.back();
                  // Get.back();
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
            ),
          ),

          Spacer(),

          /// **GIF Bell Animation**
          Column(
            children: [
              Center(
                child: Image.asset(
                  "assets/images/bell.gif",
                  height: 140.sp,
                ),
              ),
              SizedBox(height: 20.sp),

              /// **Title**
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  "Godly & Effective Communication",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// **Subtitle**
              SizedBox(height: 10.sp),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.sp),
                child: Text(
                  "To Continue Growing in your faith, set a reminder for your Study Plan.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: themeHelper.colorwhite,
                    fontSize: 14.sp,
                  ),
                ),
              ),

              SizedBox(height: 30.sp),

              /// **Reminder Time Selection**
              Text(
                "We’ll remind you at...",
                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13.sp),
              ),

              SizedBox(height: 10.sp),

              /// **Time Picker Button**
              SpringWidget(
                onTap: () => _selectTime(context),
                child: Container(
                  width: 170.sp,
                  padding: EdgeInsets.symmetric(vertical: 12.sp,horizontal: 12.sp),
                  decoration: BoxDecoration(
                    color: themeHelper.colorNavyBlue,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${_selectedTime.format(context)}",
                        style: TextStyle(color: Colors.white, fontSize: 20.sp,fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 8.sp),
                      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 24.sp),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Spacer(),
          SizedBox(height: 20.sp,),
        ],
      ),
      bottomNavigationBar: SpringWidget(
        onTap: () {
          Get.back();
          Get.back();
        },
        child: Container(
          width: double.infinity,
          height: 46.sp,
          margin: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 20.sp),
          // padding: EdgeInsets.symmetric(vertical: 15.sp),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.yellow, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Center(
            child: Text(
              "Save Reminder",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
