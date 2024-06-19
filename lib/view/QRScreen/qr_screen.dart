import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/main.dart';
import 'package:greapp/style/text_style.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../config/utils/constant.dart';
import '../../routes/route_name.dart';
import '../../style/theme_color.dart';
import '../../widgets/BottomBar/custom_bottombar.dart';
import '../../widgets/app_header.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.cThemeBg,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.75,
                  child: Obx(
                    () => QrImageView(
                      data: commonSelectedProject.value,
                      backgroundColor: ColorTheme.cTransparent,
                      eyeStyle: const QrEyeStyle(
                          color: ColorTheme.cWhite,
                          eyeShape: QrEyeShape.square),
                      dataModuleStyle: const QrDataModuleStyle(
                          color: ColorTheme.cWhite,
                          dataModuleShape: QrDataModuleShape.square),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Text(
                    commonSelectedProject.value,
                    style: mediumTextStyle(size: 18),
                  ),
                )
              ],
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
        currentScreen: CurrentScreen.qr,
      ),
    );
  }
}
