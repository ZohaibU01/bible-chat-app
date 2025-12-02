import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepProgressBar extends StatelessWidget {
  final int step;
  final int totalSteps; // Total steps for proper calculation
  final double maxWidth;
  
  const StepProgressBar({
    Key? key,
    required this.step,
    required this.totalSteps, // Total steps required for step-based increment
    this.maxWidth = 50.0, // Max width of the outer container
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the inner width dynamically based on steps
    double stepWidth = (maxWidth / totalSteps) * step;
    
    return Container(
      height: 2.sp,
      width: maxWidth.sp, // Outer container max width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        color: Colors.white.withOpacity(0.6),
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300), // Smooth animation
        height: 2.sp,
        width: stepWidth.clamp(0, maxWidth).sp, // Ensure it doesn’t exceed maxWidth
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: Colors.white,
        ),
      ),
    );
  }
}
