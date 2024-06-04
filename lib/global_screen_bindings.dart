

import 'package:get/get.dart';

import 'controller/splash_controller.dart';

class GlobalScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    //Get.lazyPut<LoginScreenController>(() => LoginScreenController());
  }
}
