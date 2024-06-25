import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:greapp/controller/LoginController/login_controller.dart';
import 'package:greapp/widgets/custom_text_field.dart';

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
    return Scaffold(
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
                      SharedPref.isUserLocked)?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "UNLOCK",
                        style: boldTextStyle(
                            fontStyle: FontStyle.italic, size: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customTextField(
                          labelText: "PIN",
                          controller: controller.txtPIN.value,
                          onTapOutside: (p0) {},
                          onChange: (value) {
                            controller.txtPIN.refresh();
                          },
                          textFieldColor:
                              ColorTheme.cFontWhite.withOpacity(0.2)),

                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() => CustomButtons.appThemeButton(
                          text: "Login",
                          width: Get.width,
                          onTap: () {
                            PreferenceController.setBool(
                                SharedPref.isUserLocked, false);

                            Get.offAllNamed(RouteNames.kDashboard);
                          },
                          enable: controller.txtPIN.value.text.isNotEmpty  )),
                    ],
                  ): Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "WELCOME TO GRE",
                        style: boldTextStyle(
                            fontStyle: FontStyle.italic, size: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customTextField(
                          labelText: "EID",
                          controller: controller.txtEID.value,
                          onTapOutside: (p0) {},
                          onChange: (value) {
                            controller.txtEID.refresh();
                          },
                          textFieldColor:
                              ColorTheme.cFontWhite.withOpacity(0.2)),
                      customTextField(
                          labelText: "Password",
                          obscureText: true,
                          onTapOutside: (p0) {},
                          onChange: (value) {
                            controller.txtPass.refresh();
                          },
                          controller: controller.txtPass.value,
                          textFieldColor:
                              ColorTheme.cFontWhite.withOpacity(0.2)),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() => CustomButtons.appThemeButton(
                          text: "Login",
                          width: Get.width,
                          onTap: () {
                            PreferenceController.setBool(
                                SharedPref.isUserLogin, true);
                            print(PreferenceController.getBool(
                                SharedPref.isUserLogin));
                            Get.offAllNamed(RouteNames.kDashboard);
                          },
                          enable: controller.txtEID.value.text.isNotEmpty &&
                              controller.txtPass.value.text.isNotEmpty)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
