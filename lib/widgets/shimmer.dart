import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../style/theme_color.dart';

Widget shimmerWidget({double height = 0, double width = 0, double radius = 0}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: ColorTheme.cWhite, borderRadius: BorderRadius.circular(radius)),
  );
}

Widget shimmerEffect({required Widget child}) {
  return Shimmer.fromColors(
      baseColor: ColorTheme.cGrey,
      highlightColor: ColorTheme.cGrey,
      child: child);
}
