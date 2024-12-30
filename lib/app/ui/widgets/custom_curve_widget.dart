import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCurveWidget extends StatelessWidget {
  const CustomCurveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Get.size,
      painter: CurvePainter(),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Get.theme.primaryColor;
    paint.style = PaintingStyle.fill; // Change this to fill

    final path = Path();

    path.moveTo(size.width * 0.1, size.height * 0.25);
    path.quadraticBezierTo(
      size.width / 2,
      size.height / 2,
      size.width,
      size.height * 0.25,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.1, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
