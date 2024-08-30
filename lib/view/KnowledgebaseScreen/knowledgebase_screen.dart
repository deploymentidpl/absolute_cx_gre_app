import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/utils/constant.dart';
 import 'package:greapp/style/assets_string.dart';
import 'package:greapp/widgets/web_header.dart';
import 'package:greapp/widgets/web_tabbar.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../config/Helper/function.dart';
import '../../controller/KnowledgeBaseController/knowledge_base_controller.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/Drawer/app_drawer.dart';
import '../../widgets/app_header.dart';

class KnowledgebaseScreen extends GetView<KnowledgeBaseController> {
  const KnowledgebaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        setAppType(sizingInformation);
        return isWeb ? webDesign() : appDesign();
      },
    );
  }

  Widget appDesign() {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
      backgroundColor: ColorTheme.cThemeBg,
      key: scaffoldKey,
      drawer: AppDrawer(
        alias: "knowledgebase",
        scaffoldState: scaffoldKey.currentState,
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              scaffoldState: scaffoldKey,
            ), 
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(() => ListView.builder(
                      itemBuilder: (context, index) => videoCard(index: index),
                      itemCount: controller.knowledgeBaseList.length,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget webDesign() {
    return Column(
      children: [
        const WebHeader(),
        const WebTabBar(currentScreen: CurrentScreen.knowledgeBase),
        Expanded(
          child: Scaffold(
            backgroundColor: ColorTheme.cThemeBg,
            appBar: AppBar(
              backgroundColor: ColorTheme.cThemeCard,
              automaticallyImplyLeading: false,
              leading: kIsWeb
                  ? null
                  : GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: SvgPicture.asset(
                            AssetsString.aBackArrow,
                            height: 30,
                            colorFilter:   ColorFilter.mode(
                                ColorTheme.cWhite, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
              titleSpacing: 10,
              title: Obx(() => controller.isSearch.value
                  ? searchView()
                  : Text(
                      "Knowledgebase",
                      style: semiBoldTextStyle(
                        size: 18,
                        color: ColorTheme.cWhite,
                      ),
                    )),
              actions: [
                Obx(
                  () => !controller.isSearch.value
                      ? GestureDetector(
                          onTap: () {
                            controller.isSearch.value = true;
                          },
                          child: Container(
                            padding: const EdgeInsets.only(right: 20),
                            color: Colors.transparent,
                            child:   Center(
                                child: Icon(
                              Icons.search,
                              color: ColorTheme.cWhite,
                            )),
                          ),
                        )
                      : const SizedBox(),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(() => ListView.builder(
                    itemBuilder: (context, index) => videoCard(index: index),
                    itemCount: controller.knowledgeBaseList.length,
                  )),
            ),
          ),
        ),
      ],
    );
  }

  Widget videoCard({required int index}) {
    return GestureDetector(
      onTap: () async {
        try {
          // appLoader(controller.context);
          if (await canLaunchUrlString(
              controller.knowledgeBaseList[index].url)) {
            launchUrlString(controller.knowledgeBaseList[index].url);
          }
          // if (controller.context.mounted) {
          //   removeAppLoader(controller.context);
          // }
        } catch (error) {
          // if (controller.context.mounted) {
          //   removeAppLoader(controller.context);
          // }
        }
      },
      child: Container(
        color: ColorTheme.cThemeCard,
        margin: const EdgeInsets.only(bottom: 10),
        height: 100,
        child: Row(
          children: [
            /*   kIsWeb
                ? AspectRatio(
              aspectRatio: 16/9,
                  child: SizedBox(
                                height: 100,
                    child: HtmlElementView(
                        viewType: controller
                            .getImage(getVideoUrlFromLink(controller.knowledgebaseList[index].url))),
                  ),
                )
                :*/
            CachedNetworkImage(
              imageUrl:
                  getVideoUrlFromLink(controller.knowledgeBaseList[index].url),
              fit: BoxFit.fitHeight,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.knowledgeBaseList[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: semiBoldTextStyle(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    controller.knowledgeBaseList[index].description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: mediumTextStyle(size: 10),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget searchView() {
    return TextFormField(
      style: regularTextStyle(color: ColorTheme.cFontWhite, size: 16),
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          hintText: "Search",
          hintStyle: regularTextStyle(color: ColorTheme.cFontWhite, size: 16),
          suffixIcon: GestureDetector(
            onTap: () {
              controller.isSearch.value = false;
            },
            child:   Icon(
              Icons.close,
              color: ColorTheme.cWhite,
            ),
          )),
    );
  }
}
