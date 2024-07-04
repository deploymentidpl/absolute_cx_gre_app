/*import 'dart:html' as html;*/

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/MenuModel/menu_model.dart';
import '../../routes/route_name.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/custom_dialogs.dart';
import '../shared_pref.dart';
import '../utils/api_constant.dart';
import '../utils/constant.dart';
import '../utils/preference_controller.dart';
import 'api_response.dart';
import 'deviceData.dart';

getTodayDate() {
  return DateFormat('yyyy-MM-dd').format(DateTime.now());
}

String capitalizeEachWord(String text) {
  List<String> words = text.split(' ');
  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      // If the word is in uppercase, convert it to lowercase first
      String lowercaseWord = words[i].toLowerCase();
      // Capitalize the first letter of each word
      words[i] = lowercaseWord[0].toUpperCase() + lowercaseWord.substring(1);
    }
  }
  return words.join(' ');
}

/*
void openFileInNewWindow(String url, DownloadType downloadType) {
  html.AnchorElement anchorElement = html.AnchorElement(href: url)
    ..setAttribute("target", "_blank")
    ..click();
}*/

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class CustomTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Capitalize the first letter of each word
    newText = capitalizeEachWord(newText);

    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
      composing: newValue.composing,
    );
  }
}

String? emailValidation(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter an email address";
  }

  bool emailValid = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  ).hasMatch(value);

  if (!emailValid || value.contains('..')) {
    return "Please enter a valid email address";
  }

  return null;
}

String getTimeZoneOffset() {
  int start = timezone.indexOf('+');
  int end = timezone.indexOf(')');

  if (start != -1 && end != -1 && end > start) {
    String offset = timezone.substring(start, end);
    return offset.trim();
  } else {
    return "Time zone offset not found.";
  }
}

String formatLocalTime(
    {String timeZoneOffset = '+05:30', required String utcTime}) {
  try {
    if (timezone != "" && timezone != "null") {
      timeZoneOffset = getTimeZoneOffset();
    } else {
      timeZoneOffset = '+05:30';
    }

    if (utcTime.isEmpty || utcTime.length <= 10) {
      if (utcTime.isNotEmpty && utcTime.length <= 10) {
        DateFormat inputFormat = DateFormat('dd-MM-yyyy');
        DateTime date = inputFormat.parse(utcTime);
        DateFormat outputFormat = DateFormat('dd-MM-yyyy');
        String formattedDate = outputFormat.format(date);
        return formattedDate;
      }
      return "";
    }

    DateTime dateTime = DateTime.parse(utcTime);

    // Extract the sign, hours, and minutes from the time zone offset
    String sign = timeZoneOffset.substring(0, 1);
    // int hours = int.parse(timeZoneOffset.substring(1, 3));
    // int minutes = int.parse(timeZoneOffset.substring(4));
    List<String> offsetParts = timeZoneOffset.split(':');
    int hours = int.parse(offsetParts[0]);
    int minutes = int.parse(offsetParts[1]);
    // Calculate the offset duration
    Duration offset = Duration(hours: hours, minutes: minutes);
    if (sign == '-') {
      offset = -offset;
    }

    // Apply the offset to the UTC time
    DateTime localTime = dateTime.add(offset);

    // Format the local time as a string
    String formattedLocalTime =
        DateFormat('EEE, MMM d, yyyy, hh:mm a').format(localTime);

    //print(formattedLocalTime);
    //print("formattedLocalTime");
    return formattedLocalTime;
  } catch (e) {
    if (kDebugMode) {
      print("custom date function exception-$e");
    }
    return "";
  }
}

String convertToCustomFormat(String utcTimestamp) {
  DateTime utcDateTime = DateTime.parse(utcTimestamp);
  DateTime localDateTime = utcDateTime.toLocal();
  String formattedDateTime =
      DateFormat("E, MMM d, yyyy h:mm a").format(localDateTime);

  return formattedDateTime;
}

String dateFormatChange(d) {
  var inputFormat = DateFormat('E, MMM d, yyyy, h:mm a');
  var inputDate = inputFormat.parse(d);
  var outputFormat = DateFormat('d MMM yyyy');
  return outputFormat.format(inputDate);
}

String followUpdateFormat(d) {
  var inputFormat = DateFormat('EEE, MMM d, yyyy h:mm a');
  var inputDate = inputFormat.parse(d);
  var outputFormat = DateFormat('MMM d, yyyy hh:mm a');
  return outputFormat.format(inputDate);
}

String? validation(String? value, String message) {
  if (value!.trim().isEmpty) {
    return message;
  } else {
    return null;
  }
}

void navigateOnAlias(MenuModel obj) {
  if (obj.alias == "scan") {
    Get.toNamed(RouteNames.kQRScan);
  } else if (obj.alias == "knowledgebase") {
    Get.toNamed(RouteNames.kKnowledgebase);
  } else if (obj.alias == "logout") {
    checkOut().then((value) {
      if(value){

        Get.toNamed(RouteNames.kLogin);
      }else{

        showError("Logout Failed",);
      }
    });
  }
}

Future<bool> checkOut() async {
  try {
    Map<String, dynamic> deviceInfo = await DeviceData().getDeviceData();

    Map<String, dynamic> data = {
      "employee_id":  PreferenceController.getString(
    SharedPref.employeeID ),
      "device_info": deviceInfo
    };


    ApiResponse response = ApiResponse(
        data: data,
        baseUrl: Api.apiLogout,
        apiHeaderType: ApiHeaderType.content,
        apiMethod: ApiMethod.post);
    Map<String, dynamic> responseData = await response.getResponse() ?? {};


    if (responseData['success'] == true) {
      return true;
    } else {
      return false;
    }
  } catch (error, stack) {
    log(error.toString());
    log(stack.toString());
    return false;
  }
}
urlLauncher(String url) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

String formatDateTimeFromUtc(String time) {
  try {
    return DateFormat("hh:mm a")
        .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(time));
  } catch (e) {
    return DateFormat("hh:mm a").format(DateTime.now());
  }
}

String dateDecode(DateTime date) {
  var dateFormat = DateFormat("dd MMMM, yyyy").format(date);
  return dateFormat;
}

String convertDateMonthTime(String date) {
  String utcDate = formatLocalTime(utcTime: date);
  DateTime dt = DateFormat('EEE, MMM d, yyyy, hh:mm a').parse(utcDate);
  var dateFormat = DateFormat("dd MMM").format(dt);
  var timeFormat = DateFormat("hh:mm a").format(dt);

  return "$dateFormat @ $timeFormat";
}

String convertDateInDDMMM(String date) {
  String utcDate = formatLocalTime(utcTime: date);
  DateTime dt = DateFormat('EEE, MMM d, yyyy, hh:mm a').parse(utcDate);
  var dateFormat = DateFormat("dd MMM").format(dt);

  return dateFormat;
}

String convertDate(String date) {
  String utcDate = formatLocalTime(utcTime: date);
  DateTime dt = DateFormat('EEE, MMM d, yyyy, hh:mm a').parse(utcDate);
  var dateFormat = DateFormat("MMM dd, yyyy").format(dt);

  return dateFormat;
}

String timeDecode(TimeOfDay time) {
  var timeFormat =
      "${time.hourOfPeriod}:${time.minute} ${time.period.name.toUpperCase()}";
  var dateFormat = DateFormat("hh:mm a").parse(timeFormat);
  var parseTime = DateFormat("hh:mm a").format(dateFormat);
  return parseTime;
}

  Color getBlockUnitColorBasedOnStatus({required String status}) {

Color statusColor = ColorTheme.cAppTheme;
switch (status.toUpperCase()) {
case 'AVAILABLE':
statusColor = ColorTheme.unitAvailableColor;
break;
case 'WRONG ENTRY':
statusColor = ColorTheme.unitWrongEntryColor;
break;
case 'NOT AVAILABLE':
statusColor = ColorTheme.unitNotAvailableColor;
break;
case 'FLOOR SPACE':
statusColor = ColorTheme.unitFloorSpaceColor;
break;
case 'WITHDRAWN BY MGMT':
statusColor = ColorTheme.unitWithdrawColor;
break;
case 'CANCELLATION PROCESS':
statusColor = ColorTheme.unitCancellationProcessColor;
break;
case 'HOLD':
statusColor = ColorTheme.unitHoldColor;
break;
case 'PROJECTED':
statusColor = ColorTheme.unitProjectedColor;
break;
case 'SOLD IN LEGACY':
statusColor = ColorTheme.unitDoldLegacyColor;
break;
case 'CANCELLED':
statusColor = ColorTheme.unitCancelledColor;
break;
case 'SOLD':
statusColor = ColorTheme.unitSoldColor;
break;
case 'ACTIVE FOR SALE':
statusColor = ColorTheme.unitActiveForSaleColor;
break;
case 'BLOCKED':
statusColor = ColorTheme.unitBlockedColor;
break;
case 'BLOCK COMPLETELY':
statusColor = ColorTheme.unitBlockedCompletelyColor;
break;
}
return statusColor;
}

String formatDate(String date, int type) {
  // String utcDate = formatLocalTime(utcTime: date);
  DateTime dt = DateTime.parse(date);

  String formatString;
  switch (type) {
    case 0:
      formatString = "hh:mm";
      break;case 1:
      formatString = "hh:mm a";
      break;
    case 2:
      formatString = "MMM dd, yyyy";
      break;
    default:
      formatString = "EEE, MMM d, yyyy, hh:mm a";
      break;
  }

  var formattedDate = DateFormat(formatString).format(dt);

  return formattedDate;
}

String convertDateTime({required String dateTimeString, bool? isReturnTime}) {
  String value = "";
  if (dateTimeString.isNotEmpty) {
    DateFormat formatter = DateFormat('E, MMM d, yyyy, h:mm a');
    DateTime dateTime = formatter.parse(dateTimeString);

    if (isReturnTime == true) {
      DateFormat timeFormatter = DateFormat('hh:mm aa');
      value = timeFormatter.format(dateTime);
      /* var timeFormat = DateFormat("jm").format(dateTime);
    var amPmFormat = DateFormat("a").format(dateTime);

    value = timeFormat; //  $amPmFormat
    print("Date: $dateTime Time: $timeFormat $amPmFormat");*/
    } else {
      DateFormat dateFormatter = DateFormat('E, MMM d, yyyy');
      value = dateFormatter.format(dateTime);
    }
  }
  return value;
}
void exitApp() {
  SystemChannels.platform.invokeMethod<void>(
    'SystemNavigator.pop',
  );
}
validationMsg(String messageText) {
  Get.snackbar(
    "Message!",
    "",
    onTap: (_) => {},
    borderRadius: 5,
    borderColor: ColorTheme.cRed,
    borderWidth: 1,
    leftBarIndicatorColor: ColorTheme.cRed,
    progressIndicatorBackgroundColor: ColorTheme.cRed,
    progressIndicatorValueColor:
        const AlwaysStoppedAnimation<Color>(ColorTheme.cGrey),
    backgroundColor: ColorTheme.cWhite,
    colorText: ColorTheme.cBlack,
    titleText: Text("Message", style: boldTextStyle(size: 15)),
    messageText: Text(messageText,
        style: semiBoldTextStyle(size: 16, color: ColorTheme.cBlack)),
    duration: const Duration(seconds: 10),
    animationDuration: const Duration(milliseconds: 800),
    snackPosition: SnackPosition.BOTTOM,
    dismissDirection: DismissDirection.startToEnd,
    isDismissible: true,
    margin: EdgeInsets.only(bottom: 20.h, left: 5.w, right: 5.w),
    icon: Container(
      width: 20.w,
      height: 20.h,
      decoration:
          const BoxDecoration(color: ColorTheme.cRed, shape: BoxShape.circle),
      child: Center(
          child: Icon(
        Icons.error_outline_rounded,
        size: 15.w,
        color: ColorTheme.cWhite,
      )),
    ),
  );
}

String svTimeStatus(
    {required String utcSVDateTime, required String utcScanDateTime}) {
  String status = "";
  String timeDiff = "";
  bool negativeDiff = false;
  Duration diff = Duration.zero;
  DateTime scanDateTime = DateTime.now();
  DateFormat localFormatter = DateFormat('E, MMM d, yyyy, h:mm a');
  DateTime dateTime =
      localFormatter.parse(formatLocalTime(utcTime: utcSVDateTime));

  //DateTime dateTime = DateTime.parse(utcSVDateTime);
  DateTime now = DateTime.now();

  if (utcScanDateTime.isNotEmpty || utcScanDateTime != "") {
    //scanDateTime = DateTime.parse(utcScanDateTime);
    scanDateTime =
        localFormatter.parse(formatLocalTime(utcTime: utcScanDateTime));
    diff = dateTime.difference(scanDateTime);
  } else {
    diff = dateTime.difference(now);
  }

  if (diff.isNegative) {
    negativeDiff = true;
    diff = diff * -1;
  }

  if (diff.inHours > 0) {
    timeDiff = "${diff.inHours} Hr";
  }

  if (diff.inMinutes.remainder(60) > 0) {
    timeDiff = "$timeDiff ${diff.inMinutes.remainder(60)} Min";
  }
  /*if(diff.inSeconds%60 > 59){
    timeDiff =  "$timeDiff ${diff.inSeconds.remainder(60)} Sec";
  }*/

  if (timeDiff.isNotEmpty) {
    if (negativeDiff == true) {
      status = "Late by";
    } else {
      if (utcScanDateTime != "" && utcScanDateTime.isNotEmpty) {
        status = "Early by";
      } else {
        status = "Expected in";
      }
    }
    status = "$status $timeDiff";
  }
  return status;
}

String unClaimSvTimeStatus({required String utcScanDateTime}) {
  String status = "";
  String timeDiff = "";

  Duration diff = Duration.zero;
  DateTime scanDateTime = DateTime.now();

  DateFormat localFormatter = DateFormat('E, MMM d, yyyy, h:mm a');

  DateTime now = DateTime.now();

  if (utcScanDateTime.isNotEmpty || utcScanDateTime != "") {
    scanDateTime =
        localFormatter.parse(formatLocalTime(utcTime: utcScanDateTime));
    diff = now.difference(scanDateTime);
  }

  if (diff.isNegative) {
    diff = diff * -1;
  }
  if (diff.inHours > 0) {
    timeDiff = "${diff.inHours} Hr";
  }
  if (diff.inMinutes.remainder(60) > 0) {
    timeDiff = "$timeDiff ${diff.inMinutes.remainder(60)} Min";
  }
  if (timeDiff.isNotEmpty) {
    if (utcScanDateTime != "" && utcScanDateTime.isNotEmpty) {
      status = "Wait Duration ";
    }
    status = "$status $timeDiff";
  }
  return status;
}

String formatSVTime(
    {String timeZoneOffset = '+05:30',
    required String utcTime,
    bool? getHr,
    bool? getMin,
    bool? getSec,
    bool? getDays}) {
  String value = "";
  try {
    if (utcTime.isEmpty || utcTime.length <= 10) {
      return "";
    }

    DateTime dateTime = DateTime.parse(utcTime);

    DateTime now = DateTime.now();

    Duration diff = now.difference(dateTime);

    if (getDays == true) {
      value = diff.inDays.toString();
    } else if (getHr == true) {
      value = diff.inHours.toString();
    } else if (getMin == true) {
      value = (diff.inMinutes % 60).toString();
    } else if (getSec == true) {
      value = (diff.inSeconds % 60).toString();
    }

    return value;
  } catch (e) {
    log("custom date function exception-------$e");
    return "";
  }
}

String getDayAndDate(String dateTimeString, {bool isFullDate = true}) {
  String value = "";
  if (dateTimeString.isNotEmpty) {
    DateFormat dateFormatter =
        isFullDate ? DateFormat('dd-MM-yyyy') : DateFormat('dd MMM');

    DateTime utcDateTime = DateTime.parse(dateTimeString).toLocal();
    String utcDateStr = dateFormatter.format(utcDateTime);

    if (utcDateStr == dateFormatter.format(DateTime.now())) {
      value = "Today";
    } else if (utcDateStr ==
        dateFormatter
            .format(DateTime.now().subtract(const Duration(days: 1)))) {
      value = "Yesterday";
    } else {
      value = utcDateStr;
    }
  }
  return value;
}

String getVideoUrlFromLink(String link) {
  return "https://img.youtube.com/vi/${convertUrlToId(link) ?? ""}/0.jpg";
  // return "https://i3.ytimg.com/vi/${convertUrlToId(link) ?? ""}/sddefault.jpg";
  // return "https://i.ytimg.com/vi/SQssRqqE0yo/hqdefault.jpg";
}

String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
  if (!url.contains("http") && (url.length == 11)) return url;
  if (trimWhitespaces) url = url.trim();

  for (var exp in [
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ]) {
    Match? match = exp.firstMatch(url);
    if (match != null && match.groupCount >= 1) return match.group(1);
  }

  return null;
}

String maskMobile(String text) {
  int digitsToShow = 4;

  if (text.length <= digitsToShow) {
    return text;
  }

  String maskedDigits = '*' * (text.length - digitsToShow);
  //String visibleDigits = text.substring(0, digitsToShow);
  //return visibleDigits + maskedDigits;

  String visibleDigits =
      text.substring(text.length - digitsToShow, text.length);
  return maskedDigits + visibleDigits;
}

String convertChatDateTime(String dateTimeString) {
  String value = "";

  DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
  DateFormat timeFormatter = DateFormat('hh:mm a');

  DateTime utcDateTime = DateTime.parse(dateTimeString).toLocal();
  String utcDateStr = dateFormatter.format(utcDateTime);
  String nowDateStr = dateFormatter.format(DateTime.now());

  if (utcDateStr == nowDateStr) {
    value = timeFormatter.format(utcDateTime);
  } else {
    value = utcDateStr;
  }

  return value;
}

extension CapExtension on String {
  String get titleCase => split(' ')
      .map((word) =>
          word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : "")
      .join(' ');
}

Widget horizontalDivider({double? width, double? height, Color? color}) {
  return Container(
    width: width ?? Get.width,
    height: height ?? 0,
    color: color,
  );
}

Future<(Uint8List, String)> pickFile(
    {int defaultFileSizeINKB = 4096,
    String dialogTitle = 'Select file',
    AllowedFileTypes fileType = AllowedFileTypes.any}) async {
  List<String> allowedFileType = [
    'jpg',
    'jpeg',
    'png',
    'pdf',
    'docx',
    'doc',
    'pdf',
    'heic'
  ];
  if (fileType == AllowedFileTypes.image) {
    allowedFileType = ['jpg', 'jpeg', 'png', 'heic'];
  } else if (fileType == AllowedFileTypes.document) {
    allowedFileType = ['pdf', 'docx', 'doc'];
  }

  final FilePickerResult? selectedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      dialogTitle: dialogTitle,
      type: FileType.custom,
      allowedExtensions: allowedFileType);
  if (selectedFile != null) {
    if (kIsWeb) {
    } else {
      File file = File(selectedFile.files.first.path!);
      int sizeInBytes = await file.length();
      int sizeInKB = (sizeInBytes / 1024).round();
      if (sizeInKB > defaultFileSizeINKB) {
        showError('File is too large');
        return (Uint8List(0), '');
      }
    }
    if (kIsWeb) {
      return (selectedFile.files.first.bytes!, selectedFile.files.first.name);
    } else {
      return (Uint8List(0), selectedFile.files.first.path ?? '');
    }
  }
  return (Uint8List(0), '');
}

void setAppType(SizingInformation sizingInformation) {
  isMobile = sizingInformation.isMobile;
  isTablet = sizingInformation.isTablet;
  isWeb = sizingInformation.isDesktop || sizingInformation.isExtraLarge;
}

String timeAgo(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  Duration difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return "now";
  } else if (difference.inMinutes < 60) {
    if (difference.inMinutes == 1) {
      return "${difference.inMinutes} minute ago";
    } else {
      return "${difference.inMinutes} minutes ago";
    }
  } else if (difference.inHours < 24) {
    if (difference.inHours == 1) {
      return "${difference.inHours} hour ago";
    } else {
      return "${difference.inHours} hours ago";
    }
  } else if (difference.inDays < 30) {
    if (difference.inDays == 1) {
      return "${difference.inDays} day ago";
    } else {
      return "${difference.inDays} days ago";
    }
  } else if (difference.inDays < 365) {
    if ((difference.inDays / 30).floor() == 1) {
      return "${(difference.inDays / 30).floor()} month ago";
    } else {
      return "${(difference.inDays / 30).floor()} months ago";
    }
  } else {
    if ((difference.inDays / 365).floor() == 1) {
      return "${(difference.inDays / 365).floor()} year ago";
    } else {
      return "${(difference.inDays / 365).floor()} years ago";
    }
  }
}
