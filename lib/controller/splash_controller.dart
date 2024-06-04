import 'package:get/get.dart';

import '../routes/route_name.dart';

class SplashController extends GetxController {
  RxInt count = 0.obs;

  @override
  Future<void> onInit() async {
    // await getAccessToken();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAllNamed(RouteNames.kDashboard);
    });
    super.onInit();
  }
}
