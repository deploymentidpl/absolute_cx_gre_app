import 'package:get/get.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';

import '../routes/route_name.dart';

class SplashController extends GetxController {
  RxInt count = 0.obs;
  double screenHeight = 0.0;

  @override
  Future<void> onInit() async {
    // await getAccessToken();
    Future.delayed(const Duration(seconds: 3)).then((value) {

      if(PreferenceController.getBool(SharedPref.isUserLogin)){

        Get.offAllNamed(RouteNames.kDashboard);
      }else{

        Get.offAllNamed(RouteNames.kLogin, );
      }
    });
    super.onInit();
  }
}
