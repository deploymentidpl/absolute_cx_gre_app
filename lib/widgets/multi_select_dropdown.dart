import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../config/utils/constant.dart';
import '../style/text_style.dart';
import '../style/theme_color.dart';

/// there is one issue --
/// if dropdown is open & navigate to another screen dropdown display in the screen where you navigate
/// try to solve this error using focus node

Widget multiSelectDropDown<T>(
    {required String label,
    required RxList<T> list,
    required RxList<T> selectedList,
    required final String Function(T) suggestion,
    Color? fillColor,
    Widget? refreshWidget,
    TextStyle? hintStyle,
    double? width}) {
  MultiSelectController controller = MultiSelectController();

  return SizedBox(
    width: width ?? (isMobile ? Get.width : textFieldWidth),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: ColorTheme.cFontWhite,
                  fontWeight: FontTheme.fontMedium,
                  fontSize: 16),
            ),
            refreshWidget ?? const SizedBox.shrink()
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () {
            return MultiSelectDropDown(
              controller: controller,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              hintPadding: const EdgeInsets.all(5),
              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
              borderRadius: 0,
              borderWidth: 0,
              borderColor: ColorTheme.cLightBlack,
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: ColorTheme.cFontWhite,
              ),
              fieldBackgroundColor: fillColor ??
                  (isMobile ? ColorTheme.cThemeCard : ColorTheme.cThemeBg),
              clearIcon: null,
              searchEnabled: true,
              dropdownMargin: 2,
              dropdownBorderRadius: 5,
              hintStyle: hintStyle ??
                  TextStyle(color: ColorTheme.cFontWhite, fontSize: 18),
              //padding: const EdgeInsets.all(5),
              onOptionSelected: (selectedOptions) {
                selectedList.clear();
                selectedList.addAll(selectedOptions.map((e) => e.value!));
              },
              selectedOptions: selectedList.map((e) {
                return ValueItem(
                  label: suggestion(e),
                  value: e,
                );
              }).toList(),
              options: list.map((e) {
                return ValueItem(
                  label: suggestion(e),
                  value: e,
                );
              }).toList(),
              optionBuilder: (ctx, item, selected) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.label,
                        style: mediumTextStyle(
                            size: 15,
                            color: selected
                                ? ColorTheme.cAppTheme
                                : ColorTheme.cFontWhite),
                      ),
                      if (selected)
                        Icon(
                          Icons.check,
                          color: ColorTheme.cAppTheme,
                        )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    ),
  );
}

class MultiSelectDropDown1<T> extends StatelessWidget {
  MultiSelectDropDown1(
      {super.key,
      required this.list,
      required this.selectedList,
      required this.suggestion,
      this.fillColor,
      this.refreshWidget,
      this.hintStyle,
      this.width,
      required this.label,
      required this.onRemove});

  final List<T> list, selectedList;
  final Function(T) suggestion;
  final Color? fillColor;
  final Widget? refreshWidget;
  final TextStyle? hintStyle;
  final double? width;
  final String label;
  final MultiSelectController controller = MultiSelectController();
  final Function(String?) onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? (isMobile ? Get.width : textFieldWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                    color: ColorTheme.cFontWhite,
                    fontWeight: FontTheme.fontMedium,
                    fontSize: 16),
              ),
              refreshWidget ?? const SizedBox.shrink()
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            return MultiSelectDropDown(
              controller: controller,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              hintPadding: const EdgeInsets.all(5),
              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
              borderRadius: 0,
              borderWidth: 0,
              onOptionRemoved: (index, item) {
                onRemove(item.label);
              },
              borderColor: ColorTheme.cLightBlack,
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: ColorTheme.cFontWhite,
              ),
              fieldBackgroundColor: fillColor ??
                  (isMobile ? ColorTheme.cThemeCard : ColorTheme.cThemeBg),
              clearIcon: null,
              searchEnabled: true,
              dropdownMargin: 2,
              dropdownBorderRadius: 5,
              hintStyle: hintStyle ??
                  TextStyle(color: ColorTheme.cFontWhite, fontSize: 18),
              //padding: const EdgeInsets.all(5),
              onOptionSelected: (selectedOptions) {
                selectedList.clear();
                selectedList.addAll(selectedOptions.map((e) => e.value!));
              },
              selectedOptions: selectedList.map((e) {
                return ValueItem(
                  label: suggestion(e),
                  value: e,
                );
              }).toList(),
              options: list.map((e) {
                return ValueItem(
                  label: suggestion(e),
                  value: e,
                );
              }).toList(),
              optionBuilder: (ctx, item, selected) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.label,
                        style: mediumTextStyle(
                            size: 15,
                            color: selected
                                ? ColorTheme.cAppTheme
                                : ColorTheme.cLightBlack),
                      ),
                      if (selected)
                        Icon(
                          Icons.check,
                          color: ColorTheme.cAppTheme,
                        )
                    ],
                  ),
                );
              },
            );
          })
        ],
      ),
    );
  }
}
