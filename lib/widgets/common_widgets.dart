import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../config/utils/constant.dart';

Widget responsiveRowColumn({required Widget widget1, required Widget widget2}) {
  return ResponsiveRowColumn(
    columnMainAxisSize: MainAxisSize.min,
    columnMainAxisAlignment: MainAxisAlignment.start,
    rowCrossAxisAlignment: CrossAxisAlignment.start,
    layout:
        isMobile ? ResponsiveRowColumnType.COLUMN : ResponsiveRowColumnType.ROW,
    rowSpacing: 20,
    children: [
      ResponsiveRowColumnItem(rowFlex: 1, columnFlex: 1, child: widget1),
      ResponsiveRowColumnItem(rowFlex: 1, columnFlex: 1, child: widget2)
    ],
  );
}
