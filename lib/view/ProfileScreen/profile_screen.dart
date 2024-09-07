import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/model/EmployeeModel/employee_model.dart';
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
  ProfileScreen({this.isSidebar = false, super.key});

  final bool isSidebar;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Scaffold(
        backgroundColor: isSidebar ? ColorTheme.cBgBlack : ColorTheme.cThemeBg,
        key: scaffoldKey,
        drawer: AppDrawer(
          alias: "",
          scaffoldState: scaffoldKey.currentState,
        ),
        body: SafeArea(
          child: Column(
            children: [
              isSidebar
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.centerLeft,
                      height: 60,
                      width: Get.width,
                      color: ColorTheme.cBgDarkPurple,
                      child: Text(
                        'My Profile',
                        textAlign: TextAlign.start,
                        style: boldTextStyle(color: Colors.white, size: 18),
                      ),
                    )
                  : AppHeader(
                      scaffoldState: scaffoldKey,
                    ),
              Expanded(
                  child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    if (controller.employeeDetail.value.employeeId != "") {
                      EmployeeModel obj = controller.employeeDetail.value;
                      return isSidebar ? _webContent(obj) : _mobileContent(obj);
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
                        style:
                            mediumTextStyle(color: ColorTheme.cHintTextColor),
                      ),
                    );
                  }
                },
                future: controller.getProfileDetails(),
              ))
            ],
          ),
        ),
        floatingActionButton:  isSidebar
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  Get.toNamed(RouteNames.kSVForm);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: ColorTheme.cAppTheme, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
        bottomNavigationBar: isSidebar
            ? const SizedBox()
            : const AppBottomBar(
                currentScreen: CurrentScreen.profile,
              ),
      ),
    );
  }

  Widget _webContent(EmployeeModel obj) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 250,
              color: ColorTheme.cBgBlack,
              child: Image.asset(
                AssetsString.profileFrame,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 250 - 40,
                ),
                _webData(obj),
                const SizedBox(
                  height: 15,
                ),
                _secureTextFromField(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: onChangeOrSave,
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
  }

  Widget _mobileContent(EmployeeModel obj) {
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
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _profileAndName(obj),
                _idAndContact(obj),
                _secureTextFromField(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                    onTap: onChangeOrSave,
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
  }

  Widget _profileAndName(EmployeeModel obj) {
    return SizedBox(
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
                obj.empFormattedName.trim().substring(0, 1),
                style: mediumTextStyle(size: 45, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            obj.empFormattedName,
            style: boldTextStyle(size: 20, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _idAndContact(EmployeeModel obj) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: ColorTheme.cThemeCard,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: ColorTheme.cWhite.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    AssetsString.aId,
                    colorFilter:
                        ColorFilter.mode(ColorTheme.cWhite, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: ColorTheme.cWhite.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    AssetsString.aId,
                    colorFilter:
                        ColorFilter.mode(ColorTheme.cWhite, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  Widget _webData(EmployeeModel obj) {
    return Column(
      children: [
        Container(
          color: ColorTheme.cGreen,
          height: 80,
          width: 80,
          child: Center(
            child: Text(
              obj.empFormattedName.trim().substring(0, 1),
              style: mediumTextStyle(size: 45),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          obj.empFormattedName,
          style: boldTextStyle(color: ColorTheme.cAppTheme, size: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'EMP ID: ',
              style: regularTextStyle(color: Colors.white, size: 18),
            ),
            Text(
              obj.employeeId,
              style: regularTextStyle(color: Colors.white, size: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contact: ',
              style: regularTextStyle(color: Colors.white, size: 18),
            ),
            Text(
              obj.mobileNo,
              style: regularTextStyle(color: Colors.white, size: 18),
            ),
          ],
        )
      ],
    );
  }

  Widget _secureTextFromField() {
    return Stack(
      children: [
        Form(
          key: formKey,
          child: Obx(() => customTextField(
              controller: controller.passwordTextController.value,
              textAlign: TextAlign.center,
              inputFormat: [FilteringTextInputFormatter.digitsOnly],
              showLabel: !isSidebar,
              focusNode: controller.pinFocusNode,
              maxLength: 4,
              validator: (value) {
                if (value != null && value.length != 4) {
                  controller.pinFocusNode.requestFocus();
                  return "Please enter pin";
                } else {
                  return null;
                }
              },
              obscureText: controller.changePin.value
                  ? false
                  : controller.showPass.value,
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
                    colorFilter:
                        ColorFilter.mode(ColorTheme.cWhite, BlendMode.srcIn),
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
        ),
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
                              colorFilter: ColorFilter.mode(
                                  ColorTheme.cWhite, BlendMode.srcIn),
                            )),
                      ),
                    ),
                  )))
      ],
    );
  }

  Future<void> onChangeOrSave() async {
    if (formKey.currentState!.validate()) {
      if (controller.changePin.value) {
        await controller.savePin();
      }

      controller.changePin.value = !controller.changePin.value;
    }
  }
}
