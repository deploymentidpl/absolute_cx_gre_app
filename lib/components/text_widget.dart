
import 'package:flutter/material.dart';

import '../style/text_style.dart';
class TextWidget extends StatelessWidget {
  final dynamic text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final Color? decorationColor;
  final double? height;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final double? letterSpacing;
  final String? fontFamily;

  const TextWidget({required this.text, this.decorationColor, this.textOverflow, this.color, this.fontSize, this.fontWeight, this.textAlign, this.textDecoration, this.height, this.maxLines, super.key, this.fontFamily, this.letterSpacing});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: textDecoration,
        height: height,
        fontFamily: fontFamily ?? FontTheme.themeFontFamily,
        decorationColor: decorationColor,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
