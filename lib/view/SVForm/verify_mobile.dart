import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';

import '../../controller/SVFormController/sv_form_controller.dart';
import '../../widgets/comon_type_ahead_field.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_text_field.dart';

class VerifyMobile extends StatefulWidget {
  const VerifyMobile({super.key});

  @override
  State<VerifyMobile> createState() => _VerifyMobileState();
}

class _VerifyMobileState extends State<VerifyMobile> {
  SiteVisitFormController controller = Get.find<SiteVisitFormController>();
  GlobalKey<FormState> verifyMobileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return verifyMobile();
  }

  Widget verifyMobile() {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Form(
          key: verifyMobileFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mobileNo(),
              verifyOtp(),
              Obx(
                () => Visibility(
                  visible: controller.showOtp.isTrue,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomButtons.appThemeButton(
                      text: "VERIFY",
                      onTap: () {
                        if (verifyMobileFormKey.currentState!.validate()) {
                          controller.verifyOtp().then((value) {
                            if (value) {
                              controller.tabIndex.value = 1;
                              controller.tabIndex.refresh();
                            }
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget mobileNo() {
    return Obx(() => customTextField(
          labelText: 'Mobile*',
          enabled: true,
          autoFocus: true,
          validator: (value) {
            if (controller.objCountry.value.countryCode == '+91' &&
                (value!.isEmpty || value.length != 10)) {
              return 'Please Fill Valid Mobile Number';
            } else if (controller.objCountry.value.countryCode != '+91' &&
                (value!.length < 3 || value.length > 15)) {
              return 'Please Fill Valid Mobile Number';
            } else {
              return null;
            }
          },
          textInputType: TextInputType.number,
          maxLength: controller.objCountry.value.countryCode == '+91' ? 10 : 15,
          controller: controller.txtMobileNo,
          inputFormat: [FilteringTextInputFormatter.digitsOnly],
          prefixWidget: countryCodeDropDown(countryObj: controller.objCountry),
          suffixWidget: controller.showOtp.isFalse
              ? suffixText(
                  text: 'SEND OTP',
                  onTap: () {
                    if (controller.checkForm(verifyMobileFormKey)) {
                      controller.sendOTP();
                      controller.otpFocusNode.requestFocus();
                    }
                  },
                )
              : suffixText(
                  text: 'CHANGE',
                  onTap: () {
                    controller.txtMobileNo.clear();
                    controller.txtOtp.clear();
                    controller.showOtp.value = false;
                  },
                ),
        ));
  }

  Widget verifyOtp() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    return Obx(() {
      String min = twoDigits(controller.otpTime.value.inMinutes.remainder(60));
      String sec = twoDigits(controller.otpTime.value.inSeconds.remainder(60));
      return Visibility(
          visible: controller.showOtp.isTrue,
          child: customTextField(
            labelText: "OTP*",
            focusNode: controller.otpFocusNode,
            validator: (value) =>
                controller.validation(value, "Please Fill Valid OTP"),
            controller: controller.txtOtp,
            textInputType: TextInputType.number,
            inputFormat: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 6,
            suffixWidget: controller.showReSendOtp.isFalse
                ? suffixText(text: "$min:$sec")
                : suffixText(
                    text: "RE-SEND OTP",
                    onTap: () {
                      if (controller.txtMobileNo.text.isNotEmpty) {
                        controller.txtOtp.clear();
                        controller.sendOTP();
                        controller.otpFocusNode.requestFocus();
                      }
                    }),
          ));
    });
  }
}
