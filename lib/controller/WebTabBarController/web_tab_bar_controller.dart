import 'package:get/get.dart';

import '../../config/utils/constant.dart';
import '../../model/common_model.dart';
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

  RxList<CommonModel> arrBuilding = [
    CommonModel(description: "Tower A"),
    CommonModel(description: "Tower B"),
    CommonModel(description: "Tower C"),
    CommonModel(description: "Tower D"),
    CommonModel(description: "Tower E"),
    CommonModel(description: "Tower F"),
    CommonModel(description: "Tower G"),
    CommonModel(description: "Tower H"),
    CommonModel(description: "Tower I"),
  ].obs;
}
