import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/function.dart';
import 'package:greapp/routes/route_generator.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/style/theme_color.dart';
import 'package:greapp/view/layout_templeat.dart';
import 'package:greapp/view/no_page_found.dart';
import 'package:url_strategy/url_strategy.dart';

import 'components/scroll_behaviour.dart';
import 'config/utils/connectivity_service.dart';
import 'config/utils/preference_controller.dart';
import 'controller/FirebaseApi/firebase_api.dart';
import 'global_screen_bindings.dart';
import 'model/ProjectListModel/nearby_projct_list_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Rx<NearbyProjectModel> kSelectedProject = NearbyProjectModel().obs;
EventBus eventBus = EventBus();

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      setPathUrlStrategy();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      if (!kIsWeb) {
        // Pass all uncaught "fatal" errors from the framework to Crashlytics
        FlutterError.onError =
            FirebaseCrashlytics.instance.recordFlutterFatalError;
        // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
      }

      /// initialize ConnectivityService to detect internet connection
      Get.put(ConnectivityService());
      await PreferenceController.initPreference();
      await FirebaseApi().initNotification();
      runApp(const MyApp());
    },
    (error, stack) {
      devPrint(error);
      devPrint(stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
          side: BorderSide(color: ColorTheme.cAppTheme, width: 2),
        ),
        fontFamily: 'Montserrat',
      ),
    );
  }
}
