import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../components/text_widget.dart';
import '../style/assets_string.dart';
import '../style/theme_color.dart';

FToast fToast = FToast();

void showCustomToast(Widget child) {
  fToast.init(Get.context!);
  fToast.removeCustomToast();
  fToast.showToast(
    child: child,
    gravity: ToastGravity.TOP_RIGHT,
    toastDuration: const Duration(seconds: 5),
    positionedToastBuilder: (context, child) {
      return Positioned(
        top: 16,
        right: 0,
        child: child,
      );
    },
  );
}

class CustomToast extends StatefulWidget {
  final int type;
  final String? title;
  final String? subTitle;

  const CustomToast({super.key, required this.type, this.title, this.subTitle});

  @override
  State<CustomToast> createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast>
    with SingleTickerProviderStateMixin {
  double time = 0.0;
  int t = 0;
  Timer? timer;

  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));
  late final Animation<Offset> _animation = Tween<Offset>(
    begin: const Offset(1.5, 0),
    end: const Offset(0, 0),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void initState() {
    _controller.forward();
    Future.delayed(const Duration(seconds: 5)).then((value) {
      if (!_controller.isDismissed) {
        _controller.reverse();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 350, minWidth: 200),
          decoration: BoxDecoration(
            color: ColorTheme.cBlack,
            border: Border.all(
                width: 1, color: ColorTheme.cBlack.withOpacity(0.8)),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.10),
                spreadRadius: 1,
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  widget.type == 1
                      ? AssetsString.aSuccess
                      : widget.type == 3
                          ? AssetsString.aWarning
                          : AssetsString.aError,
                  height: 25,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3, left: 5),
                      child: TextWidget(
                        text: widget.title ??
                            (widget.type == 1
                                ? 'Success!'
                                : widget.type == 3
                                    ? 'Warning!'
                                    : 'Error!'),
                        fontSize: 18,
                        color: widget.type == 1
                            ? const Color(0xFF1AB595)
                            : widget.type == 3
                                ? const Color(0xFFFFB900)
                                : const Color(0xFFF56E6E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6, left: 5),
                      child: TextWidget(
                        text: widget.subTitle ?? '',
                        textOverflow: TextOverflow.visible,
                        fontSize: 12,
                        color: ColorTheme.cFontWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: ColorTheme.cGrey.withOpacity(0.25)),
                child: IconButton(
                  onPressed: () {
                    _controller.reverse();
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        fToast.removeCustomToast();
                      },
                    );
                  },
                  hoverColor: Colors.transparent,
                  icon:   Icon(
                    Icons.clear,
                    color: ColorTheme.cBlack,
                    size: 12,
                  ),
                ),
              ).paddingOnly(right: 12, left: 30),
            ],
          ),
        ),
      ),
    );
  }
}

void showError(String message) {
  showCustomToast(CustomToast(
    type: 2,
    subTitle: message,
  ));
}

void showSuccess(String message) {
  showCustomToast(CustomToast(
    type: 1,
    subTitle: message,
  ));
}

enum MsgType { success, error }

showToastMessage(String msg, MsgType type) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: MsgType.success == type ? Colors.white : Colors.red,
      textColor: MsgType.success == type ? Colors.black : Colors.white,
      fontSize: 16.0);
}
