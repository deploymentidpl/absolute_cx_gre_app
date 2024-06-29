import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../config/utils/constant.dart';
import '../../style/assets_string.dart';

class LoginController extends GetxController{
  // RxDouble height = (0.0).obs;
  Rx<TextEditingController> txtEID = TextEditingController().obs;
  Rx<TextEditingController> txtPass = TextEditingController().obs;
  Rx<TextEditingController> txtPIN = TextEditingController().obs;


  // TextEditingController cntEmpIdText = TextEditingController();
  // TextEditingController cntEmpOtpText = TextEditingController();
  GlobalKey<FormState> formKeyEmp = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyOtp = GlobalKey<FormState>();
  RxBool isShowOtp = false.obs;
  RxBool isShowEmpMsg = false.obs;
  RxBool isShowOtpMsg = false.obs;
  RxBool isOtpScreen = false.obs;
  RxString message = "".obs;
  final FocusNode empCodeFocusNode = FocusNode();
  final FocusNode empOtpFocusNode = FocusNode();
  //DeviceData deviceData = DeviceData();
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  late Rx<VideoPlayerController> videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  late Rx<ChewieController> chewieController;



  LoginController(){
    videoPlayerController =
        VideoPlayerController.asset(AssetsString.aLoginBackgroundMp4).obs;
    if(isWeb){

      initializeVideoPlayerFuture = initializeVideoPlayer();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController.value,
        autoPlay: true,
        looping: true,
        showControls: false,
        autoInitialize: true,
      ).obs;
      if (!kIsWeb) {
        chewieController.value.play();

      }

      empCodeFocusNode.requestFocus();
    }
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

    Future.delayed(
      const Duration(seconds: 3),
          () {
        if (!videoPlayerController.value.value.isPlaying) {
          videoPlayerController.refresh();
          videoPlayerController.value.play();
        }
      },
    );
    videoPlayerController.refresh();
  }}