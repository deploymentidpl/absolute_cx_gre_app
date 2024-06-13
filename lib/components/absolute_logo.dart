
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../style/assets_string.dart';
import '../style/theme_color.dart';
enum LogoType{
  kColors,
  kWhite
}
class AbsoluteLogo extends StatelessWidget {
  const AbsoluteLogo({
    super.key,
    required this.size,
    this.showName = false,
    this.color,
    this.logo=LogoType.kColors,
  });

  final double size;
  final bool showName;
  final Color? color;
  final LogoType? logo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size,
            //width: size,
            child: Stack(
              children: [
                if(logo==LogoType.kColors)
                Center(
                  child: SvgPicture.asset(
                    AssetsString.aLogoBackground,
                   // colorFilter: ColorFilter.mode(color ?? ColorTheme.cBlack, BlendMode.srcIn),
                    height: size * 3 / 5,
                  ),
                ),
                if(logo==LogoType.kWhite)
                  Center(
                    child: SvgPicture.asset(
                      //todo: add string
                      "AssetsString.aLogoWhite",
                      // colorFilter: ColorFilter.mode(color ?? ColorTheme.cBlack, BlendMode.srcIn),
                      height: size,
                    ),
                  ),

              ],
            ),
          ),
          Visibility(
            visible: showName,
            child: SizedBox(
              height: size,
              child: SvgPicture.asset(
                //todo: add string
                "AssetsString.aLogoPreNew",
                height: size * 2.5 / 7,
                colorFilter: ColorFilter.mode(color ?? ColorTheme.cBlack, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
