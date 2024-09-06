import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constant.dart';

class SizeConfig {
  final Size defaultSize =
      isMobile ? const Size(360, 690) : const Size(1024, 768);
  double screenHeight = Get.height;
  double screenWidth = Get.width;

  double get scaleWidth => screenWidth / defaultSize.width;

  double get scaleHeight => screenHeight / defaultSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);

  double setWidth(num width) => width * scaleWidth;

  double setHeight(num height) => height * scaleHeight;

  double setSp(num fontSize) => fontSize * scaleText;
}

extension NumExtension on num {
  double get w => SizeConfig().setWidth(this);

  double get h => SizeConfig().setHeight(this);

  double get sp => SizeConfig().setSp(this);
}
