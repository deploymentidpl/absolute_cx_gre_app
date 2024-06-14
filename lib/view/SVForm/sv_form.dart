import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';
import 'package:greapp/controller/WebTabBarController/web_tab_bar_controller.dart';
import 'package:greapp/view/SVForm/personal_details.dart';
import 'package:greapp/view/SVForm/professional_details.dart';
import 'package:greapp/view/SVForm/sv_token.dart';
import 'package:greapp/view/SVForm/verify_Mobile.dart';
import 'package:greapp/widgets/web_header.dart';
import 'package:greapp/widgets/web_tabbar.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/Helper/function.dart';
import '../../config/utils/constant.dart';
import '../../controller/SVFormController/sv_form_controller.dart';
import '../../model/common_model.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_tabbar.dart';
import '../../widgets/custom_buttons.dart';

class SVForm extends StatefulWidget {
  const SVForm({super.key});

  @override
  State<SVForm> createState() => _SVFormState();
}

class _SVFormState extends State<SVForm> {
  SiteVisitFormController cntSVForm = Get.find<SiteVisitFormController>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        cntSVForm.loadData();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cntSVForm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: kIsWeb ? AppBarView() : null,
      backgroundColor: ColorTheme.cThemeBg,
      body: ResponsiveBuilder(builder: (context, sizingInformation) {
        setAppType(sizingInformation);
        screenWidth = sizingInformation.screenSize.width;
        screenHeight = sizingInformation.screenSize.height;
        textFieldWidth = screenWidth / 3.2;
        return isWeb
            ?
             Column(
                children: [
                  const WebHeader(),
                  const WebTabBar(currentScreen: CurrentScreen.siteVisit),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTabMenu(),
                          Expanded(child: customTabs())
                        ],
                      ),
                    ),
                  ),
                ],
              ):mobileView();
      }),
      bottomNavigationBar: isMobile ? bottomButton() : null,
    );
  }

  Widget bottomButton() {
    return Obx(() {
      return cntSVForm.tabIndex.value != 0 && cntSVForm.tabIndex.value != 4
          ? nextButton()
          : cntSVForm.tabIndex.value == 4
              ? addNewSVButton()
              : const SizedBox();
    });
  }

  Widget nextButton() {
    return CustomButtons.widgetButton(
        child: Text(
          "Next",
          style: semiBoldTextStyle(color: ColorTheme.cWhite, size: 16),
        ),
        radius: 0,
        height: stickyButtonHeight,
        bgColor: ColorTheme.cButtonBg,
        onTap: () {
          if (cntSVForm.tabIndex.value < 4) {
            if (cntSVForm.tabIndex.value == 1 &&
                cntSVForm.personalDetailsFormKey.currentState!.validate()) {
              cntSVForm.tabIndex.value = 2;
            }
          }
          if (cntSVForm.tabIndex.value == 2 &&
              cntSVForm.purchaseDetailsFormKey.currentState!.validate()) {
            cntSVForm.tabIndex.value = 3;
          }
          if (cntSVForm.tabIndex.value == 3 &&
              cntSVForm.professionalDetailsFormKey.currentState!.validate()) {
            cntSVForm.tabIndex.value = 4;
          }
          cntSVForm.tabIndex.refresh();
        });
  }

  Widget addNewSVButton() {
    return CustomButtons.appThemeButton(
      text: "Add New SV Form",
      width: Get.width,
      onTap: () {},
    );
  }

  ///mobile view

  Widget mobileView() {
    return SafeArea(
      child: Column(
        children: [
          const AppHeader(),
          const AppTabBar(
            currentScreen: CurrentScreen.siteVisit,
          ),
          svFormAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: kAppBarHeight,),
                    Obx(
                      () => SizedBox(
                        height: cntSVForm.token.isNotEmpty ||
                                cntSVForm.waitListNumber.isNotEmpty
                            ? kAppBarHeight
                            : 0,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (cntSVForm.arrTabMenu.isNotEmpty)
                            Text(
                              cntSVForm.arrTabMenu[cntSVForm.tabIndex.value]
                                      .description ??
                                  "",
                              style: mediumTextStyle(
                                  size: 18, color: ColorTheme.cWhite),
                            ),
                          if (cntSVForm.tabIndex.value != 4)
                            Row(
                              children: [
                                Text(
                                  (cntSVForm.tabIndex.value + 1).toString(),
                                  style: boldTextStyle(
                                      size: 18, color: ColorTheme.cWhite),
                                ),
                                 Text(
                                      " / 4",
                                      style: boldTextStyle(
                                          size: 18, color: ColorTheme.cPurple),
                                    ),
                              ],
                            )
                        ],
                      ),
                    ),
                    if (cntSVForm.tabIndex.value == 1) const VerifyMobile(),
                    if (cntSVForm.tabIndex.value == 0)
                      PersonalDetails(
                        isPurchaseDetailsPage: false,
                      ),
                    if (cntSVForm.tabIndex.value == 2)
                      PersonalDetails(isPurchaseDetailsPage: true),
                    if (cntSVForm.tabIndex.value == 3) ProfessionalDetails(),
                    if (cntSVForm.tabIndex.value == 4) SVToken(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customTabMenu() {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cntSVForm.arrTabMenu.length,
              itemBuilder: (context, index) {
                CommonModel obj = cntSVForm.arrTabMenu[index];
                return Column(
                  children: [
                    clipperTab(
                        name: obj.description ?? "",
                        clipperPath: obj.code == "verify"
                            ? GetStartedClipperPath()
                            : PersonalDetailsClipperPath(),
                        index: index),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget customTabs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "Site Visit Form",
          style: TextStyle(
              fontSize: 24,
              color: ColorTheme.cFontWhite,
              fontWeight: FontTheme.fontSemiBold),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
              color: ColorTheme.cThemeCard,
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (cntSVForm.arrTabMenu.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            cntSVForm.arrTabMenu[cntSVForm.tabIndex.value]
                                    .description ??
                                "",
                            style: mediumTextStyle(
                                size: 18, color: ColorTheme.cWhite),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (cntSVForm.tabIndex.value == 0)
                              const VerifyMobile(),
                            if (cntSVForm.tabIndex.value == 1)
                              PersonalDetails(
                                isPurchaseDetailsPage: false,
                              ),
                            if (cntSVForm.tabIndex.value == 2)
                              cntSVForm.token.isNotEmpty
                                  ? SVToken()
                                  : ProfessionalDetails()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        )
      ],
    );
  }

  Widget clipperTab(
      {required String name,
      required CustomClipper<Path> clipperPath,
      required int index}) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          if (cntSVForm.token.isEmpty) {
            if (cntSVForm.otpVerified.isFalse) {
              return;
            } else if (index == 0 && cntSVForm.otpVerified.isTrue) {
              return;
            } else if (index == 2 && cntSVForm.scanId.isEmpty) {
              return;
            } else {
              cntSVForm.tabIndex.value = index;
            }
          }
        },
        child: ClipPath(
          clipper: clipperPath,
          child: Container(
            height: 47,
            width: 270,
            alignment: Alignment.center,
            color: cntSVForm.tabIndex.value >= index
                ? ColorTheme.cPurple
                : ColorTheme.cThemeCard,
            child: Text(
              name,
              style: semiBoldTextStyle(size: 18, color: ColorTheme.cWhite),
            ),
          ),
        ),
      ),
    );
  }

  Widget svFormAppBar() {
    return Column(
      children: [
        // Obx(()=> cntSVForm.token.isNotEmpty || cntSVForm.waitListNumber.isNotEmpty?
        // Container(
        //   height: kAppBarHeight,
        //   width: Get.width,
        //   color: Colors.black,
        //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Row(
        //         children: [
        //           if (cntSVForm.token.isNotEmpty)
        //             CustomButtons.appThemeButton(
        //                 text: "Token: #${cntSVForm.token}"),
        //           if (cntSVForm.token.isNotEmpty)
        //             const SizedBox(
        //               width: 10,
        //             ),
        //           if (cntSVForm.waitListNumber.isNotEmpty)
        //             CustomButtons.appThemeButton(
        //                 text: "Waitlist: #${cntSVForm.waitListNumber}"),
        //         ],
        //       ),
        //       Icon(
        //         Icons.refresh,
        //         color: Colors.white,
        //       )
        //     ],
        //   ),
        // ) : const SizedBox(),
        // ),
        Container(
            height: kAppBarHeight,
            width: Get.width,
            color: ColorTheme.cThemeCard,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // InkWell(
                //     onTap: () {
                //       if (cntSVForm.tabIndex.value == 0) {
                //         Get.back();
                //       } else {
                //         cntSVForm.tabIndex.value--;
                //         cntSVForm.tabIndex.refresh();
                //       }
                //     },
                //     child: SvgPicture.asset(
                //       AssetsString.aBackArrow,
                //       height: 25,
                //     )),
                // const SizedBox(
                //   width: 10,
                // ),
                Text(
                  "Site Visit Form",
                  style: mediumTextStyle(size: 18, color: ColorTheme.cOrange),
                ),
              ],
            )),
      ],
    );
  }
}

class GetStartedClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path()
      ..lineTo(size.width * 0.95, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width * 0.95, size.height)
      ..lineTo(0, size.height);

    return path1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class PersonalDetailsClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path1 = Path()
      ..lineTo(size.width * 0.95, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width * 0.95, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width - size.width * 0.95, size.height / 2);

    return path1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
