import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'small_loader.dart';
import 'package:bible_chat_app/constant/theme.dart';

class RoundButton extends StatefulWidget {
  const RoundButton({
    Key? key,
    required this.height,
    this.width,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.icon,
    this.sufixicon,
    required this.title,
    this.iconColor,
    required this.onTap,
    this.margin = 20,
    this.borderColor = Colors.white,
    this.loading = false,
    this.disabled = false,
    this.gradient = false,
    this.borderWidth,
    this.borderRadius,
    this.titleSize,
    this.gapBtWIconAndText,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.btn_gradient,
  }) : super(key: key);

  final double height;
  final double? width;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final IconData? sufixicon;
  final String title;
  final Color? iconColor;
  final Color? borderColor;
  final VoidCallback onTap;
  final double margin;
  final double? borderWidth;
  final double? titleSize;
  final double? borderRadius;
  final double? gapBtWIconAndText;
  final bool loading;
  final bool disabled;
  final bool gradient;
  final MainAxisAlignment mainAxisAlignment;
  final Gradient? btn_gradient;

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  bool pressed = false;
  late final ThemeHelper themeController;

  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeHelper>(); // Avoid putting inside build
  }

  void _setPressed(bool value) {
    if (widget.loading || widget.disabled) return;
    setState(() {
      pressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.disabled
        ? widget.backgroundColor.withOpacity(0.6)
        : widget.backgroundColor;

    return GestureDetector(
      onPanDown: (_) => _setPressed(true),
      onPanEnd: (_) => _setPressed(false),
      onPanCancel: () => _setPressed(false),
      onTap: widget.loading || widget.disabled ? null : widget.onTap,
      child: AnimatedOpacity(
        opacity: pressed ? 0.8 : 1,
        duration: const Duration(milliseconds: 250),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: widget.height,
          width: widget.width,
          margin: EdgeInsets.symmetric(horizontal: widget.margin),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: widget.gradient ? null : bgColor,
            gradient: widget.gradient
                ? widget.btn_gradient ?? themeController.btnGradient
                : null,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            border: Border.all(
              color: widget.borderColor ?? Colors.transparent,
              width: widget.borderWidth ?? 0.3,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withOpacity(0.1),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.icon != null && !widget.loading)
                Icon(widget.icon, color: widget.iconColor),
              if (widget.icon != null && !widget.loading)
                SizedBox(width: widget.gapBtWIconAndText ?? 10),
              if (!widget.loading)
                Expanded(
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.textColor,
                      fontSize: widget.titleSize ?? 18.sp,
                    ),
                  ),
                ),
              if (widget.loading)
                SmallLoader(
                  color:
                      widget.disabled ? const Color(0xFFf7746c) : Colors.white,
                  adaptive: true,
                ),
              // if (widget.sufixicon != null && !widget.loading)
              //   SizedBox(width: widget.gapBtWIconAndText ?? 10),
              if (widget.sufixicon != null && !widget.loading)
                Icon(
                  widget.sufixicon,
                  color: widget.iconColor,
                  size: 15.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
