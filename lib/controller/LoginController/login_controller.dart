import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  // RxDouble height = (0.0).obs;
  Rx<TextEditingController> txtEID = TextEditingController().obs;
  Rx<TextEditingController> txtPass = TextEditingController().obs;
  Rx<TextEditingController> txtPIN = TextEditingController().obs;
}