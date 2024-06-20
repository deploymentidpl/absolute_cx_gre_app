import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';

import '../../config/utils/constant.dart';
import '../../controller/ProfileController/profile_controller.dart';
import '../../routes/route_name.dart';
import '../../style/theme_color.dart';
import '../../widgets/BottomBar/custom_bottombar.dart';
import '../../widgets/Drawer/app_drawer.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_text_field.dart';

class ProfileScreen extends GetView<ProfileController> {
    ProfileScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.cThemeBg,
      key: scaffoldKey,
      drawer: AppDrawer(
        alias: "",
        scaffoldState: scaffoldKey.currentState,
      ),
      body: SafeArea(
        child: Column(
          children: [
              AppHeader(
                scaffoldState: scaffoldKey,
              ),
            Expanded(
                child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 250,
                      color: ColorTheme.cBgAppTheme,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsString.aDummyProfile,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              "Cody Adams",
                              style: boldTextStyle(size: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 215,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: ColorTheme.cThemeCard,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: ColorTheme.cWhite
                                              .withOpacity(0.2),
                                          shape: BoxShape.circle),
                                      child: SvgPicture.asset(
                                        AssetsString.aId,
                                        colorFilter: const ColorFilter.mode(
                                            ColorTheme.cWhite, BlendMode.srcIn),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "EID:",
                                          style: mediumTextStyle(),
                                        ),
                                        Text(
                                          "103422",
                                          style: boldTextStyle(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: ColorTheme.cThemeCard,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: ColorTheme.cWhite
                                              .withOpacity(0.2),
                                          shape: BoxShape.circle),
                                      child: SvgPicture.asset(
                                        AssetsString.aId,
                                        colorFilter: const ColorFilter.mode(
                                            ColorTheme.cWhite, BlendMode.srcIn),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Contact: ",
                                          style: mediumTextStyle(),
                                        ),
                                        Text(
                                          "7048729538",
                                          style: boldTextStyle(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        secureTextFromField(),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              controller.changePin.value =
                                  !controller.changePin.value;
                            },
                            child: Container(
                              color: ColorTheme.cTransparent,
                              child: Text(
                                "CHANGE PIN",
                                style: mediumTextStyle(),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.toNamed(RouteNames.kSVForm);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: ColorTheme.cAppTheme, shape: BoxShape.circle),
          child: const Icon(
            Icons.add,
            color: ColorTheme.cWhite,
            size: 25,
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomBar(
        currentScreen: CurrentScreen.profile,
      ),
    );
  }

  Widget secureTextFromField() {
    return Stack(
      children: [
        Obx(() => customTextField(
            controller: controller.passwordTextController,
            textAlign: TextAlign.center,
            obscureText:
                controller.changePin.value ? false : controller.showPass.value,
            enabled: controller.changePin.value,
            suffixWidget: Container(
              color: Colors.transparent,
              height: 25,
              width: 25,
            ),
            prefixWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  AssetsString.aLock,
                  colorFilter: const ColorFilter.mode(
                      ColorTheme.cWhite, BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "PIN",
                  style: mediumTextStyle(),
                )
              ],
            ))),
        Positioned(
            right: 10,
            bottom: 15,
            child: Obx(() => controller.changePin.value
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      controller.showPass.value = !controller.showPass.value;
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: 25,
                      width: 25,
                      child: Center(
                        child: Obx(() => SvgPicture.asset(
                              controller.showPass.value
                                  ? AssetsString.aEyeOff
                                  : AssetsString.aEye,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
                            )),
                      ),
                    ),
                  )))
      ],
    );
  }
}
