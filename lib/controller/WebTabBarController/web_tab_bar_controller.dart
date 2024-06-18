import 'package:get/get.dart';

import '../../config/utils/constant.dart';
import '../../routes/route_name.dart';


class WebTabBarController extends GetxController {
  Rx<CurrentScreen> currentScreen = CurrentScreen.dashboard.obs;


  navigation(){
    if(currentScreen.value == CurrentScreen.dashboard){
      Get.toNamed(RouteNames.kDashboard);
    }else if(currentScreen.value == CurrentScreen.siteVisit){

      Get.toNamed(RouteNames.kSVForm);
    }else if(currentScreen.value == CurrentScreen.knowledgeBase){
      Get.toNamed(RouteNames.kKnowledgebase);
    }
  }

}
