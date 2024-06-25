import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
  Future<Position> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
