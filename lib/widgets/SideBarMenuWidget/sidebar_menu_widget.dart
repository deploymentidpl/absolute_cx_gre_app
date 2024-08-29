import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';
import 'package:greapp/style/assets_string.dart';

import '../../config/Helper/hex_to_color.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../custom_buttons.dart';

class SideBarMenuWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? bgColor;
  final String? titleText;
  final Widget? titleWidget;
  final Widget? sideBarWidget;
  final EdgeInsets? sideBarPadding;
  final bool? isScroll;
  final bool showBottomStickyButton;
final
void Function()?  onTapBottomButton;
final String? bottomButtonMainText;

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
    this.showBottomStickyButton = false,
    this.onTapBottomButton, this.bottomButtonMainText
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
                    left: 0,
                    right: 0,
                    bottom: 0,child:
                  showBottomStickyButton
                      ? Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: CustomButtons.borderWidgetButton(
                          onTap: onTapBottomButton,
                          child: Text(
                            bottomButtonMainText ?? "",
                            style:
                                mediumTextStyle(
                                    color: ColorTheme.cWhite, size: 22),
                          ),
                          radius: 0,
                          width: width ?? 450,
                          height:45.h,
                          bgColor:
                              HexColor("#00AB41"),
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                        ),
                      )
                      : const SizedBox.shrink(),),
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
