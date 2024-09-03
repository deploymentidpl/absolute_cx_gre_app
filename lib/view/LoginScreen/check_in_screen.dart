import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/function.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../components/absolute_logo.dart';
import '../../components/text_widget.dart';
import '../../config/utils/connectivity_service.dart';
import '../../config/utils/constant.dart';
import '../../controller/LoginController/check_in_controller.dart';
import '../../routes/route_name.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/app_loader.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  CheckInController controller = Get.find<CheckInController>();

  @override
  void initState() {
    controller.isDark = PreferenceController.getBool(SharedPref.isDark);
    ColorTheme.changeAppTheme(isDark: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<ConnectivityService>().initializeConnectivity();

    return Scaffold(
      body: Stack(
        children: [
          Obx(() => controller.videoPlayerController.value.value.isInitialized
              ? _customPlayer()
              : const SizedBox()),
          SizedBox.expand(
            child: ResponsiveBuilder(
              builder: (context, sizingInformation) {
                setAppType(sizingInformation);
                return _getLoginForm();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _customPlayer() {
    return Transform.flip(
      flipX: true,
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            height: controller.videoPlayerController.value.value.size.height,
            width: controller.videoPlayerController.value.value.size.width,
            child: Obx(() => Chewie(
                  controller: controller.chewieController.value,
                )),
          ),
        ),
      ),
    );
  }

  Widget _getLoginForm() {
    return Container(
      color: ColorTheme.cBlack.withOpacity(0.3),
      child: Align(
        alignment: isMobile ? Alignment.center : const Alignment(0.7, -0.4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              decoration: BoxDecoration(
                color: ColorTheme.cWhite.withOpacity(0.05),
                border: Border.all(
                    width: 1, color: ColorTheme.cBlack.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
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
                        'UNLOCK YOUR ACCOUNT',
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
                      Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: ColorTheme.cWhite.withOpacity(0.2),
                            border: Border.all(
                                width: 1,
                                color: ColorTheme.cBlack.withOpacity(0.2)),
                            // borderRadius: const BorderRadius.only(
                            //     topLeft: Radius.circular(8),
                            //     topRight: Radius.circular(8)),
                            borderRadius: const BorderRadius.all(Radius.circular(8))
                          ),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 8),
                                  child: TextWidget(
                                    text: 'PIN',
                                    fontSize: isMobile ? 12 : 14,
                                    fontWeight: FontTheme.fontSemiBold,
                                    color: ColorTheme.cAppLoginTheme,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, bottom: 10),
                                  child: Pinput(
                                    onChanged: (value) {
                                      if (value.length == 4) {
                                        _onLoginTap();
                                      }
                                    },
                                    autofocus: true,
                                    defaultPinTheme: PinTheme(
                                      textStyle: TextStyle(
                                        color: ColorTheme.cWhite,
                                        fontWeight: FontTheme.fontBold,
                                        fontSize: 18,
                                      ),
                                      width: 18,
                                      height: 22,
                                    ),
                                    controller: controller.txtPass.value,
                                    closeKeyboardWhenCompleted: false,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onCompleted: (value) {},
                                    length: 4,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ])),
                      // SizedBox(
                      //   height: isMobile ? 6 : 8,
                      // ),
                      // _loginButton(),
                    ],
                  ),
                ).paddingAll(24),
              )),
        ),
      ),
    );
  }

  void _onLoginTap() {
    if (controller.formKey.currentState!.validate()) {
      appLoader(Get.context!);
      controller.getUnlockScreen().then(
        (value) {
          if (value) {
            removeAppLoader(Get.context!);
            PreferenceController.setBool(SharedPref.isUserLocked, false);

            ColorTheme.changeAppTheme(isDark: controller.isDark);
            Get.offAllNamed(RouteNames.kDashboard);
            controller.txtPass.value.clear();
          } else {
            controller.txtPass.value.clear();
            removeAppLoader(Get.context!);
          }
        },
      );
/*      controller.checkIn(isCheckIn: true,pin:controller.txtPass.value.text ).then((value) {
        if (value) {
          PreferenceController.setBool(SharedPref.isUserLogin, true);

          ColorTheme.changeAppTheme(
              isDark: PreferenceController.getBool(SharedPref.isDark));
          Get.offAllNamed(RouteNames.kDashboard);
        }
      });*/
    }
  }

  @override
  void dispose() {
    controller.videoPlayerController.value.dispose();
    controller.chewieController.value.dispose();
    Get.delete<CheckInController>();
    super.dispose();
  }
}
