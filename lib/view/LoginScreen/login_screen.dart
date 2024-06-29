import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/function.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:greapp/controller/LoginController/login_controller.dart';
import 'package:greapp/widgets/custom_text_field.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../components/absolute_logo.dart';
import '../../components/text_widget.dart';
import '../../config/utils/connectivity_service.dart';
import '../../config/utils/constant.dart';
import '../../routes/route_name.dart';
import '../../style/assets_string.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/CommonDesigns/common_designs.dart';
import '../../widgets/custom_buttons.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ConnectivityService>().initializeConnectivity();

    return Scaffold(
      body: Stack(
        children: [
          Obx(() => controller.videoPlayerController.value.value.isInitialized
              ? Transform.flip(
                  flipX: true,
                  child: SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        height: controller
                            .videoPlayerController.value.value.size.height,
                        width: controller
                            .videoPlayerController.value.value.size.width,
                        child: Obx(() => Chewie(
                              controller: controller.chewieController.value,
                            )),
                      ),
                    ),
                  ),
                )
              : const SizedBox()),

          /// bg image
          // Transform.flip(
          //   flipX: false,
          //   child: const SizedBox.expand(
          //     child: FittedBox(
          //       fit: BoxFit.cover,
          //       child:  Image(image: AssetImage(AssetsString.kLoginBg,),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox.expand(
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) {
                setAppType(sizingInformation);
                bool isMobile = sizingInformation.isMobile;

                return isWeb
                    ? Container(
                        color: ColorTheme.cBlack.withOpacity(0.3),
                        child: Align(
                          alignment: isMobile
                              ? Alignment.center
                              : Alignment(0.7, -0.4),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                                constraints: const BoxConstraints(
                                  // maxHeight: MediaQuery.of(context).size.height * 2,
                                  maxWidth: 300,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorTheme.cWhite.withOpacity(0.05),
                                  border: Border.all(
                                      width: 1,
                                      color:
                                          ColorTheme.cBlack.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SingleChildScrollView(
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: AbsoluteLogo(
                                              size: 46,
                                              showName: false,
                                              logo: LogoType.kWhite,
                                            ),
                                          ),
                                          SizedBox(
                                            height: isMobile ? 8 : 8,
                                          ),
                                          Text(
                                            'LOGIN INTO YOUR ACCOUNT',
                                            style: semiBoldTextStyle(
                                              size: isMobile ? 12 : 14,
                                              color: ColorTheme.cWhite,
                                              fontStyle: FontStyle.italic,
                                              height: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: isMobile ? 15 : 30,
                                          ),
                                          //controller.pageName.value == "login"
                                          //   ?
                                          Container(
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                color: ColorTheme.cWhite
                                                    .withOpacity(0.2),
                                                border: Border.all(
                                                    width: 1,
                                                    color: ColorTheme.cBlack
                                                        .withOpacity(0.2)),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        topRight:
                                                            Radius.circular(8)),
                                              ),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              top: 8),
                                                      child: TextWidget(
                                                        text: 'EID',
                                                        fontSize:
                                                            isMobile ? 12 : 14,
                                                        fontWeight: FontTheme
                                                            .fontSemiBold,
                                                        color: ColorTheme
                                                            .cAppLoginTheme,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0,
                                                              bottom: 10),
                                                      child: Pinput(
                                                        autofocus: true,
                                                        enabled: !controller
                                                            .isShowOtp.value,
                                                        focusNode: controller.empCodeFocusNode,
                                                        defaultPinTheme:
                                                            const PinTheme(
                                                          textStyle: TextStyle(
                                                            color: ColorTheme
                                                                .cWhite,
                                                            fontWeight:
                                                                FontTheme
                                                                    .fontBold,
                                                            fontSize: 18,
                                                          ),
                                                          width: 18,
                                                          height: 22,
                                                        ),
                                                        //focusNode: controller.pinPutFocus,
                                                        controller: controller
                                                            .txtEID.value,
                                                        closeKeyboardWhenCompleted:
                                                            false,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        onCompleted: (value) {
                                                          controller.empOtpFocusNode.requestFocus();
                                                          // if (!controller.isOtpSend.value) {
                                                          //   controller.sendOtp(value);
                                                          // } else {
                                                          //   controller.handleOtp(value);
                                                          // }
                                                        },
                                                        length: 6,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                  ])),
                                          const SizedBox(
                                            height: 0.5,
                                          ),
                                          Obx(() => Visibility(
                                              visible:
                                                  controller.isShowOtp.value,
                                              child: Container(
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                    color: ColorTheme.cWhite
                                                        .withOpacity(0.2),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: ColorTheme.cBlack
                                                            .withOpacity(0.2)),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8)),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0,
                                                                top: 8),
                                                        child: TextWidget(
                                                          text: 'OTP',
                                                          fontSize: isMobile
                                                              ? 12
                                                              : 14,
                                                          fontWeight: FontTheme
                                                              .fontSemiBold,
                                                          color: ColorTheme
                                                              .cAppLoginTheme,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 4.0,
                                                                bottom: 10),
                                                        child: Pinput(
                                                          autofocus: true,

                                                          focusNode: controller.empOtpFocusNode,
                                                          defaultPinTheme:
                                                              const PinTheme(
                                                            textStyle:
                                                                TextStyle(
                                                              color: ColorTheme
                                                                  .cWhite,
                                                              fontWeight:
                                                                  FontTheme
                                                                      .fontBold,
                                                              fontSize: 18,
                                                            ),
                                                            width: 18,
                                                            height: 22,
                                                          ),
                                                          //focusNode: controller.pinPutFocus,
                                                          controller: controller
                                                              .txtPass.value,
                                                          closeKeyboardWhenCompleted:
                                                              false,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          onCompleted: (value) {
                                                            // if (!controller.isOtpSend.value) {
                                                            //   controller.sendOtp(value);
                                                            // } else {
                                                            //   controller.handleOtp(value);
                                                            // }
                                                          },
                                                          onChanged: (value) {
                                                            if (value
                                                                    .trim()
                                                                    .length ==
                                                                6) {}
                                                          },
                                                          //validator: controller.validation(value),
                                                          length: 6,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                        ),
                                                      ),
                                                    ],
                                                  )))),

                                          SizedBox(
                                            height: isMobile ? 6 : 8,
                                          ),

                                          GestureDetector(
                                            onTap: () {
                                              if(controller.isShowOtp.value){

                                                PreferenceController
                                                    .setBool(
                                                    SharedPref
                                                        .isUserLocked,
                                                    false);

                                                Get.offAllNamed(
                                                    RouteNames
                                                        .kDashboard);
                                              }else{
                                                controller.isShowOtp.value = true;
                                              }
                                            },
                                            child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(13),
                                                decoration: BoxDecoration(
                                                  color: controller.txtEID.value
                                                              .length ==
                                                          6
                                                      ? ColorTheme
                                                          .cAppLoginTheme
                                                      : ColorTheme.cWhite
                                                          .withOpacity(0.2),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: controller
                                                                  .txtEID
                                                                  .value
                                                                  .length ==
                                                              6
                                                          ? ColorTheme
                                                              .cTransparent
                                                          : ColorTheme
                                                              .cAppLoginTheme
                                                              .withOpacity(
                                                                  0.4)),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Obx(()=>Text(
                                                  controller.isShowOtp.value ==
                                                      true
                                                      ? "Login"
                                                      : "Send OTP",
                                                  style: boldTextStyle(
                                                    size: isMobile ? 14 : 16,
                                                    color: controller.txtEID
                                                        .value.length ==
                                                        6
                                                        ? ColorTheme.cWhite
                                                        : ColorTheme
                                                        .cAppLoginTheme,
                                                    height: 1,
                                                  ),
                                                ))),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ).paddingAll(24),
                                )),
                          ),
                        ),
                      )
                    : Scaffold(
                        body: SingleChildScrollView(
                          child: Stack(
                            children: [
                              appBgWithBuilding(height: Get.height),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    color: ColorTheme.cBlack.withOpacity(0.7),
                                  )),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 100,
                                  child: SvgPicture.asset(
                                    AssetsString.aLogoWhite,
                                    width: Get.width / 2,
                                  )),
                              Positioned(
                                  top: 0,
                                  left: 10,
                                  right: 10,
                                  bottom: 0,
                                  child: Center(
                                    child: PreferenceController.getBool(
                                            SharedPref.isUserLocked)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                "UNLOCK",
                                                style: boldTextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    size: 16),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              customTextField(
                                                  labelText: "PIN",
                                                  controller:
                                                      controller.txtPIN.value,
                                                  onTapOutside: (p0) {},
                                                  onChange: (value) {
                                                    controller.txtPIN.refresh();
                                                  },
                                                  textFieldColor: ColorTheme
                                                      .cFontWhite
                                                      .withOpacity(0.2)),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Obx(() =>
                                                  CustomButtons.appThemeButton(
                                                      text: "Login",
                                                      width: Get.width,
                                                      onTap: () {
                                                        PreferenceController
                                                            .setBool(
                                                                SharedPref
                                                                    .isUserLocked,
                                                                false);

                                                        Get.offAllNamed(
                                                            RouteNames
                                                                .kDashboard);
                                                      },
                                                      enable: controller
                                                          .txtPIN
                                                          .value
                                                          .text
                                                          .isNotEmpty)),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                "WELCOME TO GRE",
                                                style: boldTextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    size: 16),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              customTextField(
                                                  labelText: "EID",
                                                  controller:
                                                      controller.txtEID.value,
                                                  onTapOutside: (p0) {},
                                                  onChange: (value) {
                                                    controller.txtEID.refresh();
                                                  },
                                                  textFieldColor: ColorTheme
                                                      .cFontWhite
                                                      .withOpacity(0.2)),
                                              customTextField(
                                                  labelText: "Password",
                                                  obscureText: true,
                                                  onTapOutside: (p0) {},
                                                  onChange: (value) {
                                                    controller.txtPass
                                                        .refresh();
                                                  },
                                                  controller:
                                                      controller.txtPass.value,
                                                  textFieldColor: ColorTheme
                                                      .cFontWhite
                                                      .withOpacity(0.2)),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Obx(() =>
                                                  CustomButtons.appThemeButton(
                                                      text: "Login",
                                                      width: Get.width,
                                                      onTap: () {
                                                        PreferenceController
                                                            .setBool(
                                                                SharedPref
                                                                    .isUserLogin,
                                                                true);
                                                        print(PreferenceController
                                                            .getBool(SharedPref
                                                                .isUserLogin));
                                                        Get.offAllNamed(
                                                            RouteNames
                                                                .kDashboard);
                                                      },
                                                      enable: controller
                                                              .txtEID
                                                              .value
                                                              .text
                                                              .isNotEmpty &&
                                                          controller
                                                              .txtPass
                                                              .value
                                                              .text
                                                              .isNotEmpty)),
                                            ],
                                          ),
                                  )),
                            ],
                          ),
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
