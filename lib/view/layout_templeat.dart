import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../components/absolute_logo.dart';
import '../components/hover_builder.dart';
import '../components/text_widget.dart';
import '../config/dev/dev_helper.dart';
import '../config/settings.dart';
import '../controller/layout_templete_controller.dart';
import '../model/menu_model.dart';
import '../style/assets_string.dart';
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
                    // Obx(() {
                    //   return
                    Visibility(
                      visible: !sizingInformation.isMobile &&
                          controller.showDrawer.value,
                      child: HoverBuilder(builder: (isHovered) {
                        if (!(isHovered || isHoverDisable.value))
                          expandedIndex.value = -1;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 30),
                          color: ColorTheme.cBlack,
                          width: 0,
                          //(isHovered || isHoverDisable.value) ? 250 : 75,
                          child: SizedBox(
                              width: (isHovered || isHoverDisable.value)
                                  ? 250
                                  : 75,
                              child: const SizedBox(
                                width: 0,
                              ) //sideBar(isHovered, isHoverDisable, false),
                              ),
                        );
                      }),
                    ),
                    // }),
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

Widget sideBar(isHovered, isHoverDisable, ismobile) {
  return Obx(() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: [
              AbsoluteLogo(
                color: ColorTheme.cWhite,
                size: 50,
                showName: (isHovered || isHoverDisable.value),
              ).paddingAll(8),
              if (!ismobile)
                (isHovered || isHoverDisable.value)
                    ? InkWell(
                        onTap: () {
                          isHoverDisable.value = !isHoverDisable.value;
                          devPrint('circle pressed');
                        },
                        child: Icon(
                          isHoverDisable.value
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color: Colors.white,
                          size: 20,
                        )).paddingOnly(left: 40)
                    : const SizedBox.shrink(),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: menuList.length,
              itemBuilder: (ctx, index) {
                MenuModel obj = menuList[index];
                return menuListTile(
                    obj, (isHovered || isHoverDisable.value), index);
              }),
        ),
        ListTile(
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          onTap: () {
            // layoutController.selectedMenu.value = {};
            // layoutController.navigateTo("/${widget.children['alias']}");
          },
          dense: true,
          leading: (isHovered || isHoverDisable.value)
              ? SvgPicture.asset(
                  //todo:add string
                  " AssetsString.aBuilding",
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  height: 25,
                  width: 25,
                )
              : null,
          titleAlignment: ListTileTitleAlignment.center,
          trailing: (isHovered || isHoverDisable.value)
              ? Container(
                  decoration: BoxDecoration(
                      color: ColorTheme.cRed,
                      borderRadius: BorderRadius.circular(20)),
                  child: const TextWidget(text: "20", color: ColorTheme.cWhite)
                      .paddingAll(2),
                )
              : null,
          title: (isHovered || isHoverDisable.value)
              ? const TextWidget(
                  text: "Notifications", color: ColorTheme.cWhite)
              : SvgPicture.asset(
                  //todo:add string
                  "AssetsString.aBuilding",
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  height: 25,
                  width: 25,
                ),
          contentPadding: EdgeInsets.zero,
        ).paddingSymmetric(horizontal: 12),
        if ((isHovered || isHoverDisable.value)) ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          AssetsString.aLogoBackground,
                          colorFilter: const ColorFilter.mode(
                              ColorTheme.cWhite, BlendMode.srcIn),
                          height: 25,
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 5,
                        child: SvgPicture.asset(
                          AssetsString.aLogo,
                          height: 15,
                        ),
                      )
                    ],
                  ).paddingOnly(left: 12, right: 8),
                  TextWidget(
                    text: Settings.userName,
                    color: ColorTheme.cWhite,
                  ),
                ]).paddingOnly(bottom: 16, top: 8),
          )
        ]
      ],
    );
  });
}

Widget menuListTile(MenuModel obj, isHovered, int index) {
  return Obx(() {
    return Container(
      decoration: (expandedIndex.value == index)
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: ColorTheme.cWhite.withOpacity(0.2))
          : null,
      child: Column(
        children: [
          ListTile(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            onTap: () {
              // if (obj.children.isNotNullOrEmpty) {
              //   if (expandedIndex.value == index) {
              //     expandedIndex.value = -1;
              //   } else {
              //     expandedIndex.value = index;
              //   }
              //   // isExpanded.value = !isExpanded.value;
              // } else {
              //   Get.offAllNamed('/${obj.alias!}');
              // }
            },
            dense: true,
            leading: isHovered
                ? SvgPicture.asset(
                    //todo:add string
                    "AssetsString.aBuilding",
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    height: 25,
                    width: 25,
                  )
                : null,
            titleAlignment: ListTileTitleAlignment.center,
            trailing: /*isHovered && obj.children.isNotNullOrEmpty
                ? Icon(
                    (expandedIndex.value == index) ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_right_rounded,
                    color: ColorTheme.cWhite,
                  )
                :*/
                null,
            title: (isHovered)
                ? TextWidget(
                    text: obj.menu ?? "",
                    color: ColorTheme.cWhite,
                  )
                : SvgPicture.asset(
                    //todo:add string
                    " AssetsString.aBuilding",
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    height: 25,
                    width: 25,
                  ),
            contentPadding: EdgeInsets.zero,
          ).paddingSymmetric(horizontal: 12),
          // if ((expandedIndex.value == index) && isHovered && obj.children.isNotNullOrEmpty)
          //   ListView.builder(
          //       shrinkWrap: true,
          //       padding: EdgeInsets.zero,
          //       itemCount: obj.children!.length,
          //       itemBuilder: (ctx, index) {
          //         MenuData innerObj = obj.children![index];
          //         return innerMenuListTile(innerObj);
          //       }).paddingSymmetric(horizontal: 16).paddingOnly(right: 8),
        ],
      ),
    ).paddingSymmetric(horizontal: 14);
  });
}

Widget innerMenuListTile(MenuModel obj) {
  return ListTile(
    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    onTap: () {
      Get.offAllNamed('/${obj.alias!}');
    },
    dense: true,
    leading: SvgPicture.asset(
        //todo:add string
        "AssetsString.aNoPageFound"),
    title: TextWidget(
      text: obj.menu ?? "",
      color: ColorTheme.cWhite,
    ),
    contentPadding: EdgeInsets.zero,
  ).paddingSymmetric(horizontal: 12).paddingOnly(bottom: 1);
}
