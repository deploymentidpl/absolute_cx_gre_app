import 'package:get/get.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/view/KnowledgebaseScreen/knowledgebase_screen.dart';
import 'package:greapp/view/SVForm/sv_form.dart';
import 'package:greapp/view/no_page_found.dart';

import '../global_screen_bindings.dart';
import '../view/Dashboard/dashboard.dart';
import '../view/HomeScreen/home_screen.dart';
import '../view/ProfileScreen/profile_screen.dart';
import '../view/QRScreen/qr_screen.dart';
import '../view/QrCodeScanScreen/qr_code_scan_screen.dart';
import '../view/splash_screen/splash_screen.dart';

class RouteGenerator {
  static List<GetPage<dynamic>> generate() {
    return <GetPage<dynamic>>[
      GetPage(
        name: RouteNames.kNoPageFound,
        page: () => const NoPageFound(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kSplashScreenRoute,
        page: () => const SplashScreen(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kDashboard,
        page: () => const DashboardScreen(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kSVForm,
        page: () => const SVForm(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kKnowledgebase,
        page: () => const KnowledgebaseScreen(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kQRScreen,
        page: () =>   QRScreen(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kHomeScreen,
        page: () =>   HomeScreen(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kProfileScreen,
        page: () =>   ProfileScreen(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kQRScan,
        page: () =>   const QrCodeScanScreen(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
    ];
  }
}

Transition navigationTransaction = Transition.fadeIn;

// class NavigatorMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     if (Settings.isUserLogin && (route == RouteNames.kLoginScreen || route == RouteNames.kAdminScreen)) {
//       return const RouteSettings(name: RouteNames.kDashboard);
//     } else if (!Settings.isUserLogin && !(route == RouteNames.kLoginScreen || route == RouteNames.kAdminScreen)) {
//       return const RouteSettings(name: RouteNames.kLoginScreen);
//     }
//     return null;
//
//     ///Write any navigetion condition and return route
//     // return RouteSettings(name: route);
//   }
// }
