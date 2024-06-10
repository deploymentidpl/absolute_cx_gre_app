import 'package:get/get.dart';
import 'package:greapp/model/common_model.dart';

class SVFormController extends GetxController{

  RxInt tabIndex = 0.obs;
  RxList<CommonModel> tabs = RxList([]);

  SVFormController(){
    getTabData();
  }

  getTabData(){
tabs.addAll([
  CommonModel(code: "verify", description: "Lets Get Started"),
  CommonModel(code: "personal", description: "Personal Details"),
  CommonModel(code: "professional", description: "Professional Details"),]);
  }
}