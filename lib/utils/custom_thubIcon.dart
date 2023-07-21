import 'package:flutter/material.dart';

class CustomThumbShape extends SliderComponentShape {
  final double thumbRadius;

  CustomThumbShape({
    required this.thumbRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool? isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        double? textScaleFactor,
        Size? sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;
    final paint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;
    final innerPaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, paint);

    final innerRadius = thumbRadius * 0.4;

    canvas.drawCircle(center, innerRadius, innerPaint);
  }
}
