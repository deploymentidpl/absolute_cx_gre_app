import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/menu_model.dart';

RxBool isHoverDisable = false.obs;
RxInt expandedIndex = (-1).obs;
RxList<MenuModel> menuList = <MenuModel>[].obs;

class LayoutTemplateController extends GetxController {
  GlobalKey myWidgetKey = GlobalKey();
  RxDouble drawerWidth = 0.0.obs;
  RxBool showDrawer = true.obs;

  // late AnimationController animationController;

  @override
  Future<void> onInit() async {
    super.onInit();
    // if (Settings.isUserLogin) {
    // await AuthRepo().getLoginData();
    showDrawer.value = true;
    //}
    getMenuList();
    //showDrawer.value = Settings.isUserLogin;
    // showDrawer.value = true;
  }

  onChangeHover() {
    // animationController.addListener(() {
    //   if (animationController.isDismissed) {
    //     devPrint("complete" + "4163435");
    //   }
    // });
    isHoverDisable.value = !isHoverDisable.value;
  }

  getMenuList() {
    menuList.clear();
    //menuList.value = Settings.loginData.menudata!;
    menuList.add(MenuModel(
        menuIcon: "assets/icons/home.svg", menu: "Dashboard", alias: 'home'));
    menuList.add(MenuModel(
        menuIcon: "assets/icons/SiteVisit.svg",
        menu: "Site Visit",
        count: 0.obs,
        alias: 'sitevisit'));
    update();
    menuList.refresh();
  }
}
