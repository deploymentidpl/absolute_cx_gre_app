import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';

import '../../config/utils/constant.dart';
import '../../controller/SVFormController/sv_form_controller.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/comon_type_ahead_field.dart';
import '../../widgets/custom_text_field.dart';

class ProfessionalDetails extends GetView<SiteVisitFormController> {
  const ProfessionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    controller.update();
    if (isWeb) {
      controller.professionalDetailsFormKey = GlobalKey<FormState>();
      controller.personalDetailsFormKey = GlobalKey<FormState>();
    }
    return professionalDetailsView();
  }

  Widget professionalDetailsView() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Form(
          key: controller.professionalDetailsFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              responsiveRowColumn(
                widget1: customTypeAheadField(
                    labelText: "Occupation",
                    textController: controller.txtOccupation,
                    dataList: arrOccupation,
                    suggestion: (e) => e.description!,
                    onSelected: (t) {
                      controller.txtOccupation.text = t.description ?? "";
                      controller.objOccupation.value=t;
                    }),
                widget2: customTypeAheadField(
                  labelText: "Industry",
                  textController: controller.txtIndustry,
                  dataList: arrIndustry,
                  suggestion: (e) => e.description!,
                  onSelected: (t) {
                    controller.txtIndustry.text = t.description ?? "";
                    controller.objIndustry.value=t;
                  }

                ),
              ),
              responsiveRowColumn(
                widget1:customTextField(
                  labelText: 'Designation',
                  controller: controller.txtDesignation,
                  inputFormat: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-Z0-9 \u0900-\u097F]')),
                  ],
                ),
                widget2: customTypeAheadField(
                  labelText: "Function",
                  textController: controller.txtFunction,
                  dataList: arrFunction,
                  suggestion: (e) => e.description!,
                  onSelected: (t) {
                    controller.txtFunction.text = t.description ?? '';
                    controller.objFunction.value=t;
                  }

                ),
              ),
              responsiveRowColumn(
                widget1: customTextField(
                  labelText: "Company Name",
                  controller: controller.txtCompanyName,
                  inputFormat: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp("[a-zA-Z0-9 \u0900-\u097F]")),
                  ],
                ),
                widget2: customTextField(
                  labelText: "Company Location",
                  controller: controller.txtCompanyLocation,
                  inputFormat: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp("[a-zA-Z0-9 \u0900-\u097F]")),
                  ],
                ),
              ),
              customTextField(
                width: (!isMobile ? textFieldWidth : Get.width) * 2 + 20,
                maxLine: 2,
                labelText: "Company Address",
                controller: controller.txtCompanyAddress,
              ),
              responsiveRowColumn(
                  widget1: customTextField(
                    labelText: "Office Telephone",
                    controller: controller.txtOfficeTelephone,
                    inputFormat: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                    ],
                    textInputType: const TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                  ),
                  widget2: customTypeAheadField(
                    labelText: "Annual Income",
                    textController: controller.txtAnnualIncome,
                    dataList: arrIncome,
                    suggestion: (e) => e.description!,
                    onSelected: (t) {
                      controller.txtAnnualIncome.text = t.description!;
                      controller.objIncome.value=t;
                    }
                  )),
              SizedBox(
                height: isWeb ? 30 : 80,
              ),
              if (isWeb) submit()
            ],
          ),
        ),
      ),
    );
  }

  Widget submit() {
    return GestureDetector(
      onTap: controller.commonNextTap,
      // onTap: () {
      //   if (controller.professionalDetailsFormKey.currentState!.validate()) {
      //     controller.addEditSvFormDetails(SVFormType.professionalDetails);
      //   }
      // },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 40,
        color: ColorTheme.cPurple,
        child:   Text(
          "Submit",
          style: TextStyle(
              color: ColorTheme.cWhite,
              fontWeight: FontTheme.fontSemiBold,
              fontSize: 16),
        ),
      ),
    );
  }
}
