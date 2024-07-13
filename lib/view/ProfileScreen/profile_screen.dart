import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/model/EmployeeModel/employee_model.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/widgets/CustomSmallWidgets/custom_small_widgets.dart';

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
                child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  if (controller.employeeDetail.value.employeeId != "") {
                    EmployeeModel obj = controller.employeeDetail.value;
                    return SingleChildScrollView(
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
                            /*    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //todo: get image
                                    Container(
                                      color: ColorTheme.cGreen,
                                      height: 80,
                                      width: 80,
                                      child: Center(
                                        child: Text(
                                          obj.empFormattedName
                                              .trim()
                                              .substring(0, 1),
                                          style: mediumTextStyle(size: 45),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text(
                                      obj.empFormattedName,
                                      style: boldTextStyle(size: 20),
                                    )
                                  ],
                                ),*/
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 215,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: ColorTheme.cGreen,
                                        height: 80,
                                        width: 80,
                                        child: Center(
                                          child: Text(
                                            obj.empFormattedName
                                                .trim()
                                                .substring(0, 1),
                                            style: mediumTextStyle(size: 45),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Text(
                                        obj.empFormattedName,
                                        style: boldTextStyle(size: 20),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        color: ColorTheme.cThemeCard,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
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
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        ColorTheme.cWhite,
                                                        BlendMode.srcIn),
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
                                                  obj.employeeId,
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
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
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        ColorTheme.cWhite,
                                                        BlendMode.srcIn),
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
                                                  obj.mobileNo,
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
                                      child: Obx(() => Text(
                                            controller.changePin.value
                                                ? "SAVE PIN"
                                                : "CHANGE PIN",
                                            style: mediumTextStyle(),
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Data",
                        style:
                            mediumTextStyle(color: ColorTheme.cHintTextColor),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Text(
                      "Loading...",
                      style: mediumTextStyle(color: ColorTheme.cHintTextColor),
                    ),
                  );
                }
              },
              future: controller.getProfileDetails(),
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
            controller: controller.passwordTextController.value,
            textAlign: TextAlign.center,
            inputFormat: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 4,
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
