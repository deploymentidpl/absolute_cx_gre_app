import 'package:flutter/material.dart';
import 'package:greapp/config/Helper/size_config.dart';


BuildContext? _appLoaderContex;

appLoader(BuildContext context) {
  showGeneralDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    pageBuilder: (_, __, ___) {
      _appLoaderContex = context;
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.white.withOpacity(0.85),
            /*width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(80.w / 2),
            ),*/
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox.expand(
                  child: Image.asset(
                      //todo: add string
                      "loadingGIF", height: 70.w, width: 70.w)),
            ),
          ),
        ),
      );
    },
  );
}

void removeAppLoader(BuildContext context) {
  if (_appLoaderContex != null) {
    Navigator.of(_appLoaderContex!).pop();
  }
  // Navigator.of(context, rootNavigator: false).pop('dialog');
}
