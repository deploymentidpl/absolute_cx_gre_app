import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../style/assets_string.dart';

class LoginController extends GetxController{
  // RxDouble height = (0.0).obs;
  Rx<TextEditingController> txtEID = TextEditingController().obs;
  Rx<TextEditingController> txtPass = TextEditingController().obs;
  Rx<TextEditingController> txtPIN = TextEditingController().obs;

  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  late ChewieController chewieController;

  LoginController(){
    videoPlayerController =
        VideoPlayerController.asset(AssetsString.aLoginBackgroundMp4);
    initializeVideoPlayerFuture = initializeVideoPlayer();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: false,
      autoInitialize: true,
    );
    if (!kIsWeb) {
      chewieController.play();
    }

  }

  Future<void> initializeVideoPlayer() async {
    await videoPlayerController.initialize();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.0);
    videoPlayerController.addListener(() {

    Future.delayed(
      const Duration(seconds: 3),
          () {
        if (!videoPlayerController.value.isPlaying) {
          videoPlayerController.play();
        }
      },
    );   });}}