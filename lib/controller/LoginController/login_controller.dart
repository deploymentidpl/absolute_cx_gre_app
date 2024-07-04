import 'dart:convert';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:greapp/model/CheckInModel/check_in_model.dart';
import 'package:video_player/video_player.dart';

import '../../config/Helper/api_response.dart';
import '../../config/shared_pref.dart';
import '../../config/utils/api_constant.dart';
import '../../style/assets_string.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> txtEID = TextEditingController().obs;
  Rx<TextEditingController> txtPass = TextEditingController().obs;

  // Rx<TextEditingController> txtPIN = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<CheckInModel> checkInData = CheckInModel().obs;

  RxBool isShowEmpMsg = false.obs;
  RxBool isShowOtpMsg = false.obs;
  RxBool isOtpScreen = false.obs;
  RxString message = "".obs;
  RxBool isLoading = false.obs;

  late Rx<VideoPlayerController> videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  late Rx<ChewieController> chewieController;

  LoginController() {
    videoPlayerController =
        VideoPlayerController.asset(AssetsString.aLoginBackgroundMp4).obs;

    initializeVideoPlayerFuture = initializeVideoPlayer();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController.value,
      autoPlay: true,
      looping: true,
      showControls: false,
      autoInitialize: true,
    ).obs;
    chewieController.value.play();
  }

  Future<void> initializeVideoPlayer() async {
    await videoPlayerController.value.initialize();
    videoPlayerController.value.setLooping(true);
    videoPlayerController.value.setVolume(0.0);
    videoPlayerController.value.addListener(() {
      if (videoPlayerController.value.value.isInitialized) {
        videoPlayerController.refresh();
      }
    });

    if (!videoPlayerController.value.value.isPlaying) {
      videoPlayerController.refresh();
      videoPlayerController.value.play();
    }
    videoPlayerController.refresh();
  }

  Future<bool> checkIn() async {
    try {
      Map<String, dynamic> data = {
        "employee_id": txtEID.value.text,
        "employee_password": txtPass.value.text,
        "type": "checkin"
      };


      ApiResponse response = ApiResponse(
          data: data,
          baseUrl: Api.apiLogin,
          apiHeaderType: ApiHeaderType.content,
          apiMethod: ApiMethod.post);
      Map<String, dynamic> responseData = await response.getResponse() ?? {};


      if (responseData['success'] == true) {
        checkInData.value = CheckInBaseModel.fromJson(responseData).data;
        checkInData.refresh();
        PreferenceController.setString(
            SharedPref.employeeID, checkInData.value.employeeId);
      } else {
        return false;
      }
      return true;
    } catch (error, stack) {
      log(error.toString());
      log(stack.toString());
      return false;
    }
  }

  @override
  void dispose() {
    videoPlayerController.value.dispose();
    chewieController.value.dispose();
    super.dispose();
  }
}
