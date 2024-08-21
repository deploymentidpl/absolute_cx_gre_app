import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/Helper/function.dart';
import '../../model/LeadModel/lead_model.dart';
import '../../style/assets_string.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';

class CustomLeadSidebar extends StatelessWidget {
  const CustomLeadSidebar({super.key, required this.leadsList});
  final List<LeadModel> leadsList;

  @override
  Widget build(BuildContext context) {
    return leadsList.isNotEmpty? SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 1800,
        child:   Table(
          columnWidths: const {
            0:FlexColumnWidth(0.5),
            1:FlexColumnWidth(0.5),
            5: FlexColumnWidth(2.0),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: List.generate(
              leadsList.length + 1,
                  (index) {
                return index == 0
                    ? TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: ColorTheme.cLineColor))),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          "Order".toUpperCase(),
                          style: semiBoldTextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          "Token".toUpperCase(),
                          style: semiBoldTextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          "Owner".toUpperCase(),
                          style: semiBoldTextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          "Details".toUpperCase(),
                          style: semiBoldTextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          "Status".toUpperCase(),
                          style: semiBoldTextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          "Project".toUpperCase(),
                          style: semiBoldTextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          "Source".toUpperCase(),
                          style: semiBoldTextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          "sourcing Manager".toUpperCase(),
                          style: semiBoldTextStyle(),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 5),
                          child: Text(
                            "Date".toUpperCase(),
                            style: semiBoldTextStyle(),
                          ),
                        ),
                      ),
                    ])
                    : TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: ColorTheme.cLineColor))),
                    children: [
                      leadsList[index - 1]
                          .scanVisitLocationData.isNotEmpty? Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          leadsList[index - 1]
                              .scanVisitLocationData[0]
                              .svWaitListNumber
                              .toString(),
                          style: mediumTextStyle(),
                        ),
                      ):const SizedBox(),
                     leadsList[index - 1]
                          .scanVisitLocationData.isNotEmpty?  Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          leadsList[index - 1]
                              .scanVisitLocationData[0]
                              .currentVisitToken
                              .toString(),
                          style: mediumTextStyle(),
                        ),
                      ):const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child:
                            Text(
                              leadsList[index - 1]
                                  .svOwnerName,
                              style: semiBoldTextStyle(
                                size: 14,
                              ),
                            )),
                      ),
                      leadsList[index - 1]
                          .leadData.isNotEmpty? Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          getRandomColor()),
                                  child: Center(
                                    child: Text(
                                      leadsList[
                                      index - 1]
                                          .leadData[0]
                                          .firstName
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      style: mediumTextStyle(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${leadsList[index - 1].leadData[0].firstName} ${leadsList[index - 1].leadData[0].lastName}",
                                      style:
                                      boldTextStyle(size: 16),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      color: ColorTheme.cAppTheme,
                                      padding: const EdgeInsets
                                          .symmetric(
                                          horizontal: 10,
                                          vertical: 5),
                                      child: Text(
                                        "#${leadsList[index - 1].leadData[0].leadId}",
                                        style: semiBoldTextStyle(
                                            size: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // Row(
                            //   children: [
                            //     controller
                            //             .homeController
                            //             .filteredLeadList[index - 1]
                            //             .details
                            //             .cp
                            //         ? Container(
                            //             color: ColorTheme.cAppTheme
                            //                 .withOpacity(0.08),
                            //             padding:
                            //                 const EdgeInsets.symmetric(
                            //                     horizontal: 8,
                            //                     vertical: 4),
                            //             child: Text(
                            //               "CP",
                            //               style: semiBoldTextStyle(
                            //                   size: 12),
                            //             ),
                            //           )
                            //         : Container(
                            //             color: ColorTheme.cBgMosque,
                            //             padding:
                            //                 const EdgeInsets.symmetric(
                            //                     horizontal: 8,
                            //                     vertical: 2),
                            //             child: SvgPicture.asset(
                            //               AssetsString.aUser,
                            //               height: controller.space20.value,
                            //               colorFilter: ColorFilter.mode(
                            //                   ColorTheme.cMosque,
                            //                   BlendMode.srcIn),
                            //             ),
                            //           ),
                            //     const SizedBox(
                            //       width: 10,
                            //     ),
                            //     controller
                            //             .homeController
                            //             .filteredLeadList[index - 1]
                            //             .details
                            //             .missedCall
                            //         ? Container(
                            //             color: ColorTheme.cBgRed
                            //                 .withOpacity(0.2),
                            //             padding:
                            //                 const EdgeInsets.symmetric(
                            //                     horizontal: 8,
                            //                     vertical: 4),
                            //             child: Text(
                            //               "Missed Call",
                            //               style: semiBoldTextStyle(
                            //                   size: 12,
                            //                   color:
                            //                       ColorTheme.cFontRed),
                            //             ),
                            //           )
                            //         : const SizedBox()
                            //   ],
                            // )
                          ],
                        ),
                      ):const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Text(
                          leadsList[index - 1]
                              .siteVisitStatus,
                          style: semiBoldTextStyle(
                              size: 12, color: ColorTheme.cMosque),
                        ),
                      ),
                      leadsList[index - 1]
                          .leadData.isNotEmpty? Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AssetsString.aSiteVisit,
                                  height: 20,
                                  colorFilter:
                                  const ColorFilter.mode(
                                      ColorTheme.cWhite,
                                      BlendMode.srcIn),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  leadsList[index - 1]
                                      .leadData[0]
                                      .projectLocationDescription,
                                  style: mediumTextStyle(),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              alignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      AssetsString.aBuilding,
                                      height: 20,
                                      colorFilter:
                                      const ColorFilter.mode(
                                          ColorTheme.cWhite,
                                          BlendMode.srcIn),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      leadsList[
                                      index - 1]
                                          .leadData[0]
                                          .projectName,
                                      style: mediumTextStyle(),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      AssetsString.aBHK,
                                      height: 20,
                                      colorFilter:
                                      const ColorFilter.mode(
                                          ColorTheme.cWhite,
                                          BlendMode.srcIn),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      leadsList[
                                      index - 1]
                                          .leadData[0]
                                          .leadRequirements[0]
                                          .configurationDescription,
                                      style: mediumTextStyle(),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      AssetsString.aCoinRupee,
                                      height: 20,
                                      colorFilter:
                                      const ColorFilter.mode(
                                          ColorTheme.cWhite,
                                          BlendMode.srcIn),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      leadsList[
                                      index - 1]
                                          .leadData[0]
                                          .leadRequirements[0]
                                          .budgetDescription,
                                      style: mediumTextStyle(),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ):const SizedBox(),
                     Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 5),
                          child: Text(
                            leadsList[index - 1]
                                .leadSourceDescription,
                            style: semiBoldTextStyle(
                                size: 12,
                                color: ColorTheme.cMosque),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: leadsList[index - 1]
                            .sourcingManagerList
                            .isNotEmpty
                            ? Column(
                          children: List.generate(
                              leadsList[index - 1]
                                  .sourcingManagerList
                                  .length,
                                  (managerIndex) => Container(
                                color:
                                ColorTheme.cThemeBg,
                                padding:
                                const EdgeInsets.all(
                                    2),
                                child: Row(
                                  mainAxisSize:
                                  MainAxisSize.min,
                                  children: [
                                    Container(
                                      color: ColorTheme
                                          .cBgBlue,
                                      height: 30,
                                      width: 30,
                                      child: Center(
                                        child: Text(
                                          leadsList[
                                          index -
                                              1]
                                              .sourcingManagerList[
                                          managerIndex]
                                              .ownerEmpName
                                              .substring(
                                              0, 1)
                                              .toUpperCase(),
                                          style:
                                          boldTextStyle(
                                              size:
                                              14),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        leadsList[
                                        index - 1]
                                            .sourcingManagerList[
                                        managerIndex]
                                            .ownerEmpName,
                                        style:
                                        mediumTextStyle(),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        )
                            : const SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 5),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                color: ColorTheme.cWhite
                                    .withOpacity(0.2),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  convertDate(leadsList[index - 1]
                                      .createdAt),
                                  style: mediumTextStyle(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                color: ColorTheme.cWhite
                                    .withOpacity(0.2),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  convertDate(leadsList[index - 1]
                                      .updatedAt),
                                  style: mediumTextStyle(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
              }),
        ),
      ),
    ):Center(
      child: Text("No Leads",style: mediumTextStyle(),),
    );
  }
}
