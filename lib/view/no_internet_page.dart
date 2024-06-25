import 'package:flutter/material.dart';
import 'package:greapp/style/assets_string.dart';

import '../style/theme_color.dart';

class NoInterNetConnection extends StatelessWidget {
  const NoInterNetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AssetsString.aNoInternet,
        height: 400,
        width: 400,
        color: ColorTheme.cAppTheme,
      ),
    );
  }
}
