import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';
import 'package:greapp/view/SVForm/personal_details.dart';
import 'package:greapp/view/SVForm/professional_details.dart';
import 'package:greapp/view/SVForm/sv_token.dart';
import 'package:greapp/view/SVForm/verify_mobile.dart';
import 'package:greapp/widgets/web_header.dart';
import 'package:greapp/widgets/web_tabbar.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/Helper/function.dart';
import '../../config/utils/constant.dart';
import '../../controller/SVFormController/sv_form_controller.dart';
import '../../main.dart';
import '../../model/common_model.dart';
import '../../style/assets_string.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/custom_buttons.dart';

class SVForm extends StatefulWidget {
  const SVForm({super.key});

  @override
  State<SVForm> createState() => _SVFormState();
}

class _SVFormState extends State<SVForm> {
  SiteVisitFormController cntSVForm = Get.find<SiteVisitFormController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      cntSVForm.loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    cntSVForm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  ResponsiveBuilder(builder: (context, sizingInformation) {
        setAppType(sizingInformation);
        screenWidth = sizingInformation.screenSize.width;
        screenHeight = sizingInformation.screenSize.height;
        textFieldWidth = screenWidth / 3.2;
          return isWeb
            ? webDesign()
            : mobileDesign();
      })
      ;
  }


  Widget bottomButton() {
    return Obx(() {
      return cntSVForm.tabIndex.value != 0 && cntSVForm.tabIndex.value != 3
          ? nextButtonNew()
          : /*cntSVForm.tabIndex.value == 3
              ? addNewSVButton()
              :*/
          const SizedBox();
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
      // onTap: () {
      //   if (cntSVForm.tabIndex.value < 3) {
      //     if (cntSVForm.tabIndex.value == 1 &&
      //         cntSVForm.personalDetailsFormKey.currentState!.validate()) {
      //       cntSVForm.tabIndex.value = 1;
      //     }
      //   }
      //   // if (cntSVForm.tabIndex.value == 1 &&
      //   //     cntSVForm.purchaseDetailsFormKey.currentState!.validate()) {
      //   //   cntSVForm.tabIndex.value = 2;
      //   // }
      //   if (cntSVForm.tabIndex.value == 1 &&
      //       cntSVForm.personalDetailsFormKey.currentState!.validate()) {
      //     cntSVForm
      //         .addEditSvFormDetails(SVFormType.personalDetails)
      //         .then((value) {
      //       if (value) {
      //         cntSVForm.tabIndex.value = 2;
      //         cntSVForm.tabIndex.refresh();
      //       }
      //     });
      //   }
      //   if (cntSVForm.tabIndex.value == 2 &&
      //       cntSVForm.professionalDetailsFormKey.currentState!.validate()) {
      //     cntSVForm.tabIndex.value = 3;
      //   }
      //   cntSVForm.tabIndex.refresh();
      // }

      onTap: cntSVForm.commonNextTap,
    );
  }

  Widget nextButtonNew() {
    return GestureDetector(
      // onTap: () {
      //   print(cntSVForm.tabIndex.value);
      //   print("cntSVForm.tabIndex.value ");
      //   print(cntSVForm.tabIndex.value );
      //   if (cntSVForm.tabIndex.value < 3) {
      //     if (cntSVForm.tabIndex.value == 1 &&
      //         cntSVForm.personalDetailsFormKey.currentState!.validate()) {
      //       cntSVForm.tabIndex.value = 2;
      //       return;
      //     }
      //   }
      //   // print(cntSVForm.tabIndex.value == 1 &&
      //   //     cntSVForm.personalDetailsFormKey.currentState!.validate());
      //   // if (cntSVForm.tabIndex.value == 1 &&
      //   //     cntSVForm.personalDetailsFormKey.currentState!.validate()) {
      //   //   cntSVForm.tabIndex.value = 2;
      //   //   return;
      //   // }
      //   if (cntSVForm.tabIndex.value == 2 &&
      //       cntSVForm.professionalDetailsFormKey.currentState!.validate()) {
      //     cntSVForm.tabIndex.value = 3;
      //     return;
      //   }
      //   cntSVForm.tabIndex.refresh();
      // },

      onTap: cntSVForm.commonNextTap,
      // onTap: () {
      //   if (cntSVForm.tabIndex.value < 3) {
      //     if (cntSVForm.tabIndex.value == 1 &&
      //         cntSVForm.personalDetailsFormKey.currentState!.validate()) {
      //       cntSVForm.tabIndex.value = 1;
      //     }
      //   }
      //   // if (cntSVForm.tabIndex.value == 1 &&
      //   //     cntSVForm.purchaseDetailsFormKey.currentState!.validate()) {
      //   //   cntSVForm.tabIndex.value = 2;
      //   // }
      //   if (cntSVForm.tabIndex.value == 1 &&
      //       cntSVForm.personalDetailsFormKey.currentState!.validate()) {
      //     cntSVForm
      //         .addEditSvFormDetails(SVFormType.personalDetails)
      //         .then((value) {
      //       if (value) {
      //         cntSVForm.tabIndex.value = 2;
      //         cntSVForm.tabIndex.refresh();
      //       }
      //     });
      //   }
      //   if (cntSVForm.tabIndex.value == 2 &&
      //       cntSVForm.professionalDetailsFormKey.currentState!.validate()) {
      //     cntSVForm.tabIndex.value = 3;
      //   }
      //   cntSVForm.tabIndex.refresh();
      // },
      child: Container(
        height: stickyButtonHeight,
        color: ColorTheme.cAppTheme,
        child: Center(
          child: Text(
            "Next",
            style: semiBoldTextStyle(color: ColorTheme.cWhite, size: 16),
          ),
        ),
      ),
    );
  }

  ///mobile view

  Widget mobileDesign() {
    return Scaffold(  resizeToAvoidBottomInset: true,
      backgroundColor: ColorTheme.cThemeBg,
      body: SafeArea(
        child: Column(
          children: [
            svFormAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => cntSVForm.tabIndex.value>-1?Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                            if (cntSVForm.tabIndex.value == 3)
                              GestureDetector(
                                onTap: () {
                                  Get.delete<SiteVisitFormController>();
                                  Get.put(SiteVisitFormController());
                                  cntSVForm = Get.find<SiteVisitFormController>();

                                  cntSVForm.loadData();
                                  cntSVForm.tabIndex.value = 0;
                                  cntSVForm.tabIndex.refresh();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  color: ColorTheme.cAppTheme,
                                  child: Row(
                                    children: [
                                        Icon(
                                        Icons.add,
                                        color: ColorTheme.cWhite,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Add New SV",
                                        style: mediumTextStyle(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      if (cntSVForm.tabIndex.value == 0) const VerifyMobile(),
                      if (cntSVForm.tabIndex.value == 1)
                        PersonalDetails(
                          controllerc: cntSVForm,
                          isPurchaseDetailsPage: false,
                        ),
                      if (cntSVForm.tabIndex.value == 2) const ProfessionalDetails(),
                      if (cntSVForm.tabIndex.value == 3)
                        const SVToken(), /*
                      if (cntSVForm.tabIndex.value == 2)
                        PersonalDetails(
                            controller: cntSVForm, isPurchaseDetailsPage: true),
                      if (cntSVForm.tabIndex.value == 3) ProfessionalDetails(),
                      if (cntSVForm.tabIndex.value == 4) SVToken(),*/
                    ],
                  ):const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),bottomNavigationBar: isMobile ? bottomButton() : null,

    );
  }
  Widget webDesign() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorTheme.cThemeBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WebHeader(),
          WebTabBar(
            currentScreen: CurrentScreen.siteVisit,
            onNewSVTap: () {
              Get.delete<SiteVisitFormController>();
              Get.put(SiteVisitFormController());
              cntSVForm = Get.find<SiteVisitFormController>();
              cntSVForm.loadData();
              cntSVForm.tabIndex.value = 0;
              cntSVForm.tabIndex.refresh();
            },
          ),
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
      ),bottomNavigationBar: isMobile ? bottomButton() : null,

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
          child: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Obx(() => cntSVForm.tabIndex.value == 3 &&
                          cntSVForm.token.isNotEmpty
                      ? Image.asset(
                          AssetsString.aWaveLocation,
                          fit: BoxFit.fitWidth,
                        )
                      : const SizedBox())),
              Obx(() => Container(
                    color: (isWeb && cntSVForm.tabIndex.value == 3)
                        ? ColorTheme.cTransparent
                        : ColorTheme.cThemeCard,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                            (isWeb && cntSVForm.tabIndex.value == 3)
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.stretch,
                        children: [
                          if (cntSVForm.arrTabMenu.isNotEmpty &&
                              (isWeb ? cntSVForm.tabIndex.value != 3 : true))
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
                                    controllerc: cntSVForm,
                                    isPurchaseDetailsPage: false,
                                  ),
                                if (cntSVForm.tabIndex.value == 2)
                                  const ProfessionalDetails(),
                                if (cntSVForm.tabIndex.value == 3) const SVToken(),
                                // if (cntSVForm.tabIndex.value == 0)
                                //   const VerifyMobile(),
                                // if (cntSVForm.tabIndex.value == 1)
                                //   PersonalDetails(
                                //     controllerc: cntSVForm,
                                //     isPurchaseDetailsPage: false,
                                //   ),
                                // if (cntSVForm.tabIndex.value == 2)
                                //   cntSVForm.token.isNotEmpty
                                //       ? SVToken()
                                //       : ProfessionalDetails()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
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
            } else if (index == 1) {
              cntSVForm.tabIndex.value = index;
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
                ? ColorTheme.cAppTheme
                : ColorTheme.isDark?ColorTheme.cThemeCard:ColorTheme.cAppThemeShear,
            child: Text(
              name,
              style: semiBoldTextStyle(size: 18, color: cntSVForm.tabIndex.value >= index
                ? Colors.white
                : null
                   ),
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
                InkWell(
                    onTap: () {
                      if (cntSVForm.tabIndex.value == 0 ||
                          cntSVForm.tabIndex.value == 3) {
                        Get.back();

                        Get.delete<SiteVisitFormController>();
                        Get.put(SiteVisitFormController());
                      } else {
                        cntSVForm.tabIndex.value--;
                        cntSVForm.tabIndex.refresh();
                      }
                    },
                    child: SvgPicture.asset(
                      AssetsString.aBackArrow,
                      height: 25,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SV Form: ",
                      style: mediumTextStyle(
                        size: 18,
                      ),
                    ),
                    Text(
                      kSelectedProject.value.projectDescription,
                      style: mediumTextStyle(
                          size: 18, color: ColorTheme.cAppTheme),
                    ),
                  ],
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
