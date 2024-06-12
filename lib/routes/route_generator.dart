import 'package:get/get.dart';
import 'package:greapp/routes/route_name.dart';
import 'package:greapp/view/KnowledgebaseScreen/knowledgebase_screen.dart';
import 'package:greapp/view/SVForm/sv_form.dart';
import 'package:greapp/view/no_page_found.dart';

import '../global_screen_bindings.dart';
import '../view/Dashboard/dashboard.dart';
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
        page: () =>   SVForm(),
        binding: GlobalScreenBindings(),
        transition: navigationTransaction,
      ),
      GetPage(
        name: RouteNames.kKnowledgebase,
        page: () =>   KnowledgebaseScreen(),
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
