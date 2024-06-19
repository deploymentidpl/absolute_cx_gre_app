import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/routes/route_generator.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/style/theme_color.dart';
import 'package:greapp/view/layout_templeat.dart';
import 'package:greapp/view/no_page_found.dart';
import 'package:url_strategy/url_strategy.dart';

import 'components/scroll_behaviour.dart';
import 'global_screen_bindings.dart';

Rx<String> commonSelectedProject = "".obs;
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GetMaterialApp(
        title: 'Absolute Cx',
        debugShowCheckedModeBanner: false,
        initialBinding: GlobalScreenBindings(),
        getPages: RouteGenerator.generate(),
        unknownRoute: GetPage(
          name: RouteNames.kNoPageFound,
          transition: navigationTransaction,
          page: () => const NoPageFound(),
        ),
        builder: (context, child) => LayoutTemplate(child: child!),
        scrollBehavior: MyCustomScrollBehavior(),
        initialRoute: RouteNames.kSplashScreenRoute,
        theme: ThemeData(
          checkboxTheme: CheckboxThemeData(
            side: BorderSide(color: ColorTheme.cPurple, width: 2),
          ),
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
