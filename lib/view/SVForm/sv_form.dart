import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/controller/WebTabBarController/web_tab_bar_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../controller/SVFormController/sv_form_controller.dart';
import '../../model/common_model.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/Clipper/clippers.dart';
import '../../widgets/web_header.dart';
import '../../widgets/web_tabbar.dart';

class SVForm extends GetView<SVFormController> {
  const SVForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return webDesign();
      },
    );
  }

  Widget webDesign() {
    return Scaffold(
      backgroundColor: ColorTheme.cThemeBg,
      body: Column(
        children: [
          const WebHeader(),
          const WebTabBar(
            currentScreen: CurrentScreen.siteVisit,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.tabs.length,
                        itemBuilder: (context, index) {
                          CommonModel obj = controller.tabs[index];
                          return Column(
                            children: [
                              clipperTab(
                                  name: obj.description ?? "",
                                  clipperPath: obj.code == "verify"
                                      ? GetStartedClipperPath()
                                      : PersonalDetailsClipperPath(),
                                  index: index),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Site Visit Form",
                      style: semiBoldTextStyle(size: 24),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      color: ColorTheme.cThemeCard,
                      child: Column(
                        children: [
                          Text(
                            controller.tabs[controller.tabIndex.value]
                                    .description ??
                                "",
                            style: semiBoldTextStyle(size: 18),
                          ),
                          const SizedBox(height: 40,),
                          Row(
                            children: [
                              Switch(
                                thumbColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {

                                  return ColorTheme.cWhite;
                                }),
                                activeColor: ColorTheme.cAppTheme,
                                inactiveTrackColor: ColorTheme.cLineColor,
                                value: false, onChanged: (value) {

                              },)
                            ],
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget clipperTab(
      {required String name,
      required CustomClipper<Path> clipperPath,
      required int index}) {
    return Obx(
      () => GestureDetector(
        onTap: () {},
        child: ClipPath(
          clipper: clipperPath,
          child: Container(
            height: 47,
            width: 270,
            alignment: Alignment.center,
            color: controller.tabIndex.value >= index
                ? ColorTheme.cPurple
                : ColorTheme.cThemeCard,
            child: Text(
              name,
              style: semiBoldTextStyle(size: 18, color: ColorTheme.cWhite),
            ),
          ),
        ),
      ),
    );
  }
}
