import 'package:get/get.dart';

class WebHeaderController extends GetxController{
  RxList<String> projectsList = RxList([]);
  RxString selectedProject = "".obs;
  RxList<String> availableList = RxList([]);
  RxString selectedAvailability = "".obs;
  RxInt notificationCount = 10.obs;

  WebHeaderController(){
    getProjects();
  }


  getProjects(){
    projectsList.addAll(["Falcon Tower","Swara Park Square", "Sky Line"]);
    selectedProject.value = projectsList.first;
    availableList.addAll(["Available for Call","Available for Chat", "Not Available"]);
    selectedAvailability.value = availableList.first;
  }
}