import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/widgets/CommonDesigns/common_designs.dart';

import '../../components/absolute_logo.dart';
import '../../config/utils/constant.dart';
import '../../controller/splash_controller.dart';
import '../../style/theme_color.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.update();
    return isWeb ? _webDesign() : _appDesign();
  }

  Widget _webDesign() {
    return const Scaffold(
      backgroundColor: ColorTheme.cWhite,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: AbsoluteLogo(
            size: 100,
            showName: false,
          ),
        ),
      ),
    );
  }

  Widget _appDesign() {
    controller.screenHeight = Get.height;
    return Scaffold(
      body: Stack(
        children: [
          appBgWithBuilding(height: Get.height),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: ColorTheme.cBlack.withOpacity(0.4),
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
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  "WELCOME TO ABSOLUTECX",
                  style: boldText8Style(fontStyle: FontStyle.italic, size: 16),
                ),
              )),
        ],
      ),
    );
  }
}
