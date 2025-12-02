import 'package:bible_chat_app/constant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hexcolor/hexcolor.dart';

class progressLine extends StatelessWidget {
  const progressLine({
    super.key,
    required this.percentage,
    this.height = 3,
    this.backContainerColor,
    this.frontContainerColor,
  });

  final double percentage;
  final int height;
  final Color? backContainerColor;
  final Color? frontContainerColor;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return Stack(
        children: [
          Container(
            height: height.sp,
            decoration: BoxDecoration(
              color: backContainerColor ??
                  HexColor('#FFCA35').withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedContainer(
                duration: Duration(seconds: 1),
                height: height.sp,
                width: constraints.maxWidth * (percentage / 100),
                decoration: BoxDecoration(
                  color: frontContainerColor??Colors.white,
                  gradient: frontContainerColor == null
                      ? themecontroller.yellowGradient
                      : null,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
