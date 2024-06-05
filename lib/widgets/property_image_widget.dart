import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/utils/constant.dart';
import '../model/BlockUnitProperty/block_unit_property.dart';
import '../style/text_style.dart';
import '../style/theme_color.dart';

class BlockPropertyWidget extends StatelessWidget {
  const BlockPropertyWidget({super.key, required this.detail});

  final BlockUnitPropertyModel detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 400,
        // maxHeight: 430.h,
      ),
      decoration: BoxDecoration(
        color: ColorTheme.cThemeCard,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Property', style: semiBoldTextStyle(size: 18)),
          sizedBox16,
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                detail.imageUrl.isEmpty
                    ? Container(
                        height: 250,
                        color: ColorTheme.cFontWhite.withOpacity(0.2),
                      )
                    : Image.network(
                        detail.imageUrl,
                        fit: BoxFit.cover,
                        height: 250,
                      ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: 114,
                      height: 48,
                      child: detail.thumbNail.isEmpty
                          ? Container(
                              height: 250,
                              color: ColorTheme.cBgWhite20.withOpacity(0.2),
                            )
                          : Image.network(
                              detail.thumbNail,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          sizedBox16,
          Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                  8,
                  (index) => Container(
                        height: 8,
                        width: 73,
                        color: ColorTheme.cFontWhite.withOpacity(0.2),
                      ))),
          sizedBox16,
          if (detail.isBlocked)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BLOCKED',
                    style: regularTextStyle(size: 24, color: ColorTheme.cOrange)
                        .copyWith(fontFamily: FontTheme.themeFontFamilyImpact)),
                sizedBox16,
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: ColorTheme.cBgRed,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'This Unit is Blocked till ',
                              style: semiBoldTextStyle(
                                  size: 10, color: ColorTheme.kRed),
                            ),
                            TextSpan(
                              text: 'Mar 15, 2023  5:19 PM',
                              style: fullBoldTextStyle(
                                  size: 10,
                                  color: ColorTheme
                                      .kRed), // Example for different color
                            ),
                          ],
                        ),
                      ),
                      sizedBox8,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Blocked on ',
                              style: semiBoldTextStyle(
                                  size: 10, color: ColorTheme.kRed),
                            ),
                            TextSpan(
                              text: 'thu, mar 21, 2024 12:15 pm',
                              style: fullBoldTextStyle(
                                  size: 10,
                                  color: ColorTheme
                                      .kRed), // Example for different color
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBox16,
              ],
            ),
          Container(
            height: 23,
            color: ColorTheme.cFontWhite.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Container(
            height: 23,
            color: ColorTheme.cFontWhite.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
