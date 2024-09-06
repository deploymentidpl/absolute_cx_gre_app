import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:greapp/style/theme_color.dart';

import '../Shimmer/box_shimmer.dart';

Widget cachedNetworkImageDynamic({
  required String imageUrl,
  double? width,
  double? height,
  double? errorWidth,
  double? errorHeight,
  BoxFit? fit,
  Widget? errorWidget,
  Color? bgColor,
  Color? iconColor,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    height: height,
    width: width,
    placeholder: (context, url) => BoxShimmer(
      height: height ?? errorHeight,
      width: width ?? errorWidth,
    ),
    errorWidget: (context, url, error) {
      return Container(
          color: bgColor ?? ColorTheme.cWhite.withOpacity(0.2),
          child: SizedBox(
            //dynamic error height
            height: errorWidth,
            width: errorHeight,
            child: errorWidget ??
                Center(
                  child: Icon(
                    Icons.broken_image,
                    color: iconColor ?? ColorTheme.cAppTheme,
                  ),
                ),
          ));
    },
    fit: fit ?? BoxFit.cover,
  );
}
