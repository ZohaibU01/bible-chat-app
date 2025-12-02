
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const GradientSlider(
      {super.key, required this.value, required this.onChanged});

  @override
  State<GradientSlider> createState() => _GradientSliderState();
}

class _GradientSliderState extends State<GradientSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 8.0.sp, // ✅ Increased thickness of slider track
        trackShape: GradientTrackShape(),
        thumbShape: GradientThumbShape(),
        overlayShape: RoundSliderOverlayShape(
            overlayRadius: 28.0), // Enlarged overlay effect
      ),
      child: Slider(
        value: widget.value,
        min: 0,
        max: 100,
        onChanged: widget.onChanged,
      ),
    );
  }
}

/// 🌈 Custom Gradient Track (Thicker Progress Bar)
class GradientTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    double additionalActiveTrackHeight = 0,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    required RenderBox parentBox,
    Offset? secondaryOffset,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required Offset thumbCenter,
  }) {
    final double trackHeight = 8.0.sp; // ✅ Custom thickness

    final Rect trackRect = Rect.fromLTRB(
      offset.dx,
      offset.dy + (parentBox.size.height - trackHeight) / 2, // Centered track
      offset.dx + parentBox.size.width,
      offset.dy + (parentBox.size.height + trackHeight) / 2,
    );

    final Paint fillPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xfffff021), Color(0xffffaa00)],
        stops: [0, 1],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTRB(
          trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom))
      ..style = PaintingStyle.fill;

    final Paint unfilledPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw the filled (gradient) part
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
            trackRect.left, trackRect.top, thumbCenter.dx, trackRect.bottom),
        Radius.circular(trackHeight / 2),
      ),
      fillPaint,
    );

    // Draw the unfilled (white) part
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
            thumbCenter.dx, trackRect.top, trackRect.right, trackRect.bottom),
        Radius.circular(trackHeight / 2),
      ),
      unfilledPaint,
    );
  }
}

/// 🔥 Custom Gradient Thumb with Thick White Border
class GradientThumbShape extends RoundSliderThumbShape {
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required Size sizeWithOverflow,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double textScaleFactor,
    required double value,
  }) {
    final double thumbRadius = 10.0; // ✅ Increased thumb size
    final double borderWidth = 6.0; // ✅ Thick white border

    // Draw the white border
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    context.canvas.drawCircle(center, thumbRadius + borderWidth, borderPaint);

    // Draw the gradient inside the border
    final Paint gradientPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xfffff021), Color(0xffffaa00)],
        stops: [0, 1],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromCircle(center: center, radius: thumbRadius))
      ..style = PaintingStyle.fill;

    context.canvas.drawCircle(center, thumbRadius, gradientPaint);
  }
}
