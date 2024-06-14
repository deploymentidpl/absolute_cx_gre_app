//
// import 'package:greapp/config/utils/constant.dart';
// import 'package:intl/intl.dart';
// import 'package:responsive_builder/responsive_builder.dart';
//
//
// String getDayAndDate(String dateTimeString, {bool isFullDate = true}) {
//   String value = "";
//   if (dateTimeString.isNotEmpty) {
//     DateFormat dateFormatter =
//         isFullDate ? DateFormat('dd-MM-yyyy') : DateFormat('dd MMM');
//
//     DateTime utcDateTime = DateTime.parse(dateTimeString).toLocal();
//     String utcDateStr = dateFormatter.format(utcDateTime);
//
//     if (utcDateStr == dateFormatter.format(DateTime.now())) {
//       value = "Today";
//     } else if (utcDateStr ==
//         dateFormatter
//             .format(DateTime.now().subtract(const Duration(days: 1)))) {
//       value = "Yesterday";
//     } else {
//       value = utcDateStr;
//     }
//   }
//   return value;
// }
//
// void setAppType(SizingInformation sizingInformation){
//   isMobile = sizingInformation.isMobile;
//   isTablet = sizingInformation.isTablet;
//   isWeb = sizingInformation.isDesktop || sizingInformation.isExtraLarge;
// }
//
// String getVideoUrlFromLink(String link) {
//   return "https://img.youtube.com/vi/${convertUrlToId(link) ?? ""}/0.jpg";
// }
//
// String timeAgo(String dateString) {
//   DateTime dateTime = DateTime.parse(dateString);
//   Duration difference = DateTime.now().difference(dateTime);
//
//   if (difference.inSeconds < 60) {
//     return "now";
//   } else if (difference.inMinutes < 60) {
//     if (difference.inMinutes == 1) {
//       return "${difference.inMinutes} minute ago";
//     } else {
//       return "${difference.inMinutes} minutes ago";
//     }
//   } else if (difference.inHours < 24) {
//     if (difference.inHours == 1) {
//       return "${difference.inHours} hour ago";
//     } else {
//       return "${difference.inHours} hours ago";
//     }
//   } else if (difference.inDays < 30) {
//     if (difference.inDays == 1) {
//       return "${difference.inDays} day ago";
//     } else {
//       return "${difference.inDays} days ago";
//     }
//   } else if (difference.inDays < 365) {
//     if ((difference.inDays / 30).floor() == 1) {
//       return "${(difference.inDays / 30).floor()} month ago";
//   } else {
//       return "${(difference.inDays / 30).floor()} months ago";
//   }
//   } else {
//     if ((difference.inDays / 365).floor() == 1) {
//       return "${(difference.inDays / 365).floor()} year ago";
//     } else {
//       return "${(difference.inDays / 365).floor()} years ago";
//     }
//   }
// }
//
// String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
//   if (!url.contains("http") && (url.length == 11)) return url;
//   if (trimWhitespaces) url = url.trim();
//
//   for (var exp in [
//     RegExp(
//         r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
//     RegExp(
//         r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
//     RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
//   ]) {
//     Match? match = exp.firstMatch(url);
//     if (match != null && match.groupCount >= 1) return match.group(1);
//   }
//
//   return null;
// }
//
// String maskMobile(String text) {
//   int digitsToShow = 4;
//
//   if (text.length <= digitsToShow) {
//     return text;
//   }
//
//   String maskedDigits = '*' * (text.length - digitsToShow);
//   //String visibleDigits = text.substring(0, digitsToShow);
//   //return visibleDigits + maskedDigits;
//
//   String visibleDigits =
//       text.substring(text.length - digitsToShow, text.length);
//   return maskedDigits + visibleDigits;
// }
//
// String convertChatDateTime(String dateTimeString) {
//   String value = "";
//
//   DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
//   DateFormat timeFormatter = DateFormat('hh:mm a');
//
//   DateTime utcDateTime = DateTime.parse(dateTimeString).toLocal();
//   String utcDateStr = dateFormatter.format(utcDateTime);
//   String nowDateStr = dateFormatter.format(DateTime.now());
//
//   if (utcDateStr == nowDateStr) {
//     value = timeFormatter.format(utcDateTime);
//   } else {
//     value = utcDateStr;
//   }
//
//   return value;
// }
//
// extension CapExtension on String {
//   String get titleCase => split(' ')
//       .map((word) =>
//           word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : "")
//       .join(' ');
// }
