import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/style/assets_string.dart';

import '../config/utils/constant.dart';
import '../config/utils/images.dart';
import '../style/text_style.dart';
import '../style/theme_color.dart';

typedef Validator = String? Function(String? value);
typedef OnChange = void Function(String value);
typedef OnTapPress = void Function();

Widget customTextField({
  OnTapPress? onTap,
  Widget? refreshWidget,
  bool autoFocus = false,
  TextEditingController? controller,
  bool readOnly = false,
  Color? cursorColor,
  Color? borderColor,
  Color? errorBorderColor,
  Color? textFieldColor,
  Color? focusColor,
  String hintText = "",
  TextStyle? hintStyle,
  Widget? prefix,
  Widget? prefixWidget,
  Widget? suffix,
  Widget? suffixWidget,
  FocusNode? focusNode,
  TextInputType? textInputType,
  FloatingLabelBehavior? floatingLabelBehavior,
  TextStyle? floatingLabelStyle,
  TextStyle? labelStyle,
  TextStyle? mainStyle,
  TextCapitalization? textCapitalization,
  String labelText = "",
  EdgeInsetsGeometry? padding,
  String? errorText = "",
  String? Function(String?)? validator,
  double? borderRadius = 0,
  double? sizeBoxHeight,
  OnChange? onChange,
  bool? obscureText,
  String? counterText,
  bool? showCounterText = false,
  List<TextInputFormatter>? inputFormat,
  bool enabled = true,
  int? maxLength,
  int maxLine = 1,
  Color? textColor,
  AutovalidateMode? validateMode = AutovalidateMode.onUserInteraction,
  double? textSize,
  double? width,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: sizeBoxHeight ?? (isMobile ? 15 : 25)),
      SizedBox(
        width: width ?? (isMobile ? Get.width : textFieldWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: labelStyle ??
                  TextStyle(
                      color: ColorTheme.cFontWhite,
                      fontWeight: FontTheme.fontMedium,
                      fontSize: 16),
            ),
            refreshWidget ?? const SizedBox()
          ],
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      SizedBox(
        width: width ?? (kIsWeb ? textFieldWidth : Get.width),
        child: IgnorePointer(
          ignoring: enabled == false,
          child: TextFormField(
            /*onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },*/
            focusNode: focusNode,
            maxLines: maxLine,
            autovalidateMode:
                validateMode ?? AutovalidateMode.onUserInteraction,
            obscureText: obscureText ?? false,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            onTap: onTap,
            autofocus: autoFocus,
            maxLength: maxLength,
            keyboardType: textInputType,
            style: mainStyle ??
                TextStyle(
                    color: textColor ?? ColorTheme.cFontWhite,
                    fontWeight: FontWeight.w500,
                    fontSize: textSize ?? 18),
            validator: enabled == true ? validator : null,
            readOnly: readOnly,
            controller: controller,
            cursorColor: cursorColor ?? ColorTheme.cFontWhite,
            onChanged: onChange,
            textInputAction: TextInputAction.done,
            inputFormatters: inputFormat ?? [],
            decoration: InputDecoration(
              floatingLabelBehavior:
                  floatingLabelBehavior ?? FloatingLabelBehavior.never,
              floatingLabelStyle: floatingLabelStyle ??
                  TextStyle(color: ColorTheme.cFontWhite, fontSize: 20),
              filled: true,
              enabled: enabled,

              fillColor: enabled == true
                  ? textFieldColor ??
                      (isMobile ? ColorTheme.cThemeCard : ColorTheme.cThemeBg)
                  : ColorTheme.cDisabled,
              counterText: showCounterText == true ? counterText : "",
              contentPadding: padding ??
                (isMobile? const EdgeInsets.symmetric(vertical: 15, horizontal: 10):  const EdgeInsets.symmetric(vertical: 20, horizontal: 10)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hintText,
              hintStyle: hintStyle ??
                  TextStyle(color: ColorTheme.cFontWhite, fontSize: 18),
              prefixIcon: prefixWidget,
              prefix: prefix,
              suffix: suffix ?? const SizedBox(),
              //suffixIconConstraints: const BoxConstraints(maxWidth: 70, minWidth: 30),
              suffixIcon: suffixWidget,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget suffixText({required String text, OnTapPress? onTap,Color? color}) {
  return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontTheme.fontSemiBold,
                color: color??ColorTheme.cPurple)),
      ));
}
Widget suffixButton({required String text, OnTapPress? onTap,Color? color,double? fontSize}) {
  return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: onTap,
      child: Center(
        child: Container(
          color: ColorTheme.cAppTheme,
          padding: const EdgeInsets.all(10),
          child: Text(text,
              style: TextStyle(
                  fontSize:fontSize?? 16,
                  fontWeight: FontTheme.fontSemiBold,
                  color: color??ColorTheme.cWhite)),
        ),
      ));
}

Widget downArrowWidget() {
  return const Padding(
    padding: EdgeInsets.all(10),
    child: Icon(
      Icons.keyboard_arrow_down_sharp,
      color: ColorTheme.cWhite,
    ),
  );
}

Widget calenderIconWidget() {
  return const Padding(
    padding: EdgeInsets.all(10),
    child: Icon(
      Icons.calendar_month,
      color: ColorTheme.cWhite,
    ),
  );
}

Widget calenderView() {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: SvgPicture.asset(
        AssetsString.aCalendar,
        colorFilter: const ColorFilter.mode(ColorTheme.cWhite, BlendMode.srcIn),
      ));
}

class RefreshButton<T> extends StatefulWidget {
  final Future<RxList<T>> Function() onTap;

  const RefreshButton({super.key, required this.onTap});

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> {
  bool _isRefreshing = false;

  void _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });
    await widget.onTap();
    setState(() {
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !_isRefreshing ? _handleRefresh : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _isRefreshing
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ))
              : SvgPicture.asset(
                  AssetsString.aRefresh,
                  colorFilter: const ColorFilter.mode(
                      ColorTheme.cWhite, BlendMode.srcIn),
                  height: 18,
                  width: 18,
                )
          // Icon(Icons.refresh, color: ColorTheme.cWhite,size: 18.h),
        ],
      ),
    );
  }
}
