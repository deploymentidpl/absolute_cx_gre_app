import 'package:get/get.dart';

import 'controller/DashboardController/dashboard_controller.dart';
import 'controller/HomeController/home_controller.dart';
import 'controller/KnowledgeBaseController/knowledge_base_controller.dart';
import 'controller/LoginController/check_in_controller.dart';
import 'controller/LoginController/login_controller.dart';
import 'controller/MenuController/menu_controller.dart';
import 'controller/ProfileController/profile_controller.dart';
import 'controller/QrCodeScanController/qr_code_scan_controller.dart';
import 'controller/SVFormController/sv_form_controller.dart';
import 'controller/WebHeaderController/web_header_controller.dart';
import 'controller/WebTabBarController/web_tab_bar_controller.dart';
import 'controller/layout_templete_controller.dart';
import 'controller/splash_controller.dart';

class GlobalScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<CheckInController>(() => CheckInController());
    Get.lazyPut<LayoutTemplateController>(() => LayoutTemplateController());
    Get.lazyPut<WebHeaderController>(() => WebHeaderController());
    Get.lazyPut<WebTabBarController>(() => WebTabBarController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<SiteVisitFormController>(() => SiteVisitFormController());
    Get.lazyPut<KnowledgeBaseController>(() => KnowledgeBaseController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<MenusController>(() => MenusController());
    Get.lazyPut<QrCodeScanController>(() => QrCodeScanController());
  }
}
