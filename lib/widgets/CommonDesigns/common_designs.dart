import "package:flutter/material.dart";

import "../../style/assets_string.dart";
import "../../style/theme_color.dart";

Widget appBgWithBuilding({required double height}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.topLeft,
            colors: [
          ColorTheme.bgPink,
          ColorTheme.bgPurple,
          ColorTheme.bgDarkPurple
        ])),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              AssetsString.aBuildings,
              height: height / 2,
            ),
          ],
        )
      ],
    ),
  );
}
