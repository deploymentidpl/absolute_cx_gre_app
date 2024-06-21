
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';

import '../config/Helper/hex_to_color.dart';
import '../config/utils/constant.dart';
import '../style/text_style.dart';
import '../style/theme_color.dart';
import 'app_loader.dart';
import 'custom_buttons.dart';
import 'custom_text_field.dart';

double STICKYBUTTONHEIGHT = 45.w;

typedef void OnTap();
BuildContext contextCommon = Get.context!;

commonDialog(
    {required Widget child,
    // BuildContext? context,
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

        // shape: RoundedRectangleBorder(
        //   borderRadius:
        //   BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        // ),

        builder: (BuildContext context) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(

                      // height: Get.height*0.98,
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
                                      color: ColorTheme.cWhite, size: 14),
                            ),
                            radius: 0,
                            width: Get.width,
                            height: bottomButtonMainHeight??stickyButtonHeight,
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
                      color:mainHeadingBackgroundColor?? ColorTheme.cThemeCard,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                width: isTablet? Get.width -
                      100.w -
                      (icon != null ? 80.w : 0) :Get.width -
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
                                  // _scaffoldKey.currentState.openDrawer();
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
          // print('close * * * ');
          Get.back();
        });
      }
    });
  });
}

Future<void> hideKeyboard() async {
  FocusManager.instance.primaryFocus?.unfocus();
}


ChartCommonDialog(
    {required Widget child,
      required String message,
      required String mainheadingtext,
      bool showbottomstickybutton = true,
      String? bottombuttonmaintext,
      TextStyle? bottombuttonmaintextstyle,
      Color? bottombuttonbackgroundcolor,
      Color? bottombuttonmaintextcolor,
      OnTap? onTapbottombutton,
      Widget? text,
      String? path,
      Widget? icon,
      bool enableDrag = true,
      bool isDismissible = true,
      bool isHideAutoDialog = false,
      bool isCloseMenuShow = false,
      onWillPop,
      double? maxHeight,
      Color? backgroundColor,
      Color? mainColor,
      ScrollController? scrollController,
      int? hideDuration}) {
  appLoader(contextCommon);
  hideKeyboard().then((value) {
    Future.delayed(const Duration(milliseconds: 300), () {
      removeAppLoader(contextCommon);
      showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: maxHeight ?? Get.height * 0.934),
        barrierColor: ColorTheme.cBlack.withOpacity(0.7),
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor:backgroundColor??ColorTheme.cTransparent,
        builder: (BuildContext context) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                      color: Colors.white,
                      child: ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Container(
                              clipBehavior: Clip.hardEdge,
                              margin: EdgeInsets.only(top: 0.w),
                              decoration: BoxDecoration(
                                color: mainColor ?? ColorTheme.cWhite
                              ),
                              child: SingleChildScrollView(
                                child: child,
                              )),
                        ],
                      )),
                ),
                showbottomstickybutton
                    ? Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: CustomButtons.widgetButton(
                      onTap: onTapbottombutton,
                      child: Text(
                        bottombuttonmaintext ?? "",
                        style: bottombuttonmaintextstyle ??
                            mediumTextStyle(
                                color: HexColor("#636E72"),
                                size: 14),
                      ),
                      radius: 0,
                      width: Get.width,
                      height: STICKYBUTTONHEIGHT,
                      bgColor: bottombuttonbackgroundcolor ??
                          HexColor("#00AB41"),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                    ),
                  ),
                )
                    : SizedBox(),
                Positioned(
                  top: 0,
                  child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      color: const Color(0xffF5F5FA),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                width: Get.width - 50.w,
                                padding: EdgeInsets.only(left: 15.w),
                                child: Text(
                                  mainheadingtext,
                                  style: semiBoldTextStyle(
                                      color: HexColor("#4A5356"),
                                      size: 18),
                                )),
                            IconButton(
                              padding: EdgeInsets.only(right: 15.w),
                              icon: Icon(
                                Icons.close,
                                size: 20.sp,
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
          // print('close * * * ');
          Get.back();
        });
      }
    });
  });
}

customSearchBottomSheet<T>({
  required List<T> dataList,
  required final String Function(T) suggestion,
  Future<List<T>> Function(String)? apiCallback,
  String? labelText,
  TextStyle? labelStyle,
  Widget? suggestionIcon,
  String? mainHeadingText,
  Color? mainColor,
}){

  RxList<T> searchList = RxList([]);
  TextEditingController textController = TextEditingController();
  return commonDialog(
    showBottomStickyButton : false,
    mainHeadingText: mainHeadingText??"",
    mainColor: mainColor??ColorTheme.cThemeBg,
    isDismissible: true,
    message: "",
    child: SizedBox(
      height: Get.height*0.60,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextField(
              labelText: labelText??"Search",
              hintText: labelText??"Search",
              labelStyle: labelStyle,
              controller: textController,
              onChange: (value) {
                  searchList.value = dataList.where((e) {
                    return suggestion(e).toLowerCase().contains(textController
                        .text.toLowerCase());
                  }).toList();
                  searchList.refresh();
              },
              suffixWidget: GestureDetector(
                onTap: () {
                  textController.clear();
                  searchList.clear();
                  searchList.refresh();
                },
                  child: const Icon(Icons.clear)),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: Get.height*0.45,
              child: Obx(()=>
              searchList.isEmpty && textController.text.isNotEmpty ? Container(alignment: AlignmentDirectional.topCenter,child: Text("No data Found", style: semiBoldTextStyle(),)) :
                  ListView.builder(
                    itemCount: searchList.isNotEmpty ? searchList.length: dataList.length,
                    itemBuilder: (context, i) {
                      T obj =  searchList.isNotEmpty ?searchList[i] : dataList[i];
                      return  GestureDetector(
                        onTap: ()  {
                          apiCallback;
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all( 10),
                              child: Row(
                                children: [
                                  suggestionIcon??const SizedBox(),
                                  if(suggestionIcon != null) SizedBox(width: 10,),
                                  Text(suggestion(obj), style: semiBoldTextStyle(),),
                                ],
                              ),
                            ),
                            if(i != dataList.length) Divider(color: ColorTheme.cLineColor,)
                          ],
                        ),
                      );
                    },
                  ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}


chooseNumberCommonDialog(
    {required Widget child,
      required String message,
      required String mainheadingtext,
      bool showbottomstickybutton = true,
      String? bottombuttonmaintext,
      TextStyle? bottombuttonmaintextstyle,
      Color? bottombuttonbackgroundcolor,
      Color? bottombuttonmaintextcolor,
      OnTap? onTapbottombutton,
      Widget? text,
      String? path,
      Widget? icon,
      bool enableDrag = true,
      bool isDismissible = true,
      bool isHideAutoDialog = false,
      bool isCloseMenuShow = false,
      onWillPop,
      double? maxHeight,
      Color? backgroundColor,
      Color? mainColor,
      ScrollController? scrollController,
      int? hideDuration}) {
  appLoader(contextCommon);
  hideKeyboard().then((value) {
    Future.delayed(const Duration(milliseconds: 300), () {
      removeAppLoader(contextCommon);
      showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: maxHeight ?? Get.height * 0.934),
        barrierColor: ColorTheme.cBlack.withOpacity(0.7),
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: ColorTheme.cTransparent,
        builder: (BuildContext context) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                      color: Colors.white,
                      child: ListView(
                        controller: scrollController,
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
                showbottomstickybutton
                    ? Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: CustomButtons.widgetButton(
                      onTap: onTapbottombutton,
                      child: Text(
                        bottombuttonmaintext ?? "",
                        style: bottombuttonmaintextstyle ??
                            mediumTextStyle(
                                color: HexColor("#636E72"),
                                size: 14),
                      ),
                      radius: 0,
                      width: Get.width,
                      height: STICKYBUTTONHEIGHT,
                      bgColor: bottombuttonbackgroundcolor ??
                          HexColor("#00AB41"),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                    ),
                  ),
                )
                    : SizedBox(),
                Positioned(
                  top: 0,
                  child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(vertical: 8.w),
                      color: const Color(0xffF5F5FA),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                width: Get.width - 50.w,
                                padding: EdgeInsets.only(left: 15.w),
                                child: Text(
                                  mainheadingtext,
                                  style: semiBoldTextStyle(
                                      color: HexColor("#4A5356"),
                                      size: 18),
                                )),
                            IconButton(
                              padding: EdgeInsets.only(right: 15.w),
                              icon: Icon(
                                Icons.close,
                                size: 20.sp,
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
          // print('close * * * ');
          Get.back();
        });
      }
    });
  });
}

