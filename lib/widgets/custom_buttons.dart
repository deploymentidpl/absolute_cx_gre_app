import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../style/text_style.dart';
import '../style/theme_color.dart';

typedef OnTap = void Function();

class CustomButtons {
  static Widget roundIconButton(
      {Color bgColor = Colors.white,
      double radius = 10,
      double? height,
      double? width,
      String? image,
      Color? imgColor,
      bool boxShadow = false,
      BoxShadow? shadowDecoration,
      Color shadowColor = Colors.black26,
      OnTap? onTap,
      Border? border,
      double imgSize = 25}) {
    return InkWell(
        splashColor: ColorTheme.cTransparent,
        hoverColor: ColorTheme.cTransparent,
        focusColor: ColorTheme.cTransparent,
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              // color: Colors.transparent,
              border: border ?? Border.all(color: Colors.transparent, width: 0),
              boxShadow: boxShadow
                  ? [
                      shadowDecoration ??
                          BoxShadow(
                            offset: const Offset(
                              -2, // Move to right 10  horizontally
                              -5.0, // Move to bottom 10 Vertically
                            ),
                            color: Colors.white10.withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: 1,
                          )
                    ]
                  : []),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: image!.contains("svg")
                    ? SvgPicture.asset(
                        image,
                        colorFilter: ColorFilter.mode(
                            imgColor ?? ColorTheme.cWhite, BlendMode.srcIn),
                        height: imgSize,
                        width: imgSize,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        image,
                        color: imgColor,
                        height: imgSize,
                        width: imgSize,
                        fit: BoxFit.fill,
                      )),
          ),
        ));
  }

  static Widget borderWidgetButton(
      {Color bgColor = Colors.white,
      double radius = 10,
      double? height,
      double? width,
      Color? borderColor = Colors.black,
      double borderWidth = 1,
      bool boxShadow = false,
      Color shadowColor = Colors.black26,
      OnTap? onTap,
      EdgeInsets? padding,
      required Widget child}) {
    return InkWell(
        splashColor: ColorTheme.cTransparent,
        hoverColor: ColorTheme.cTransparent,
        focusColor: ColorTheme.cTransparent,
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: bgColor,
              border: Border.all(color: borderColor!, width: borderWidth),
              boxShadow: boxShadow
                  ? [
                      BoxShadow(
                        color: shadowColor,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      )
                    ]
                  : []),
          child: Center(child: child),
        ));
  }

  static Widget widgetButton(
      {Color bgColor = Colors.white,
      double radius = 10,
      double? height,
      double? width,
      bool boxShadow = false,
      Color shadowColor = Colors.black26,
      OnTap? onTap,
      EdgeInsets? padding,
      required Widget child}) {
    return InkWell(
        splashColor: ColorTheme.cTransparent,
        hoverColor: ColorTheme.cTransparent,
        focusColor: ColorTheme.cTransparent,
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: bgColor,
              boxShadow: boxShadow
                  ? [
                      BoxShadow(
                        color: shadowColor,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      )
                    ]
                  : []),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(0),
            child: Center(child: child),
          ),
        ));
  }

  static Widget appThemeButton(
      {required String text,
      OnTap? onTap,
      bool enable = true,
      double? width,
      Color? textColor,
      Color? bgColor,  double? height}) {
    return CustomButtons.widgetButton(
        width: width ?? (text.length * 12),
        height:height??50,
        bgColor: enable?bgColor ?? ColorTheme.cPurple:bgColor ?? ColorTheme.cButtonBg,
        radius: 0,
        onTap: enable?onTap:null,
        child: Text(text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontTheme.fontSemiBold,
                color: textColor ?? ColorTheme.cWhite)));
  }
}
