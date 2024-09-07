import 'package:flutter/material.dart';
import 'package:greapp/config/Helper/size_config.dart';
import 'package:greapp/config/utils/constant.dart';
import 'package:greapp/style/theme_color.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

BuildContext? _appLoaderContex;

appLoader(BuildContext context) {
  showGeneralDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    barrierColor: ColorTheme.cAppTheme.withOpacity(0.4),
    pageBuilder: (_, __, ___) {
      _appLoaderContex = context;
      return PopScope(
        canPop: true,
        child: isWeb
            ? Align(
                alignment: Alignment.center,
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0.w),
                    child: SizedBox.expand(
                        child: LoadingAnimationWidget.dotsTriangle(
                            color: ColorTheme.cAppTheme.withOpacity(0.7),
                            size: 60)),
                  ),
                ),
              )
            : Align(
                alignment: Alignment.center,
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(80.w / 2),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0.w),
                    child: SizedBox.expand(
                        child: LoadingAnimationWidget.dotsTriangle(
                            color: ColorTheme.cAppTheme, size: 70)),
                  ),
                ),
              ),
      );
    },
  );
}

//Align(
//           alignment: Alignment.center,
//           child: Container(
//             width: 80.w,
//             height: 80.w,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.85),
//               borderRadius: BorderRadius.circular(80.w / 2),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(15.0.w),
//               child: SizedBox.expand(
//                   child: Image.asset(AssetsString.aLoading,
//                       height: 70.w, width: 70.w)),
//             ),
//           ),
//         )
void removeAppLoader(BuildContext context) {
  if (_appLoaderContex != null) {
    Navigator.of(_appLoaderContex!).pop();
  }
}
