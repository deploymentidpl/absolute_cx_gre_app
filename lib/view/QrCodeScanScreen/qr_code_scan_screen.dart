import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:scan/scan.dart';

import '../../controller/QrCodeScanController/qr_code_scan_controller.dart';
import '../../style/theme_color.dart';
import '../../widgets/custom_dialogs.dart';

class QrCodeScanScreen extends GetView<QrCodeScanController> {
  const QrCodeScanScreen({super.key});

  void scanResultCheck(String data) {
    if (data.length <= 29 && !data.contains("http")) {
    } else {
      showToastMessage("Invalid QR Code", MsgType.error);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            ScanView(
              controller: controller.scanController,
              scanAreaScale: 0.7,
              scanLineColor: ColorTheme.cAppTheme,
              onCapture: (data) {
                scanResultCheck(data);
              },
            ),
            Positioned(
              top: 20,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: Center(
                    child: SvgPicture.asset(
                      AssetsString.aBackArrow,
                      height: 30,
                      width: 30,
                      colorFilter: const ColorFilter.mode(
                          ColorTheme.cWhite, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
