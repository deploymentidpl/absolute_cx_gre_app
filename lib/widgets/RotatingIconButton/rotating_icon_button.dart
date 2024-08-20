import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../style/assets_string.dart';
import '../../style/theme_color.dart';

class RotatingIconButton extends StatefulWidget {
  final Future<void> Function() onPressed; // API call function
  final double iconSize;
  const RotatingIconButton({required this.onPressed, super.key,   this.iconSize = 25});

  @override
  RotatingIconButtonState createState() => RotatingIconButtonState();
}

class RotatingIconButtonState extends State<RotatingIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isRotating = false;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with a duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat(); // Repeat the animation continuously
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startRotation() {
    setState(() {
      isRotating = true;
    });
    _controller.forward(); // Start rotation
  }

  void _stopRotation() {
    setState(() {
      isRotating = false;
    });
    _controller.reset(); // Reset the rotation
  }

  Future<void> _handlePress() async {
    _startRotation();
    try {
      await widget.onPressed(); // Call the provided API function
    } finally {
      _stopRotation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  isRotating ? null : _handlePress,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          height: 40,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: -(_controller.value * 2 * 3.14159), // Full rotation
                child: child,

              );
            },
            child: SvgPicture.asset(
              AssetsString.aRefresh,
              height: widget.iconSize,
              colorFilter:
                  const ColorFilter.mode(ColorTheme.cWhite, BlendMode.srcIn),
            ), // The sync icon
          ),
        ),
      ),
    );
  }
}
