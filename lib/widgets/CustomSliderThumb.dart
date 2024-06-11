
import 'package:flutter/material.dart';

import '../style/theme_color.dart';

typedef ValueChanged = Function(double value);

class CustomSliderThumb extends SliderComponentShape {
  int height;
  String label;
  CustomSliderThumb({required this.height,required this.label});
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(30);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {

    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width:  height* .6, height: height * .6),
      Radius.circular(height * .6),
    );

    final paint = Paint()
      ..color = sliderTheme.activeTrackColor! //Thumb Background Color
      ..style = PaintingStyle.fill;


    TextSpan span2 = TextSpan(
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: ColorTheme.cPurple,
            height: 1),
        text: '');

    TextPainter tp2 = TextPainter(
        text: span2,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp2.layout();
    TextSpan span3 = TextSpan(
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: ColorTheme.cPurple,
            height: 1),
        text: '');
    TextPainter tp3 = TextPainter(
        text: span3,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl);
    tp3.layout();
    TextSpan span = TextSpan(
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: ColorTheme.cWhite,
            height: 1),
        text: center.dx >= 30 && center.dx<=31 ? "<0.50 CR":label);


    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();

    Offset textCenter = Offset(center.dx-(height * .85), 0);
    Offset textCenter2 = const Offset(21, 0);

    // Offset textCenter =
    // Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);
    tp2.paint(canvas, textCenter2);

  }
  String getValue(double value) {
    return (0+(height-0)*value).round().toString();
  }
}
