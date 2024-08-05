import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greapp/controller/CommonController/common_controller.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../model/MenuModel/menu_model.dart';
import '../../routes/route_name.dart';
import '../../style/theme_color.dart';
import '../../widgets/custom_dialogs.dart';
import '../shared_pref.dart';
import '../utils/constant.dart';
import '../utils/preference_controller.dart';

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

void navigateOnAlias(MenuModel obj) {
  if (obj.alias == "scan") {
    Get.toNamed(RouteNames.kQRScan);
  } else if (obj.alias == "knowledgebase") {
    Get.toNamed(RouteNames.kKnowledgebase);
  } else if (obj.alias == "logout") {
    CommonController().checkOut().whenComplete(() {
      PreferenceController.clearLoginCredential();
      PreferenceController.setBool(SharedPref.isUserLogin, false);
      Get.toNamed(RouteNames.kLogin);
    });
    /* CommonController().checkOut().then((value) {
      if (value) {
        PreferenceController.setBool(SharedPref.isUserLogin, false);
        Get.toNamed(RouteNames.kLogin);
      } else {
        showError(
          "Logout Failed",
        );
      }
    });*/
  }
}

String dateDecode(DateTime date) {
  var dateFormat = DateFormat("dd MMMM, yyyy").format(date);
  return dateFormat;
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

void devPrint(Object? object) {
  if (kDebugMode) {
    print('$object');
  }
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
String formatDuration(Duration duration, int type) {
  String formatString;

  switch (type) {
    case 0:
      formatString = _formatHoursMinutes(duration);
      break;
    case 1:
      formatString = _formatHoursMinutesSeconds(duration);
      break;
    case 2:
      formatString = _formatFullDuration(duration);
      break;
    default:
      formatString = _formatFullDurationWithMilliseconds(duration);
      break;
  }

  return formatString;
}

String _formatHoursMinutes(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  return "$hours:$minutes";
}

String _formatHoursMinutesSeconds(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);
  return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}

String _formatFullDuration(Duration duration) {
  final days = duration.inDays;
  final hours = duration.inHours.remainder(24);
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);
  return "${days}d ${hours}h ${minutes}m ${seconds}s";
}

String _formatFullDurationWithMilliseconds(Duration duration) {
  final days = duration.inDays;
  final hours = duration.inHours.remainder(24);
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);
  final milliseconds = duration.inMilliseconds.remainder(1000);
  return "${days}d ${hours}h ${minutes}m ${seconds}s ${milliseconds}ms";
}
String formatDate(String date, int type) {
  DateTime dt = DateTime.parse(date);

  String formatString;
  switch (type) {
    case 0:
      formatString = "hh:mm";
      break;
    case 1:
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

void exitApp() {
  SystemChannels.platform.invokeMethod<void>(
    'SystemNavigator.pop',
  );
}

String getVideoUrlFromLink(String link) {
  return "https://img.youtube.com/vi/${convertUrlToId(link) ?? ""}/0.jpg";
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

void setAppType(SizingInformation sizingInformation) {
  isMobile = sizingInformation.isMobile;
  isTablet = sizingInformation.isTablet;
  isWeb = sizingInformation.isDesktop || sizingInformation.isExtraLarge;
}
