import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/utils/constant.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/text_style.dart';
import 'package:greapp/style/theme_color.dart';

import '../../config/Helper/function.dart';
import '../../main.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({super.key, required this.currentScreen});

  final CurrentScreen currentScreen;

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: ColorTheme.cLineColor),
        ),
        color: ColorTheme.cThemeCard,
      ),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if(  kSelectedProject.value.id == ""){
                onNoProjectSelected();
              }else{

                Get.toNamed(RouteNames.kHomeScreen);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AssetsString.aHome,
                  height: 30,
                  colorFilter:   ColorFilter.mode(
                      ColorTheme.cWhite, BlendMode.srcIn),
                ),
                Container(
                    padding: EdgeInsets.only(
                        bottom: currentScreen == CurrentScreen.home ? 5 : 0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: currentScreen == CurrentScreen.home
                                    ? ColorTheme.cAppTheme
                                    : ColorTheme.cTransparent))),
                    child: Text(
                      "Home",
                      style: boldTextStyle(
                        size: 9,
                      ),
                    ))
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if(  kSelectedProject.value.id == ""){
                onNoProjectSelected();
              }else {
                Get.toNamed(RouteNames.kQRScreen);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AssetsString.aQRCode,
                  height: 30,
                  colorFilter:   ColorFilter.mode(
                      ColorTheme.cWhite, BlendMode.srcIn),
                ),
                Container(
                    padding: EdgeInsets.only(
                        bottom: currentScreen == CurrentScreen.qr ? 5 : 0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: currentScreen == CurrentScreen.qr
                                    ? ColorTheme.cAppTheme
                                    : ColorTheme.cTransparent))),
                    child: Text(
                      "Site QR",
                      style: boldTextStyle(
                        size: 9,
                      ),
                    ))
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteNames.kProfileScreen);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AssetsString.aUser,
                  height: 30,
                  colorFilter:   ColorFilter.mode(
                      ColorTheme.cWhite, BlendMode.srcIn),
                ),
                Container(
                    padding: EdgeInsets.only(
                        bottom: currentScreen == CurrentScreen.profile ? 5 : 0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: currentScreen == CurrentScreen.profile
                                    ? ColorTheme.cAppTheme
                                    : ColorTheme.cTransparent))),
                    child: Text(
                      "Profile",
                      style: boldTextStyle(
                        size: 9,
                      ),
                    ))
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteNames.kDashboard);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  currentScreen == CurrentScreen.dashboard
                      ? AssetsString.aDashboardFilled
                      : AssetsString.aDashboard,
                  height: 45,
                  colorFilter:  currentScreen != CurrentScreen.dashboard
                      ?ColorFilter.mode(ColorTheme.cWhite, BlendMode.srcIn):null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
