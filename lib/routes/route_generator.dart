import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/config/shared_pref.dart';
import 'package:greapp/config/utils/preference_controller.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/view/KnowledgebaseScreen/knowledgebase_screen.dart';
import 'package:greapp/view/LoginScreen/check_in_screen.dart';
import 'package:greapp/view/LoginScreen/login_screen.dart';
import 'package:greapp/view/SVForm/sv_form.dart';
import 'package:greapp/view/no_page_found.dart';

import '../global_screen_bindings.dart';
import '../main.dart';
import '../view/Dashboard/dashboard.dart';
import '../view/HomeScreen/home_screen.dart';
import '../view/ProfileScreen/profile_screen.dart';
import '../view/QRScreen/qr_screen.dart';
import '../view/QrCodeScanScreen/qr_code_scan_screen.dart';
import '../view/no_internet_page.dart';
import '../view/splash_screen/splash_screen.dart';

class RouteGenerator {
  static List<GetPage<dynamic>> generate() {
    return <GetPage<dynamic>>[
      GetPage(
        name: RouteNames.kNoPageFound,
        page: () => const NoPageFound(),
        binding: GlobalScreenBindings(),
        middlewares: [NavigatorMiddleware()],
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kNoInterNet,
        page: () => const NoInterNetConnection(),
        binding: GlobalScreenBindings(),
        middlewares: [NavigatorMiddleware()],
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kSplashScreenRoute,
        page: () => const SplashScreen(),
        middlewares: [NavigatorMiddleware()],
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kLogin,
        page: () => const LoginScreen(),
        binding: GlobalScreenBindings(),
        middlewares: [NavigatorMiddleware()],
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kLock,
        page: () => const CheckInScreen(),
        binding: GlobalScreenBindings(),
        middlewares: [NavigatorMiddleware()],
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kDashboard,
        page: () => const DashboardScreen(),
        binding: GlobalScreenBindings(),
        middlewares: [NavigatorMiddleware()],
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kSVForm,
        page: () => const SVForm(),
        binding: GlobalScreenBindings(),
        middlewares: [NavigatorMiddleware()],
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kKnowledgebase,
        page: () => const KnowledgebaseScreen(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
        middlewares: [NavigatorMiddleware()],
      ),
      GetPage(
        name: RouteNames.kQRScreen,
        page: () => QRScreen(),
        binding: GlobalScreenBindings(),
        middlewares: [NavigatorMiddleware()],
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kHomeScreen,
        page: () => HomeScreen(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
        middlewares: [NavigatorMiddleware()],
      ),
      GetPage(
        name: RouteNames.kProfileScreen,
        page: () => ProfileScreen(),
        binding: GlobalScreenBindings(),
        middlewares: [NavigatorMiddleware()],
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kQRScan,
        page: () => const QrCodeScanScreen(),
        binding: GlobalScreenBindings(),
        middlewares: [NavigatorMiddleware()],
        transition: navigationTransaction,
      ),
    ];
  }
}

Transition navigationTransaction = Transition.fadeIn;

class NavigatorMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    bool isUserLocked = PreferenceController.getBool(SharedPref.isUserLocked);
    bool isUserLogin = PreferenceController.getBool(SharedPref.isUserLogin);
    bool isProjectSelected = (kSelectedProject.value.id == "");

    /// if user is logged in and trying to go to login again
    /// redirect to dashboard
    if (isUserLogin && (route == RouteNames.kLogin)) {
      return const RouteSettings(name: RouteNames.kDashboard);
    }

    ///if user is login but project is not selected disable redirect
    ///and keep them on dashboard , ignore condition if selected rout is splash
    else if (isUserLogin &&
        isProjectSelected &&
        (route != RouteNames.kDashboard)&&
        (route != RouteNames.kSplashScreenRoute)) {
      return const RouteSettings(name: RouteNames.kDashboard);
    }

    ///if user is not logged in and trying to access any other page
    ///redirect to login screen
    else if (!isUserLogin && !(route == RouteNames.kLogin)) {
      return const RouteSettings(name: RouteNames.kLogin);
    }else if (isUserLogin && isUserLocked && !(route == RouteNames.kLock)) {
      return const RouteSettings(name: RouteNames.kLock);
    }

    ///if no issue is found let them visit selected screen
    return null;
  }
}
