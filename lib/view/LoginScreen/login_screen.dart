import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/function.dart';
import 'package:greapp/config/Helper/validators.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:greapp/controller/LoginController/login_controller.dart';
import 'package:greapp/widgets/custom_text_field.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../components/absolute_logo.dart';
import '../../components/text_widget.dart';
import '../../config/utils/connectivity_service.dart';
import '../../config/utils/constant.dart';
import '../../routes/route_name.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';

class LoginScreen extends StatefulWidget {
    const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.find<LoginController>();

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
                      _eidField(),
                      _passField(),
                      SizedBox(
                        height: isMobile ? 6 : 8,
                      ),
                      _loginButton(),
                    ],
                  ),
                ).paddingAll(24),
              )),
        ),
      ),
    );
  }

  Widget _eidField() {
    return Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: ColorTheme.cWhite.withOpacity(0.2),
          border:
              Border.all(width: 1, color: ColorTheme.cBlack.withOpacity(0.2)),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
          ),
          child: customTextField(
            prefixWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: 'EID',
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontTheme.fontSemiBold,
                  color: ColorTheme.cAppLoginTheme.withOpacity(0.6),
                ),
              ],
            ),
            inputFormat: [formatterDigitsOnly],
            maxLength: 6,
            textAlignVertical: TextAlignVertical.center,
            showLabel: false,
            validator: Validators.text,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            textFieldColor: ColorTheme.cTransparent,
            disableColor: ColorTheme.cTransparent,
            controller: controller.txtEID.value,
            mainStyle: boldTextStyle(
              color: ColorTheme.cWhite,
              size: 18,
            ),
            onChange: (value) {
              controller.txtEID.refresh();
            },
          ),
        ));
  }

  Widget _passField() {
    return Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: ColorTheme.cWhite.withOpacity(0.2),
          border:
              Border.all(width: 1, color: ColorTheme.cBlack.withOpacity(0.2)),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
          ),
          child: customTextField(
            prefixWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: "Pass",
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontTheme.fontSemiBold,
                  color: ColorTheme.cAppLoginTheme.withOpacity(0.6),
                ),
              ],
            ),
            validator: Validators.text,
            textAlignVertical: TextAlignVertical.center,
            showLabel: false,
            obscureText: true,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            textFieldColor: ColorTheme.cTransparent,
            disableColor: ColorTheme.cTransparent,
            controller: controller.txtPass.value,
            mainStyle: boldTextStyle(
              color: ColorTheme.cWhite,
              size: 18,
            ),
            onChange: (value) {
              controller.txtPass.refresh();
            },
          ),
        ));
  }

  Widget _loginButton() {
    return GestureDetector(
      onTap: _onLoginTap,
      child: Obx(() => Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: controller.txtEID.value.text.length == 6 &&
                    controller.txtPass.value.text.length > 2
                ? ColorTheme.cAppLoginTheme
                : ColorTheme.cWhite.withOpacity(0.2),
            border: Border.all(
                width: 1,
                color: controller.txtEID.value.text.length == 6 &&
                        controller.txtPass.value.text.length > 2
                    ? ColorTheme.cTransparent
                    : ColorTheme.cAppLoginTheme.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "Login",
            style: boldTextStyle(
              size: isMobile ? 14 : 16,
              color: controller.txtEID.value.text.length == 6 &&
                      controller.txtPass.value.text.length > 2
                  ? ColorTheme.cWhite
                  : ColorTheme.cAppLoginTheme.withOpacity(0.6),
              height: 1,
            ),
          ))),
    );
  }

  void _onLoginTap() {
    if (controller.formKey.currentState!.validate()) {
      controller.checkIn().then((value) {
        if (value) {
          PreferenceController.setBool(SharedPref.isUserLogin, true);

          Get.offAllNamed(RouteNames.kDashboard);
        }
      });
    }
  }

  @override
  void dispose() {
    controller.videoPlayerController.value.dispose();
    controller.chewieController.value.dispose();
    Get.delete<LoginController>();
    super.dispose();
  }
}
