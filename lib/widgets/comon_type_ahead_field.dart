import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../config/utils/constant.dart';
import '../model/common_model.dart';
import '../style/text_style.dart';
import '../style/theme_color.dart';
import 'custom_text_field.dart';

Widget customTypeAheadField<T>(
    {required List<T> dataList,
    required void Function(T) onSelected,
    required final String Function(T) suggestion,
    required TextEditingController textController,
    Future<List<T>> Function(String)? apiCallback,
    Widget? suffixWidget,
    bool readOnly = false,
    String? Function(String?)? validator,
    String labelText = "",
    TextStyle? labelStyle,
    double? width,
    Widget? refreshWidget,
    Color? fillColor,
    TextInputType? textInputType,
    List<TextInputFormatter>? inputFormat,
    int? maxLength,
    TextStyle? hintStyle,
    EdgeInsetsGeometry? contentPadding,
    bool? enable,
    bool isSizedBoxHeight = true}) {
  RxString text = "Select".obs;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (isSizedBoxHeight == true) SizedBox(height: isWeb ? 25 : 15),
      SizedBox(
        width: width ?? (isWeb ? textFieldWidth : Get.width),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: labelStyle ??
                  mediumTextStyle(color: ColorTheme.cFontWhite, size: 16),
            ),
            refreshWidget ?? const SizedBox()
          ],
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      SizedBox(
        width: width ?? (kIsWeb ? textFieldWidth : Get.width),
        child: TypeAheadField<T>(
          ///to work search pattern need to give controller - textController , but once value selected it gives the sugetion of only selected value
          controller: textController,

          itemBuilder: (context, t) => Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              suggestion(t),
              style: mediumTextStyle(color: ColorTheme.cFontWhite),
            ),
          ),
          onSelected: (value) {
            onSelected(value);
            //text.value = "Select";
          },
          /*onSelected: (t) {
                  controller.text = searchKey(t);
                },*/
          suggestionsCallback: (pattern) async {
            await Future.delayed(
                const Duration(milliseconds: 300)); // Simulating delay
            List<T>? suggestionList;
            // If pattern is empty, return the default list of String.
            if (pattern.trim().isEmpty && dataList.isNotEmpty) {
              suggestionList = dataList;
            } else if (apiCallback != null) {
              suggestionList = await apiCallback(pattern);
            } else {
              suggestionList = dataList.where((data) {
                return suggestion(data)
                    .toString()
                    .toLowerCase()
                    .contains(pattern.toString().toLowerCase());
              }).toList();
            }

            return suggestionList;
          },

          builder: (context, controller, focusNode) => Obx(
            () => TextFormField(
              controller: controller,
              focusNode: focusNode,
              readOnly: readOnly,
              onTap: () async {
                textController.clear();
                text.value = "Search";
                /*if(onTapApiCall != null){
                    await onTapApiCall;
                  }*/
                await Future.delayed(const Duration(milliseconds: 300));
              },
              mouseCursor: SystemMouseCursors.click,
              style: mediumTextStyle(color: ColorTheme.cFontWhite, size: 18),
              cursorColor: ColorTheme.cFontWhite,
              decoration: InputDecoration(
                contentPadding: (isWeb
                    ? const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
                    : const EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
                border: InputBorder.none,
                hintText: text.value,
                //"Select",
                hintStyle: hintStyle ??
                    TextStyle(
                        color: ColorTheme.cFontWhite.withOpacity(0.2),
                        fontSize: 18),
                fillColor: fillColor ??
                    (isWeb ? ColorTheme.cThemeBg : ColorTheme.cThemeCard),
                filled: true,
                suffixIcon: suffixWidget ?? downArrowWidget(),
              ),
              enabled: enable ?? true,
              //readOnly: readOnly??textController.text.isNotEmpty? true :false,
              validator: validator,
              inputFormatters: inputFormat ?? [],
              keyboardType: textInputType,
              maxLength: maxLength,
            ),
          ),

          decorationBuilder: (context, child) => Material(
            type: MaterialType.card,
            elevation: 4,
            color: ColorTheme.cThemeBg,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: child,
          ),
        ),
      ),
    ],
  );
}

Widget countryCodeWidget({required String code}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                code,
                style: mediumTextStyle(size: 14, color: ColorTheme.cFontWhite),
              ),
                Icon(
                Icons.keyboard_arrow_down,
                color: ColorTheme.cWhite,
              ),
              const VerticalDivider(
                thickness: 0.5,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget countryCodeDropDown({required Rx<CommonModel> countryObj}) {
  ///whenever you want to get country code & description or any other selected values
  ///use on Select
  ///required void Function(T) onSelected,

  ///if you are having problem in opening suggestion list like - suggestion list & keyboard both open & sudden close at same time then give autofocus or request focus on text form field where you are using countryCodeDropDown

  //RxString text = code.obs;
  RxBool openList = false.obs;
  TextEditingController txt = TextEditingController();
  FocusNode focusNode = FocusNode();

  return Stack(
    clipBehavior: Clip.none,
    children: [
      GestureDetector(
        onTap: () {
          openList.value = true;
          openList.refresh();
          focusNode.requestFocus();
        },
        child: Obx(
                () => countryCodeWidget(code: countryObj.value.countryCode ?? '')),
      ),
      Obx(
            () => openList.isTrue
            ? TypeAheadField(
          controller: txt,
          focusNode: focusNode,
          retainOnLoading: true,
          itemBuilder: (context, t) {
            return ListTile(
              leading: Text(
                '(${t.countryCode})',
                style: mediumTextStyle(color: ColorTheme.cBlack),
              ),
              title: Text(
                t.description ?? '',
                style: mediumTextStyle(color: ColorTheme.cBlack),
              ),
            );
          },
          onSelected: (value) {
            countryObj.value = value;
            //   text.value = value.countryCode ?? "+91";
            openList.value = false;
          },
          suggestionsCallback: (pattern) async {
            await Future.delayed(
                const Duration(milliseconds: 300)); // Simulating delay
            List<CommonModel> suggestionList;
            if (pattern.trim().isEmpty && arrCountry.isNotEmpty) {
              suggestionList = arrCountry;
              /* } else if(apiCallback != null){
        // If apiCallback is provided, call it to get suggestions
        suggestionList = await apiCallback!(pattern);*/
            } else {
              suggestionList = arrCountry.where((data) {
                return data.description
                    .toString()
                    .toLowerCase()
                    .contains(pattern.toString().toLowerCase());
              }).toList();
            }

            return suggestionList;
          },
          builder: (context, controller, focusNode) => TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            mouseCursor: SystemMouseCursors.click,
            style: TextStyle(color: ColorTheme.cFontWhite, fontSize: 18),
            cursorColor: ColorTheme.cFontWhite,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 8),
                //hoverColor: ColorTheme.cThemeCard,
                border: InputBorder.none,
                hintText: 'Search Country',
                hintStyle:
                TextStyle(color: ColorTheme.cFontWhite, fontSize: 18),
                fillColor: isMobile
                    ? ColorTheme.cThemeCard
                    : ColorTheme.cThemeBg,
                filled: true,
                prefixIcon: countryCodeWidget(
                    code: countryObj.value.countryCode ?? '')),
          ),
          decorationBuilder: (context, child) => Material(
            type: MaterialType.card,
            elevation: 4,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: child,
          ),
        )
            : const SizedBox(),
      ),
    ],
  );
}

Widget prefixDropDown<T>(
    {required List<T> dataList,
      required void Function(T) onSelected,
      required String Function(T) suggestion,
      String selectedValue = 'Select',
      required TextEditingController textController}) {
  RxBool openList = false.obs;
  TextEditingController txt = TextEditingController();
  FocusNode focusNode = FocusNode();

  return Stack(
    clipBehavior: Clip.none,
    children: [
      GestureDetector(
        onTap: () {
          openList.value = true;
          openList.refresh();
          focusNode.requestFocus();
        },
        child: Container(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 150),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: Text(
                          selectedValue.isEmpty ? 'Select' : selectedValue,
                          style: mediumTextStyle(
                              size: 14, color: ColorTheme.cFontWhite),
                        )),
                      Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorTheme.cWhite,
                    ),
                    const VerticalDivider(
                      thickness: 0.5,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Obx(
            () => openList.isTrue
            ? TypeAheadField(
          controller: txt,
          focusNode: focusNode,
          retainOnLoading: true,
          itemBuilder: (context, t) {
            return Container(
              height: 40,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                suggestion(t),
                style: mediumTextStyle(color: ColorTheme.cBlack),
              ),
            );
          },
          onSelected: onSelected,
          suggestionsCallback: (pattern) {
            // await Future.delayed(const Duration(milliseconds: 300)); // Simulating delay
            List<T>? suggestionList;
            // If pattern is empty, return the default list of String.
            if (pattern.trim().isEmpty && dataList.isNotEmpty) {
              suggestionList = dataList;
            } else {
              suggestionList = dataList.where((data) {
                return suggestion(data)
                    .toString()
                    .toLowerCase()
                    .contains(pattern.toString().toLowerCase());
              }).toList();
            }

            return suggestionList;
          },
          builder: (context, controller, focusNode) => TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: true,
            mouseCursor: SystemMouseCursors.click,
            style: TextStyle(color: ColorTheme.cFontWhite, fontSize: 18),
            cursorColor: ColorTheme.cFontWhite,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 8),
                //hoverColor: ColorTheme.cThemeCard,
                border: InputBorder.none,
                hintText: '',
                hintStyle:
                TextStyle(color: ColorTheme.cFontWhite, fontSize: 18),
                fillColor: isMobile
                    ? ColorTheme.cThemeCard
                    : ColorTheme.cThemeBg,
                filled: true,
                prefixIcon: Container(
                  constraints:
                  const BoxConstraints(minWidth: 100, maxWidth: 150),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                child: Text(
                                  selectedValue.isNotEmpty
                                      ? selectedValue
                                      : 'Select',
                                  style: mediumTextStyle(
                                      size: 14, color: ColorTheme.cFontWhite),
                                )),
                              Icon(
                              Icons.keyboard_arrow_down,
                              color: ColorTheme.cWhite,
                            ),
                            const VerticalDivider(
                              thickness: 0.5,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          decorationBuilder: (context, child) => Material(
            type: MaterialType.card,
            elevation: 4,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: child,
          ),
        )
            : const SizedBox(),
      ),
    ],
  );
}
