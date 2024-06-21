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
    return  Obx(()=>customTextField(
      labelText: "Mobile*",
      enabled: true,
      autoFocus: true,
      validator: (value) {
        if (value!.isEmpty || value.length < 10) {
          return "Please Fill Valid Mobile Number";
        } else {
          return null;
        }
      },
      controller: controller.txtMobileNo,
      //textInputType: const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputFormat: [FilteringTextInputFormatter.digitsOnly],
      maxLength: 10,
      prefixWidget: countryCodeDropDown(
          code: controller.objCountry.countryCode.toString()),
      suffixWidget:   controller.showOtp.isFalse
          ? suffixText(
        text: "SEND OTP",
        onTap: () {
          if (controller.checkForm(verifyMobileFormKey)) {
            controller.sendOTP();
            controller.otpFocusNode.requestFocus();
          }
        },
      )
          : suffixText(
        text: "CHANGE NUMBER",
        onTap: () {
          controller.txtMobileNo.clear();
          controller.txtOtp.clear();
          controller.showOtp.value = false;
        },
      )
    )) ;
  }

  Widget verifyOtp() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    return Obx(() {
      String min = twoDigits(controller.otpTime.value.inMinutes.remainder(60));
      String sec = twoDigits(controller.otpTime.value.inSeconds.remainder(60));
      return Visibility(
        visible: controller.showOtp.isTrue,
        child:  customTextField(
          labelText: "OTP*",
          focusNode: controller.otpFocusNode,
          validator: (value) =>
              controller.validation(value, "Please Fill Valid OTP"),
          controller: controller.txtOtp,
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
        )
      );
    });
  }

/*Widget verifyMobileApp() {
    return Form(
      key: verifyMobileFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          mobileNo(),
          verifyOtp()
        ],
      ),
    );
  }

  Widget verifyMobileWeb() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: ColorTheme.cThemeCard,
        child: Form(
          key: verifyMobileFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lets Get Started", style: TextStyle(
                  color: ColorTheme.cFontWhite, fontWeight: FontTheme.fontSemiBold, fontSize: 18
              ),),
              const SizedBox(height: 30,),
              Row(
                children: [
                  mobileNo(),
                  SizedBox(width: 30,),
                  verifyOtp()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}

/*class VerifyMobile extends GetView<SiteVisitFormController>  {
   VerifyMobile({super.key});

  GlobalKey<FormState> verifyMobileFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    controller.update();
    //return verifyOtp();

    return isMobile ? verifyMobileApp() :verifyMobileWeb();
  }

  Widget verifyMobileWeb() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: ColorTheme.cThemeCard,
        child: Form(
          key: verifyMobileFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lets Get Started", style: TextStyle(
                  color: ColorTheme.cFontWhite, fontWeight: FontTheme.fontSemiBold, fontSize: 18
              ),),
              const SizedBox(height: 30,),
               Row(
                children: [
                  mobileNo(),
                  SizedBox(width: 30,),
                  verifyOtp()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mobileNo() {
     return Obx(()=> customTextField(
       labelText: "Mobile*",
       enabled: true,
      // autoFocus : true,
       validator: (value) {
         if (value!.isEmpty || value.length<10) {
           return "Please Fill Valid Mobile Number";
         } else {
           return null;
         }
         //return cntSVForm.validation(value, "Please Fill Valid Mobile Number");
       },
       controller: controller.txtMobileNo,
       inputFormat: [FilteringTextInputFormatter.digitsOnly],
       maxLength: 10,
       prefixWidget: countryCodeDropDown(code: controller.objCountry.countryCode.toString()),
       suffixWidget: controller.showOtp.isFalse ? suffixText(text: "SEND OTP",  onTap: () {
         if(controller.checkForm(verifyMobileFormKey)) {
           controller.sendOTP();
           //controller.otpFocusNode.requestFocus();
         }
       },) : SizedBox(),
     ),
     );
  }

  Widget verifyOtp() {
   return Obx(()=>   Visibility(
      visible: controller.showOtp.isTrue,
      child: customTextField(
        labelText: "OTP*",
        focusNode: controller.otpFocusNode,
        validator: (value) => controller.validation(value, "Please Fill Valid OTP"),
        controller: controller.txtOtp,
        inputFormat: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 6,
        suffixWidget: suffixText(text: "VERIFY", onTap: () {
          controller.verifyOtp().then((value) {
          if(value){
            controller.tabIndex.value = 1;
          }
        });
        }
        ),
      ),
    ));
  }

  Widget verifyMobileApp() {
     return Form(
       key: verifyMobileFormKey,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           SizedBox(height: 30,),
          mobileNo(),
          verifyOtp()
        ],
       ),
     );
  }
}*/
