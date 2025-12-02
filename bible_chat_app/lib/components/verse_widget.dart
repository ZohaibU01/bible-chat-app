import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class verse_widget extends StatelessWidget {
  const verse_widget({
    super.key,
    required this.heading,
    required this.icon,
    required this.background,
    this.color = Colors.white,
    this.isexpendable = true,
    required this.children,
    this.isArrowvisile = true,
  });
  final String heading;
  final Color? color;
  final String icon;
  final String background;
  final bool isexpendable;
  final bool isArrowvisile;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isexpendable,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/${background}",
            ),
          ),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Material(
          color: Colors.transparent, // Prevents unwanted background effects
          child: Theme(
            data: ThemeData().copyWith(
              dividerColor: Colors.transparent, // Removes white divider line
              splashColor: Colors.transparent, // Prevents ripple effect
              highlightColor:
                  Colors.transparent, // Avoids extra highlight effects
            ),
            child: ExpansionTile(
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              backgroundColor: Colors.transparent,
              collapsedBackgroundColor: Colors.transparent,
              enableFeedback: false,
              visualDensity: VisualDensity(vertical: 2),
              tilePadding: EdgeInsets.symmetric(horizontal: 10.sp),
              childrenPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                "assets/icons/${icon}",
                height: 20.sp,
                width: 20.sp,
              ),
              title: Text(
                heading,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold),
              ),
              children: children
            ),
          ),
        ),
      ),
      replacement: AnimatedContainer(
        duration: Duration(seconds: 1),
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/${background}",
              ),
            ),
            borderRadius: BorderRadius.circular(10.sp)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/${icon}",
                    height: 20.sp,
                    width: 20.sp,
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Text(
                    heading,
                    style: TextStyle(
                        color: color,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Visibility(
                visible: isArrowvisile,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
