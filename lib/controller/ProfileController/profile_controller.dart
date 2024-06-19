import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController { 
  TextEditingController passwordTextController = TextEditingController();
  RxBool showPass = true.obs;
  RxBool changePin = false.obs;
  RxString password = "1234".obs;
  ProfileController(){
    passwordTextController.text = password.value;
  }
}
