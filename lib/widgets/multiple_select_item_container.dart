import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greapp/config/Helper/size_config.dart';

import '../model/CustomDropDownItemsModel/custom_drop_down_items_model.dart';
import '../style/text_style.dart';
import '../style/theme_color.dart';

class MultipleSelectedItemsContainer extends StatelessWidget {
  final VoidCallback onTap, onDelete;

  const MultipleSelectedItemsContainer(
      {super.key,
      required this.onTap,
      required this.onDelete,
      required this.items,
      required this.title,
      this.width = 500});

  final List<CustomDropDownItems> items;
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Text(title,
            style: mediumTextStyle(size: 16, color: ColorTheme.cFontWhite)),
        const SizedBox(height: 8),
        Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: ColorTheme.cThemeCard,
                    border: Border.all(color: ColorTheme.cThemeCard)),
                child: Wrap(
                    spacing: 10.w,
                    runSpacing: 8.h,
                    children: items
                        .map((element) => Chip(
                              padding: EdgeInsets.zero,
                              label: Text(
                                element.description,
                                style: semiBoldTextStyle(size: 12.h),
                              ),
                              onDeleted: onDelete,
                              backgroundColor: ColorTheme.cAppTheme,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              deleteIcon: SvgPicture.asset(
                                //todo: add string
                                "",
                                width: 14,
                                height: 14,
                              ),
                            ))
                        .toList()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
