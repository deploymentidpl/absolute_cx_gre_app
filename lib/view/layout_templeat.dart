import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../components/hover_builder.dart';
import '../controller/layout_templete_controller.dart';
import '../style/theme_color.dart';

class LayoutTemplate extends GetView<LayoutTemplateController> {
  const LayoutTemplate({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return Scaffold(
              body: ResponsiveBuilder(
                builder: (context, sizingInformation) => Row(
                  children: [
                    Visibility(
                      visible: !sizingInformation.isMobile &&
                          controller.showDrawer.value,
                      child: HoverBuilder(builder: (isHovered) {
                        if (!(isHovered || isHoverDisable.value)) {
                          expandedIndex.value = -1;
                        }
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 30),
                          color: ColorTheme.cBlack,
                          width: 0,
                          child: SizedBox(
                              width: (isHovered || isHoverDisable.value)
                                  ? 250
                                  : 75,
                              child: const SizedBox(
                                width: 0,
                              )),
                        );
                      }),
                    ),
                    Expanded(child: child)
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
