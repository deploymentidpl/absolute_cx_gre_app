import 'package:flutter/material.dart';
import 'package:greapp/style/theme_color.dart';
import 'package:shimmer/shimmer.dart';


class BoxShimmer extends StatelessWidget {
  const BoxShimmer({super.key, this.height, this.width, this.radius, this.highlightColor, this.baseColor});

  final double? height;
  final double? width;
  final double? radius;
  final Color? highlightColor;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: highlightColor?? ColorTheme.cLineColor.withOpacity(0.2),
      baseColor: baseColor??ColorTheme.cThemeBg.withOpacity(0.5),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color:ColorTheme.cTransparent, ),
        height: height ?? 10,
        width: width ?? 40,
      ),
    );
  }
}
