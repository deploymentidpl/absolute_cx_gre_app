import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';

import '../config/Helper/hex_to_color.dart';
import '../config/utils/constant.dart';
import '../style/text_style.dart';
import '../style/theme_color.dart';
import 'app_loader.dart';
import 'custom_buttons.dart';

double stickyButtonHeight = 45.w;

typedef OnTap = void Function();

BuildContext contextCommon = Get.context!;

commonDialog(
    {required Widget child,
    String? message,
    required String mainHeadingText,
    bool showBottomStickyButton = false,
    String? bottomButtonMainText,
    double? bottomButtonMainHeight,
    TextStyle? bottomButtonMainTextStyle,
    Color? bottomButtonBackgroundColor,
    Color? bottomButtonMainTextColor,
    OnTap? onTapBottomButton,
    Color? mainHeadingBackgroundColor,
    Widget? text,
    String? path,
    Widget? icon,
    bool enableDrag = true,
    bool isDismissible = true,
    bool isHideAutoDialog = false,
    bool isCloseMenuShow = true,
    onWillPop,
    double? maxHeight,
    Color? backgroundColor,
    Color? mainColor,
    int? hideDuration}) {
  appLoader(contextCommon);
  hideKeyboard().then((value) {
    Future.delayed(const Duration(milliseconds: 300), () {
      removeAppLoader(contextCommon);
      showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: maxHeight ?? Get.height * 0.934),
        // barrierColor: Colors.transparent,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: ColorTheme.cThemeBg,

        builder: (BuildContext context) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                      color: ColorTheme.cThemeBg,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Container(
                              clipBehavior: Clip.hardEdge,
                              margin: EdgeInsets.only(top: 0.w),
                              decoration: BoxDecoration(
                                color: mainColor ?? ColorTheme.cWhite,
                              ),
                              child: SingleChildScrollView(
                                child: child,
                              )),
                        ],
                      )),
                ),
                showBottomStickyButton
                    ? Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: CustomButtons.borderWidgetButton(
                            onTap: onTapBottomButton,
                            child: Text(
                              bottomButtonMainText ?? "",
                              style: bottomButtonMainTextStyle ??
                                  mediumTextStyle(
                                      color: Colors.white, size: 14),
                            ),
                            radius: 0,
                            width: Get.width,
                            height:
                                bottomButtonMainHeight ?? stickyButtonHeight,
                            bgColor: bottomButtonBackgroundColor ??
                                HexColor("#00AB41"),
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Positioned(
                  top: 0,
                  child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      color:
                          mainHeadingBackgroundColor ?? ColorTheme.cThemeCard,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                width: isTablet
                                    ? Get.width -
                                        100.w -
                                        (icon != null ? 80.w : 0)
                                    : Get.width -
                                        50.w -
                                        (icon != null ? 80.w : 0),
                                padding: EdgeInsets.only(left: 15.w),
                                child: Text(
                                  mainHeadingText,
                                  style: mediumTextStyle(
                                      color: ColorTheme.cWhite, size: 18),
                                )),
                            icon ?? const SizedBox(),
                            if (isCloseMenuShow)
                              IconButton(
                                padding: EdgeInsets.only(right: 15.w),
                                icon: Icon(
                                  Icons.close,
                                  size: 20.sp,
                                  color: ColorTheme.cWhite,
                                ),
                                tooltip: 'Menu Icon',
                                onPressed: () {
                                  Get.back();
                                },
                              )
                          ])),
                )
              ],
            ),
          );
        },
      );

      if (isHideAutoDialog) {
        Future.delayed(Duration(seconds: hideDuration ?? 3), () {
          Get.back();
        });
      }
    });
  });
}

Future<void> hideKeyboard() async {
  FocusManager.instance.primaryFocus?.unfocus();
}
