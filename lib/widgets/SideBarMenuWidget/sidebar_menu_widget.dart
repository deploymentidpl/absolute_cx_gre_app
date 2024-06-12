import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/style/assets_string.dart';

import '../../style/text_style.dart';
import '../../style/theme_color.dart';

class SideBarMenuWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? bgColor;
  final String? titleText;
  final Widget? titleWidget;
  final Widget? sideBarWidget;
  final EdgeInsets? sideBarPadding;
  final bool? isScroll;

  const SideBarMenuWidget({
    super.key,
    this.width,
    this.bgColor,
    this.titleText,
    this.titleWidget,
    this.sideBarWidget,
    this.height,
    this.sideBarPadding,
    this.isScroll,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.0,
          sigmaY: 4.0,
        ),
        child: Dialog(
            backgroundColor: bgColor ?? ColorTheme.cBgBlack,
            alignment: Alignment.centerRight,
            insetAnimationCurve: Easing.standardDecelerate,
            clipBehavior: Clip.none,
            insetPadding: const EdgeInsets.all(0),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(

              color: bgColor ?? ColorTheme.cBgBlack,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedContainer(
                    width: width ?? 450,
                    height: height ?? Get.height,
                    duration: const Duration(milliseconds: 150),
                    child: SingleChildScrollView(
                      physics: isScroll == true
                          ? const AlwaysScrollableScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: sideBarPadding ??
                            const EdgeInsets.only(
                                left: 24, right: 24, top: 24, bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                titleText != null && titleText != ""
                                    ? Text(
                                        titleText ?? "",
                                        style: semiBoldTextStyle(
                                            size: 18,
                                            color: ColorTheme.cFontWhite),
                                      )
                                    : const SizedBox.shrink(),
                                if (titleWidget != null)
                                  titleWidget ?? const SizedBox.shrink()
                              ],
                            ),
                            titleText != null && titleText != "" ||
                                    titleWidget != null
                                ? const SizedBox(height: 24)
                                : const SizedBox.shrink(),
                            sideBarWidget ?? const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: -80,
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: ColorTheme.cAppTheme,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(AssetsString.aClose,
                                height: 24, width: 24)),
                      ))
                ],
              ),
            )));
  }
}
