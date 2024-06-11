import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';
import 'package:greapp/view/SVForm/personal_details.dart';
import 'package:greapp/view/SVForm/professional_details.dart';
import 'package:greapp/view/SVForm/sv_token.dart';
import 'package:greapp/view/SVForm/verify_Mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/utils/constant.dart';
import '../../controller/SVFormController/sv_form_controller.dart';
import '../../model/common_model.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/custom_buttons.dart';

class SVForm extends StatefulWidget {
  const SVForm({super.key});

  @override
  State<SVForm> createState() => _SVFormState();
}

class _SVFormState extends State<SVForm> {
  SiteVisitFormController cntSVForm = Get.put(SiteVisitFormController());
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // appBar: kIsWeb ? AppBarView() : null,
        backgroundColor: ColorTheme.cThemeBg,
        body: ResponsiveBuilder(builder: (context, sizingInformation) {
          isMobile = sizingInformation.isMobile;
          screenWidth = sizingInformation.screenSize.width;
          screenHeight = sizingInformation.screenSize.height;
          textFieldWidth = screenWidth / 3.2;
          return isMobile
              ? mobileView()
              : Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [customTabMenu(), customTabs()],
            ),
          );
        }),
        bottomNavigationBar: isMobile ? bottomButton() : null,
      ),
    );
  }

  Widget bottomButton(){
    return Obx(() {
      return cntSVForm.tabIndex.value!= 0 && cntSVForm.tabIndex.value != 4 ?  nextButton() : cntSVForm.tabIndex.value == 4 ? addNewSVButton() : const SizedBox();
    });
  }

  Widget nextButton(){
    return CustomButtons.widgetButton(
        child: Text("Next", style: semiBoldTextStyle(color: ColorTheme.cWhite, size: 16),),
        radius: 0,
        height: stickyButtonHeight,
        bgColor: ColorTheme.cButtonBg,
        onTap: () {
          if(cntSVForm.tabIndex.value < 4) {
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
        }
    );
  }

  Widget addNewSVButton(){
    return CustomButtons.appThemeButton(
      text: "Add New SV Form",
      width: Get.width,
      onTap: () {

      },
    );
  }

  ///mobile view

  Widget mobileView() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Obx(
                () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kAppBarHeight,),
                Obx(()=>
                    SizedBox(
                      height: cntSVForm.token.isNotEmpty || cntSVForm.waitListNumber.isNotEmpty ? kAppBarHeight : 0,
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
                if (cntSVForm.tabIndex.value == 0) const VerifyMobile(),
                if (cntSVForm.tabIndex.value == 1)
                  PersonalDetails(
                    isPurchaseDetailsPage: false,
                  ),
                if (cntSVForm.tabIndex.value == 2) PersonalDetails(isPurchaseDetailsPage: true),
                if (cntSVForm.tabIndex.value == 3) ProfessionalDetails(),
                if (cntSVForm.tabIndex.value == 4) SVToken(),
              ],
            ),
          ),
        ),
        Positioned(top: 0, left: 0, right: 0, child: svFormAppBar())
      ],
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
        SizedBox(
          height: 20,
        ),
        Text(
          "Site Visit Form",
          style: TextStyle(
              fontSize: 24,
              color: ColorTheme.cFontWhite,
              fontWeight: FontTheme.fontSemiBold),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            width: screenWidth * 0.68,
            height: screenHeight - 340,
            //padding: EdgeInsets.all(20),
            color: ColorTheme.cThemeCard,
            child: SingleChildScrollView(
              child: Obx(
                    () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
            ))
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
        Obx(()=> cntSVForm.token.isNotEmpty || cntSVForm.waitListNumber.isNotEmpty?
        Container(
          height: kAppBarHeight,
          width: Get.width,
          color: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (cntSVForm.token.isNotEmpty)
                    CustomButtons.appThemeButton(
                        text: "Token: #${cntSVForm.token}"),
                  if (cntSVForm.token.isNotEmpty)
                    SizedBox(
                      width: 10,
                    ),
                  if (cntSVForm.waitListNumber.isNotEmpty)
                    CustomButtons.appThemeButton(
                        text: "Waitlist: #${cntSVForm.waitListNumber}"),
                ],
              ),
              Icon(
                Icons.refresh,
                color: Colors.white,
              )
            ],
          ),
        ) : const SizedBox(),
        ),
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
                      if (cntSVForm.tabIndex.value == 0) {
                        Get.back();
                      } else {
                        cntSVForm.tabIndex.value--;
                        cntSVForm.tabIndex.refresh();
                      }
                    },
                    child: SvgPicture.asset(
                      "assets/icons/arrow-left.svg",
                      height: 25,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Site Visit Form",
                  style: mediumTextStyle(size: 18, color: ColorTheme.cWhite),
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
