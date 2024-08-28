import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/DashboardController/dashboard_controller.dart';
import '../../../style/theme_color.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/custom_text_field.dart';


Widget customDateSelection(
    {required Rx<DateTime> fromDate, required Rx<DateTime> toDate}) {
  final DashboardController controller = Get.find<DashboardController>();
  TextEditingController txtFromDate = TextEditingController();
  fromDate.value = toDate.value;
  fromDate.refresh();
  return Container(
    color: ColorTheme.cThemeBg,
    padding: EdgeInsets.all(controller.space20.value),
    child: Column(
      children: [
        customTextField(
            readOnly: true,
            labelText: 'Start Date*',
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please select start date";
              } else {
                return null;
              }
            },
            controller: txtFromDate,
            onTap: () {
              selectDate(txtFromDate, DateFormat('dd-MM-yyyy'),
                  DateTime(DateTime.now().year, 01, 01), DateTime.now());
            },
            onChange: (value) {
              txtFromDate.text = value;
            },
            suffixWidget: calenderView()),
        const SizedBox(
          height: 60,
        )
      ],
    ),
  );
}