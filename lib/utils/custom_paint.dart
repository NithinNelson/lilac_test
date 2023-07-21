import 'package:flutter/material.dart';

class MenuIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(size.width * 0.0, size.height * 0.1), Offset(size.width * 1.0, size.height * 0.1), whitePaint);
    canvas.drawLine(Offset(size.width * 0.0, size.height * 0.5), Offset(size.width * 0.75, size.height * 0.5), whitePaint);
    canvas.drawLine(Offset(size.width * 0.0, size.height * 0.9), Offset(size.width * 1.0, size.height * 0.9), whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}