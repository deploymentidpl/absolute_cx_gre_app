// import 'dart:ui';
import 'package:get/get.dart';

class MenuModel {
  String? menu;
  String? alias;
  RxInt? count;
  String? menuIcon;
  bool? isCurrent=false;

  MenuModel({
    this.menuIcon,
    this.menu,
    this.count,
    this.alias,
    this.isCurrent,
  });
}



