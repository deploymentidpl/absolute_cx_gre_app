 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/absolute_logo.dart';
import '../../controller/splash_controller.dart';
import '../../style/theme_color.dart';


class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
   controller.update();
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
}
