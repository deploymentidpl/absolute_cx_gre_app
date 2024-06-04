import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/appLoader.dart';
import '../../widgets/custom_dialogs.dart';
import '../dev/dev_helper.dart';

RxInt downloadValue = (0).obs;
CancelToken cancelToken = CancelToken();



contentBox(context,String path) {
  return Stack(
    children: <Widget>[
      Container(
        width: double.infinity,
        padding:
        EdgeInsets.only(left: 20.w, top: 65.w, right: 20.w, bottom: 20.w),
        margin: EdgeInsets.only(top: 30.w),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: ColorTheme.cAppTheme, width: 1),
          // boxShadow: [
          //   BoxShadow(color: Colors.black,offset: Offset(0,10),
          //       blurRadius: 10
          //   ),
          // ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Confirmation",
                style: /*TextStyle(fontSize: 22,color: Colors.black),*/
                regularTextStyle(color: Colors.black, size: 20.sp)),
            /*SizedBox(height: 5,),
              Divider(color: Colors.grey,thickness: 0.5,),*/
            const SizedBox(
              height: 15,
            ),
            Text(
              "Do you want to open file?",
              style: regularTextStyle(size: 14.sp,  color: Colors.grey),
              // TextStyle(fontSize: 14,color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 22.w,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  height: 50.h,
                  splashColor: ColorTheme.cTransparent,
                  highlightColor: ColorTheme.cTransparent,
                  focusColor:ColorTheme.cTransparent,
                  hoverColor: ColorTheme.cTransparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: ColorTheme.cAppTheme,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    size: 25.h,
                  ),
                  padding: const EdgeInsets.all(15),
                  shape: const CircleBorder(),
                ),
                SizedBox(
                  width: 20.w,
                ),
                MaterialButton(
                  height: 50.h,
                  splashColor: ColorTheme.cTransparent,
                  highlightColor: ColorTheme.cTransparent,
                  focusColor: ColorTheme.cTransparent,
                  hoverColor: ColorTheme.cTransparent,
                  onPressed: () {
                    Openfile(path);
                    //exit(0);
                  },
                  color: ColorTheme.cAppTheme,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.check,
                    size: 25.h,
                  ),
                  padding: const EdgeInsets.all(15),
                  shape: const CircleBorder(),
                )
              ],
            ),
          ],
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        child: /*CircleAvatar(
            backgroundColor: Colors.white,
            radius: Constants.avatarRadius,
            child: */
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: ColorTheme.cWhite,
              border:
              Border.all(color: ColorTheme.cAppTheme, width: 1),
              //borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              shape: BoxShape.circle,
            ),
            child: /*SvgPicture.asset(
                  "assets/icon/runr_white.svg",
                  // width: 70,
                  //height: 10,
                  height: 10,
                  fit: BoxFit.fill,
                  color: Colors.white,
                )*/
            Padding(
              padding: const EdgeInsets.all(0),
              child:
              // Image.asset(
              //     SSW_LOGO_PNG_NEW,
              //     height: 40.h,
              //     fit: BoxFit.cover,
              // )
              SvgPicture.asset(
                //todo: add logo
                "AssetsString.aLogo",
                // color: AppColors.APP_THEME_COLOR,
                height: 40.h,
                fit: BoxFit.cover,
              ),
              // Image.asset(APP_LOGO_PNG,fit: BoxFit.cover,height: 50,)
            )
          //),
        ),
      ),
    ],
  );
}

Future<void> Openfile(String path) async {
  devPrint("path * * $path");
  // Get.back();
  final _result = await OpenFilex.open(path);
  devPrint(_result.message);
}

RxBool isDownloaded = true.obs;


typedef void OnTap();

class DownloadFile {
  String? filename;
  String? fileString;
  BuildContext context;
  //BuildContext context;
  DownloadType? downloadType;
  String? url;

  DownloadFile({required this.context,this.fileString, this.filename, this.url, this.downloadType = DownloadType.URL}) {
    if (downloadType == DownloadType.BASE64) {
      assert(fileString!.isNotEmpty && filename!.isNotEmpty);
      _permissionHandler(_convertBase64ToFile);
    } else if (downloadType == DownloadType.URL) {
      if(url!.isNotEmpty) {
        _permissionHandler(_downloadFile);
        assert(url!.isNotEmpty);
      }else{
        showError("No document Found");
      }

    } else if (downloadType == DownloadType.GENERATE_CSV) {
      if(fileString!.isNotEmpty && filename!.isNotEmpty) {
        _permissionHandler(_generateStringDataToFile);
      }else{
        showError("No Download Data Found");
      }

    }
  }

  // String getfilename() {
  //   String filename = "";
  //  TimeOfDay now  = TimeOfDay.now();
  //  String time = now.format(context).replaceAll(" ", "");
  //   filename = "${identity}_${unitNo}_${customerId}_$time.pdf";
  //   return filename;
  // }

  Future<void> _convertBase64ToFile() async {
    devPrint("_convertBase64ToFile");
    try {
      Directory? appDocDir;
      if (Platform.isAndroid) {
        // appDocDir = await getDownloadsDirectory();
        appDocDir = await getApplicationDocumentsDirectory();
        // appDocDir = await DownloadsPathProvider.downloadsDirectory;
        // print(appDocDir!.path);
      } else if (Platform.isIOS) {
        appDocDir = await getApplicationDocumentsDirectory();
      }

      String storagePath = "${appDocDir!.path}/$filename";
      File file = File(storagePath);
      var bytes = const Base64Decoder().convert(fileString!.replaceAll("\n", ""));
      await file.writeAsBytes(bytes.buffer.asUint8List()).then((value) {});

      devPrint(file.path);
      devPrint("file.path base64444444");
      // OpenDownloadPdfDialog(file.path);
      OpenDownloadPdfDialog1(file.path);
      // contentBox(Get.context,file.path);
    } catch (e) {
      OpenAlertDilaogBox("Something Wrong");
      removeAppLoader(context);
    }
  }
  Future<void> _generateStringDataToFile() async {
    try {
      Directory? appDocDir;
      if (Platform.isAndroid) {
        appDocDir = await getApplicationDocumentsDirectory();
      } else if (Platform.isIOS) {
        appDocDir = await getApplicationDocumentsDirectory();
      }
      String storagePath = "${appDocDir!.path}/$filename";
      File file = File(storagePath);
      await file.writeAsString(fileString!);
      log("PATH ==> ${file.path}" );
      OpenDownloadPdfDialog1(file.path);

    } catch (e) {
      OpenAlertDilaogBox("Something Wrong");
      removeAppLoader(context);
    }
  }

  Future<bool> _downloadFile() async {
    appLoader(context);
    downloadValue.value = 0;
    Directory? appDocDir;
    if (Platform.isAndroid) {
      appDocDir = await getApplicationDocumentsDirectory();
      // appDocDir = await DownloadsPathProvider.downloadsDirectory;
      // appDocDir = await getDownloadsDirectory();

      devPrint(appDocDir.path);
    }
    else if (Platform.isIOS) {
      appDocDir = await getApplicationDocumentsDirectory();
    }
    String appDocPath = appDocDir!.path;
    final name = p.basename(url!);

    String path = "$appDocPath/$name";
    /*Dio dio = Dio();
    var response = await dio.download(url!, path);*/
    devPrint("path=====$path");
    devPrint(path);
    devPrint("path _downloadFile");
    /*if (response.statusCode == 200) {
      RemoveAppLoader(context);
      OpenDownloadPdfDialog1(path);
      // OpenDownloadPdfDialog(url!);
    } else {
      RemoveAppLoader(context);
      print(response.statusCode);
      print(response.statusMessage);
    }*/
    if (await File(path).exists()) {
      devPrint("File exists");
      isDownloaded.value = true;
      downloadValue.refresh();
      // contentBox(Get.context,path);
      // OpenDownloadPdfDialog(path);
      removeAppLoader(context);
      OpenDownloadPdfDialog1(path);
      return true;
    }
    else {
      devPrint("File don't exists");
      Dio dio = Dio();
      cancelToken = CancelToken();
      var response = await dio.download(
          url!, path, onReceiveProgress: (int sent, int total) {
        downloadValue.value = ((sent / total) * 100).round();
        downloadValue.refresh();
      }, cancelToken: cancelToken);

      devPrint(isDownloaded.value);
      devPrint("response.statusCode=======${response.statusCode}");
      if (response.statusCode == 200) {
        isDownloaded.value = true;
        isDownloaded.refresh();
        downloadValue.value = 100;
        downloadValue.refresh();
        // contentBox(Get.context,path);
        // OpenDownloadPdfDialog(path);
        removeAppLoader(context);
        OpenDownloadPdfDialog1(path);

        return true;
      } else {
        removeAppLoader(context);
        devPrint(response.statusCode);
        devPrint(response.statusMessage);
        downloadValue.value = 0;
        downloadValue.refresh();
        //ValidationMsg(response.statusMessage!);
      }
    }
    return false;
  }

  Future<void> _permissionHandler(Future<void> Function() function) async {
    devPrint("_permissionHandler");
    bool status = await Permission.storage.isGranted;

    if (status) {
      devPrint("status");
      devPrint(status);
      // further process
      function();
    } else if (await Permission.storage.isDenied) {
      devPrint("Permission.storage.isDenied");
      await Permission.storage.request().then((value) {
        if (value == PermissionStatus.granted) {
          devPrint("PermissionStatus.granted");
          // further process
          function();
        } else if (value == PermissionStatus.denied) {
          devPrint("PermissionStatus.denied");
          // dialog
          function();
          //OpenAlertDilaogBox("You can not download files");
        }
      });
      // function();
    }
  }

  Future<void> Openfile(String path) async {
     Get.back();
    final _result = await OpenFilex.open(path);
     showToastMessage(_result.message,MsgType.error);
    devPrint(_result.message);
  }

  OpenAlertDilaogBox(String message) {
    // OpenDialogBox(
    //     child: AlertDialogBox.messageShoeDialogWithCloseButton(
    //         message: message, status: Status.Successful,minHeight: 170));
    // Get.dialog(AlertDialogBox(
    //     message: message,
    //     onTap: () => Get.back(),
    //     textStyle: TextStyles.textStyleDark14(AppColors.WHITE),
    //     buttonName: "OK"));
  }

  Future<void> openShowBottomSheet(BuildContext  ctext) async{

  }

  OpenDownloadPdfDialog1(String path) {

    return
       showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding:
              EdgeInsets.only(left: 20.w, top: 65.w, right: 20.w, bottom: 20.w),
              margin: EdgeInsets.only(top: 30.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: ColorTheme.cAppTheme, width: 1),
                // boxShadow: [
                //   BoxShadow(color: Colors.black,offset: Offset(0,10),
                //       blurRadius: 10
                //   ),
                // ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Text("Confirmation",
                  //     style: /*TextStyle(fontSize: 22,color: Colors.black),*/
                  //     regularTextStyle(txtColor: Colors.black, fontSize: 20.sp)),
                  /*SizedBox(height: 5,),
              Divider(color: Colors.grey,thickness: 0.5,),*/
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Do you want to open file?",
                    style: regularTextStyle(size: 14.sp, color: Colors.grey),
                    // TextStyle(fontSize: 14,color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 22.w,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        height: 50.h,
                        splashColor: ColorTheme.cTransparent,
                        highlightColor:  ColorTheme.cTransparent,
                        focusColor:  ColorTheme.cTransparent,
                        hoverColor:  ColorTheme.cTransparent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color:  ColorTheme.cAppTheme,
                        textColor: Colors.white,
                        child: Icon(
                          Icons.close,
                          size: 25.h,
                        ),
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      MaterialButton(
                        height: 50.h,
                        splashColor:  ColorTheme.cTransparent,
                        highlightColor:  ColorTheme.cTransparent,
                        focusColor:  ColorTheme.cTransparent,
                        hoverColor:  ColorTheme.cTransparent,
                        onPressed: () {
                          Openfile(path);
                          //exit(0);
                        },
                        color:  ColorTheme.cAppTheme,
                        textColor: Colors.white,
                        child: Icon(
                          Icons.check,
                          size: 25.h,
                        ),
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: /*CircleAvatar(
            backgroundColor: Colors.white,
            radius: Constants.avatarRadius,
            child: */
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20.w),
                  decoration:  BoxDecoration(
                    color:  ColorTheme.cAppTheme,
                    border:
                    Border.all(color:  ColorTheme.cAppTheme, width: 1),
                    //borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                    shape: BoxShape.circle,
                  ),
                  child: /*SvgPicture.asset(
                  "assets/icon/runr_white.svg",
                  // width: 70,
                  //height: 10,
                  height: 10,
                  fit: BoxFit.fill,
                  color: Colors.white,
                )*/
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child:
                    // Image.asset(
                    //     SSW_LOGO_PNG_NEW,
                    //     height: 40.h,
                    //     fit: BoxFit.cover,
                    // )
                    SvgPicture.asset(
                      //todo: add string
                      "AssetsString.aLogo",
                      // color: AppColors.APP_THEME_COLOR,
                      height: 40.h,
                      fit: BoxFit.cover,
                    ),
                    // Image.asset(APP_LOGO_PNG,fit: BoxFit.cover,height: 50,)
                  )
                //),
              ),
            ),
          ],
        ),
      ),
    );
  }



}




enum DownloadType { URL, BASE64,GENERATE_CSV }
