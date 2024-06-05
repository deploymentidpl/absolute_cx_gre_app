import 'package:get/get.dart';

enum CurrentScreen  {dashboard, siteVisit, knowledgeBase}

class WebTabBarController extends GetxController {
  Rx<CurrentScreen> currentScreen = CurrentScreen.dashboard.obs;


}
