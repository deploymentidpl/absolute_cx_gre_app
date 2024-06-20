import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';
import 'package:greapp/style/assets_string.dart';

import '../../config/Helper/function.dart';
import '../../config/utils/constant.dart';
import '../../controller/SVFormController/sv_form_controller.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/CustomSliderThumb.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/comon_type_ahead_field.dart';
import '../../widgets/custom_text_field.dart';

class PersonalDetails extends GetView<SiteVisitFormController> {
  bool isPurchaseDetailsPage = true;

  PersonalDetails(
      {super.key,
        required this.isPurchaseDetailsPage,
        required this.controllerc});

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SiteVisitFormController controllerc;

  @override
  Widget build(BuildContext context) {
    controller.update();

    return /*isPurchaseDetailsPage
        ? Form(
            key: controller.purchaseDetailsFormKey,
            child: purchaseDetailsView())
        :*/
      personalDetailsView();
  }

  Widget personalDetailsView() {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Form(
        key: controller.personalDetailsFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            customTypeAheadField(
              refreshWidget: GestureDetector(
                onTap: () {
                  controller.retrieveTitle();
                },
                child: Container(
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    AssetsString.aRefresh,
                    height: 20,
                  ),
                ),
              ),
              dataList: controller.arrTitle,
              suggestion: (t) => t.description ?? "",
              onSelected: (t) => controller.txtTitle.text = t.description!,
              textController: controller.txtTitle,
              validator: (value) =>
                  controller.validation(value, "Please Select Title"),
              labelText: "Title*",
            ),
            responsiveRowColumn(
              widget1: customTextField(
                labelText: "First Name*",
                textCapitalization: TextCapitalization.words,
                maxLength: 72,
                textInputType: TextInputType.name,
                hintText: "First Name",
                inputFormat: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z \u0900-\u097F]")),
                  CustomTextInputFormatter()
                ],
                validator: (value) =>
                    controller.validation(value, "Please Fill First Name"),
                controller: controller.txtFirstName,
              ),
              widget2: customTextField(
                labelText: "Last Name*",
                textCapitalization: TextCapitalization.words,
                maxLength: 72,
                textInputType: TextInputType.name,
                hintText: "Last Name",
                inputFormat: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z \u0900-\u097F]")),
                  CustomTextInputFormatter()
                ],
                validator: (value) =>
                    controller.validation(value, "Please Fill Last Name"),
                controller: controller.txtLastName,
              ),
            ), customTextField(
              labelText: "Email*",
              textCapitalization: TextCapitalization.words,
              maxLength: 72,
              textInputType: TextInputType.name,
              hintText: "Email",
              inputFormat: <TextInputFormatter>[
                // FilteringTextInputFormatter.allow(
                //     emailValid),
                // CustomTextInputFormatter()
              ],
              validator: (value) =>
                  emailValidation(value),
              controller: controller.txtEmail,
            ),
            responsiveRowColumn(
              widget1: customTextField(
                labelText: "Mobile*",
                validator: (value) => controller.validation(
                    value, "Please Fill Valid Mobile Number"),
                enabled: false,
                controller: controller.txtMobileNo,
                prefixWidget: countryCodeDropDown(
                    code: controller.objCountry.countryCode.toString()),
                //mainTextFieldColor: ColorTheme.cEnabled,
                inputFormat: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
              ),
              widget2: customTextField(
                  labelText: "Alternate Mobile Number",
                  controller: controller.txtResAlternate,
                  inputFormat: [FilteringTextInputFormatter.digitsOnly],
                  hintText: "9876543210",
                  maxLength: 10,
                  prefixWidget: countryCodeDropDown(
                      code: controller.objResCountry.countryCode ?? "")),
            ),
            customTextField(
                labelText: "Res. Telephone Number",
                controller: controller.txtTelephoneNo,
                inputFormat: [FilteringTextInputFormatter.digitsOnly],
                hintText: "9876543210",
                maxLength: 10,
                prefixWidget: countryCodeDropDown(
                    code: controller.objTelCountry.countryCode ?? "")),
            customTypeAheadField(
                refreshWidget: GestureDetector(
                  onTap: () {
                    controller.retrieveAgeGroup();
                  },
                  child: Container(
                      color: Colors.transparent,
                      child: SvgPicture.asset(
                        AssetsString.aRefresh,
                        height: 20,
                      )),
                ),
                dataList: controller.arrAgeGroup,
                onSelected: (t) =>
                controller.txtAgeGroup.text = t.description ?? "",
                suggestion: (t) => t.description!,
                labelText: "Age Group",
                textController: controller.txtAgeGroup,
                validator: (value) =>
                    controller.validation(value, "Please Fill Age Group")),
            responsiveRowColumn(
              widget1: customTextField(
                labelText: "Current Residence Location",
                hintText: "Current Residence Location",
                controller: controller.txtCurrentResidence,
                textInputType: TextInputType.name,
                maxLength: 72,
              ),
              widget2: customTextField(
                  labelText: "Area Pincode",
                  controller: controller.txtPinCode,
                  textInputType: TextInputType.name,
                  hintText: "Area Pincode",
                  inputFormat: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp("[a-zA-Z0-9 \u0900-\u097F]")),
                  ]),
            ),
            // customTypeAheadField(
            //     refreshWidget: GestureDetector(
            //       onTap: () {
            //         controller.retrieveSourcingManager(
            //             searchText: controller.txtSourcingManager.text);
            //       },
            //       child: Container(
            //           color: Colors.transparent,
            //           child: SvgPicture.asset(
            //             AssetsString.aRefresh,
            //             height: 20,
            //           )),
            //     ),
            //     dataList: controller.arrManager,
            //     onSelected: (t) => controller.txtSourcingManager.text =
            //         "${t.firstName!} ${t.lastName}" ?? "",
            //     suggestion: (t) => "${t.firstName!} ${t.lastName}" ?? "",
            //     labelText: "Sourcing Manager",
            //     textController: controller.txtSourcingManager,
            //     validator: (value) => controller.validation(
            //         value, "Please Fill Sourcing Manager")),
            const SizedBox(
              height: 30,
            ),
            leadSource(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Purchase Details",
                  style: semiBoldTextStyle(size: 18),
                ),
                customTypeAheadField(
                  enable: !controller.disableSource.value,
                  labelText: "Booking Source*",
                  validator: (value) => controller.validation(
                      value, "Please Select Booking Source"),
                  textController: controller.txtBookingSource,
                  dataList: controller.arrSource,
                  suggestion: (t) => t.description ?? "",
                  onSelected: (t) {
                    controller.txtBookingSource.text = t.description ?? '';
                    controller.selectedSource.value = t.description ?? '';
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() =>
                (controller.selectedSource.value == "Customer Reference")
                    ? customerReference()
                    : const SizedBox()),
                Obx(() =>
                (controller.selectedSource.value == "Employee Reference")
                    ? employeeReference()
                    : const SizedBox()),
                Obx(() => (controller.selectedSource.value.toLowerCase() ==
                    "channel partner")
                    ? channelPartner()
                    : const SizedBox())
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 30,
                // ),
                purchaseDetails(),
                const SizedBox(
                  height: 30,
                ),
                visitors(),
                const SizedBox(
                  height: 30,
                ),
                budget()
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            isWeb? continuePD():const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget purchaseDetailsView() {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [purchaseDetails(), visitors(), budget()],
      ),
    );
  }

  Widget continuePD() {
    return GestureDetector(
      onTap:() {
        print("cntSVForm.tabIndex.value ");
        print(controller.tabIndex.value);
        if (controller.tabIndex.value < 3) {
          if (controller.tabIndex.value == 1 &&
              controller.personalDetailsFormKey.currentState!.validate()) {
            controller.tabIndex.value = 1;
          }
        }
        // if (cntSVForm.tabIndex.value == 1 &&
        //     cntSVForm.purchaseDetailsFormKey.currentState!.validate()) {
        //   cntSVForm.tabIndex.value = 2;
        // }
        if (controller.tabIndex.value == 1 &&
            controller.personalDetailsFormKey.currentState!.validate()) {
          controller
              .addEditSvFormDetails(SVFormType.personalDetails)
              .then((value) {
            print("jsdhfdjshjfjdjkv");
            print(value);
            if (value) {
              controller.tabIndex.value = 2;
              controller.tabIndex.refresh();
            }
          });
        }
        if (controller.tabIndex.value == 2 &&
            controller.professionalDetailsFormKey.currentState!.validate()) {
          controller.tabIndex.value = 3;
        }
        controller.tabIndex.refresh();
      },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 40,
        color: ColorTheme.cPurple,
        child: const Text(
          "Continue",
          style: TextStyle(
              color: ColorTheme.cWhite,
              fontWeight: FontTheme.fontSemiBold,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget leadSource() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lead Source",
          style: semiBoldTextStyle(size: 18),
        ),
        customTypeAheadField(
          labelText: "How did you come to know about our project?",
          validator: (value) =>
              controller.validation(value, "Please Select Lead Source"),
          textController: controller.txtLeadSource,
          fillColor: ColorTheme.cDisabled,
          dataList: controller.arrSource,
          suggestion: (t) => t.description ?? "",
          onSelected: (t) {
            controller.txtLeadSource.text = t.description ?? '';
            if (controller.txtLeadSource.value.text == "Channel Partner" ||
                controller.txtLeadSource.value.text == "Employee Reference" ||
                controller.txtLeadSource.value.text == "Customer Reference") {
              controller.disableSource.value = true;
              controller.txtBookingSource.text =
                  controller.txtLeadSource.value.text;
            } else {
              controller.disableSource.value = false;
            }
            controller.selectedSource.value =
                controller.txtLeadSource.value.text;
          },
        ),
        /* SizedBox(height: 20,),
        if (controller.txtLeadSource.text == "Customer Reference")
          leadCustomerReference(),
        if(controller.txtLeadSource.text == "Employee Reference")leadEmployeeReference(),
        if(controller.txtLeadSource.text.toLowerCase() == "channel partner")leadChannelPartner(),*/
      ],
    );
  }

  Widget leadCustomerReference() {
    return Container(
      width: isWeb ? textFieldWidth : Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(color: ColorTheme.cDisabled),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              "Customer Referral",
              style: semiBoldTextStyle(
                size: 16,
              ),
            ),
          ),
          customTypeAheadField(
              dataList: controller.arrCustomerRefSearch,
              onSelected: (t) {
                controller.txtLeadCustomerMobileSearch.text =
                    t.custMobPhNumber ?? "";
                controller.retrieveCustomerRefUnit(
                    customerRefMobile: t.custMobPhNumber ?? "",
                    isLeadSource: true);

                ///set state to refresh unit list
              },
              suggestion: (t) => "${t.ownerName ?? ''} (${t.ownerID})",
              labelText: "Customer Mobile*",
              textController: controller.txtLeadCustomerMobileSearch,
              //maxLength: 10,
              textInputType: TextInputType.number,
              inputFormat: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) =>
                  controller.validation(value, "Please enter customer mobile"),
              apiCallback: (e) {
                if (e.length == 10) {
                  return controller.retrieveCustomerRefSearchData(e, "");
                } else {
                  return Future.value([]);
                }
              }),
          customTypeAheadField(
            labelText: "Unit No*",
            textController: controller.txtLeadUnitNo,
            validator: (value) =>
                controller.validation(value, "Please enter Unit No."),
            dataList: controller.arrLeadCustomerRefUnit,
            onSelected: (t) async {
              controller.txtLeadUnitNo.text = t.materialID ?? "";
              await controller
                  .retrieveCustomerRefSearchData(
                  controller.txtLeadCustomerMobileSearch.text,
                  t.materialID ?? "")
                  .whenComplete(() {
                if (controller.arrCustomerRefSearch.isNotEmpty) {
                  controller.txtLeadCustomerId.text =
                      controller.arrCustomerRefSearch[0].ownerID ?? "";
                  controller.txtLeadCustomerName.text =
                      controller.arrCustomerRefSearch[0].ownerName ?? "";
                  controller.txtLeadProjectName.text =
                      controller.arrCustomerRefSearch[0].project ?? "";
                }
              });
              controller.arrCustomerRefSearch.clear();
            },
            suggestion: (t) => t.materialID ?? "",
          ),
          customTextField(
            labelText: "Customer ID",
            controller: controller.txtLeadCustomerId,
            textInputType: TextInputType.number,
            inputFormat: [FilteringTextInputFormatter.digitsOnly],
          ),
          customTextField(
            labelText: "Customer Name*",
            controller: controller.txtLeadCustomerName,
            validator: (value) =>
                controller.validation(value, "Please enter customer name"),
          ),
          customTextField(
            labelText: "Project Name",
            controller: controller.txtLeadProjectName,
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }

  Widget leadEmployeeReference() {
    return Container(
      width: isWeb ? textFieldWidth : Get.width,
      color: ColorTheme.cDisabled,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              "Employee Referral",
              style: semiBoldTextStyle(
                size: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          customTextField(
            labelText: "Employee ID*",
            maxLength: 6,
            controller: controller.txtLeadEmployeeId,
            onChange: (value) {
              if (value.isEmpty) {
                controller.txtLeadEmployeeName.text = "";
                controller.txtLeadEmployeeMobile.text = "";
                controller.txtLeadEmployeeMail.text = "";

                controller.txtEmployeeId.text = '';
                controller.txtEmployeeName.text = "";
                controller.txtEmployeeEmail.text = "";
                controller.txtEmployeeMobile.text = "";
              }
              if (value.length > 5) {
                controller.txtEmployeeId.text = value;
                controller.employeeDetailsApi(true);
              }
            },
            validator: (value) =>
                controller.validation(value, "Please enter employee id"),
          ),
          customTextField(
            labelText: "Employee Name*",
            controller: controller.txtLeadEmployeeName,
            validator: (value) =>
                controller.validation(value, "Please enter employee name"),
          ),
          customTextField(
            labelText: "Employee Mobile",
            controller: controller.txtLeadEmployeeMobile,
            textInputType: TextInputType.number,
            inputFormat: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 10,
          ),
          SizedBox(
            height: 15.h,
          ),
          customTextField(
            labelText: "Employee Email",
            controller: controller.txtLeadEmployeeMail,
            inputFormat: [LowerCaseTextFormatter()],
            validator: (value) {
              bool emailValid = RegExp(
                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
              ).hasMatch(value!);
              if (value.isNotEmpty && !emailValid) {
                return "Please enter your valid email";
              } else {
                return null;
              }
            },
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget leadChannelPartner() {
    return Container(
      width: isWeb ? textFieldWidth : Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      color: ColorTheme.cDisabled,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Text(
                    "Channel Partner",
                    style: semiBoldTextStyle(
                      size: 16,
                    ),
                  )),
              customTypeAheadField(
                labelText: "Channel Partner",
                dataList: controller.arrCPSearchData,
                onSelected: (t) {
                  controller.txtLeadCPCompanyName.text = t.text ?? "";
                  controller.txtLeadCPVendorId.text = t.id ?? "";
                  controller.txtLeadCPRERANo.text = t.rerano ?? "";
                },
                suggestion: (t) => "${t.text} (${t.city})",
                textController: controller.txtLeadCP,
                apiCallback: (t) {
                  if (t.length > 2) {
                    return controller.retrieveCPSearchData(t);
                  } else {
                    return Future.value([]);
                  }
                },
              ),
              customTextField(
                  labelText: "Vendor ID",
                  controller: controller.txtLeadCPVendorId,
                  readOnly: true),
              customTextField(
                labelText: "CP Company Name*",
                validator: (value) {
                  return controller.validation(
                      value, "Please enter CP Company Name");
                },
                controller: controller.txtLeadCPCompanyName,
              ),
              customTextField(
                labelText: controller.txtLeadCP.text.isNotEmpty
                    ? "RERA No."
                    : "RERA No.*",
                validator: (value) {
                  if (value!.isNotEmpty && value.length < 10) {
                    return "Please enter valid rera number";
                  } else if (value.isEmpty) {
                    if (controller.txtLeadCP.text.isEmpty) {
                      return "Please enter rera number";
                    } else {
                      return null;
                    }
                  }
                  return null;
                },
                controller: controller.txtLeadCPRERANo,
              ),
              customTextField(
                labelText: "CP Executive Name*",
                validator: isCPAllow == "1"
                    ? null
                    : (value) {
                  return controller.validation(
                      value, "Please Enter Executive Name");
                },
                textInputType: TextInputType.name,
                inputFormat: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z \u0900-\u097F]")),
                ],
                controller: controller.txtLeadCPExecutive,
              ),
              customTextField(
                labelText: "CP Executive Mobile No*",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Executive Mobile No";
                  } else if (value.length < 10) {
                    return "Please enter valid mobile number";
                  } else {
                    return null;
                  }
                },
                maxLength: 10,
                textInputType: TextInputType.number,
                inputFormat: [FilteringTextInputFormatter.digitsOnly],
                controller: controller.txtLeadCPExecutiveMobile,
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }

  Widget customerReference() {
    return Container(
      width: isWeb ? textFieldWidth : Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      color: ColorTheme.cDisabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Customer Referral",
            style: semiBoldTextStyle(
              size: 16,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          customTypeAheadField(
              dataList: controller.arrCustomerRefSearch,
              onSelected: (t) {
                controller.txtCustomerMobile.text = t.custMobPhNumber ?? "";
                controller.retrieveCustomerRefUnit(
                    customerRefMobile: t.custMobPhNumber ?? "",
                    isLeadSource: false);

                ///set state to refresh unit list
              },
              suggestion: (t) => "${t.ownerName ?? ''} (${t.ownerID})",
              labelText: "Customer Mobile*",
              textController: controller.txtCustomerMobile,
              //maxLength: 10,
              textInputType: TextInputType.number,
              inputFormat: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) =>
                  controller.validation(value, "Please enter customer mobile"),
              apiCallback: (e) {
                if (e.length == 10) {
                  return controller.retrieveCustomerRefSearchData(e, "");
                } else {
                  return Future.value([]);
                }
              }),
          customTypeAheadField(
            labelText: "Unit No*",
            textController: controller.txtCustomerUnitNo,
            validator: (value) =>
                controller.validation(value, "Please enter Unit No."),
            dataList: controller.arrCustomerRefUnit,
            onSelected: (t) async {
              controller.txtCustomerUnitNo.text = t.materialID ?? "";
              await controller
                  .retrieveCustomerRefSearchData(
                  controller.txtCustomerMobile.text, t.materialID ?? "")
                  .whenComplete(() {
                if (controller.arrCustomerRefSearch.isNotEmpty) {
                  controller.txtCustomerId.text =
                      controller.arrCustomerRefSearch[0].ownerID ?? "";
                  controller.txtCustomerName.text =
                      controller.arrCustomerRefSearch[0].ownerName ?? "";
                  controller.txtProjectName.text =
                      controller.arrCustomerRefSearch[0].project ?? "";
                }
              });
              controller.arrCustomerRefSearch.clear();
            },
            suggestion: (t) => t.materialID ?? "",
          ),
          customTextField(
            labelText: "Customer ID",
            inputFormat: [FilteringTextInputFormatter.digitsOnly],
            controller: controller.txtCustomerId,
          ),
          customTextField(
            inputFormat: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
            ],
            labelText: "Customer Name*",
            validator: (value) =>
                controller.validation(value, "Please enter customer name"),
            controller: controller.txtCustomerName,
          ),
          customTextField(
            labelText: "Project Name",
            controller: controller.txtProjectName,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget employeeReference() {
    return Container(
      width: isWeb ? textFieldWidth : Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      color: ColorTheme.cDisabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                "Employee Referral",
                style: semiBoldTextStyle(
                  size: 16,
                ),
              )),
          SizedBox(
            height: 20.h,
          ),
          customTextField(
            maxLength: 6,
            onChange: (value) {
              if (value.isEmpty) {
                controller.txtEmployeeName.text = "";
                controller.txtEmployeeMobile.text = "";
                controller.txtEmployeeEmail.text = "";
              }
              if (value.length > 5) {
                controller.employeeDetailsApi(false);
              }
            },
            labelText: "Employee ID*",
            validator: (value) =>
                controller.validation(value, "Please enter employee id"),
            controller: controller.txtEmployeeId,
          ),
          customTextField(
            labelText: "Employee Name*",
            validator: (value) =>
                controller.validation(value, "Please enter employee name"),
            controller: controller.txtEmployeeName,
          ),
          customTextField(
            textInputType: TextInputType.number,
            inputFormat: [FilteringTextInputFormatter.digitsOnly],
            labelText: "Employee Mobile",
            controller: controller.txtEmployeeMobile,
          ),
          SizedBox(
            height: 15.h,
          ),
          customTextField(
            inputFormat: [
              LowerCaseTextFormatter(),
            ],
            labelText: "Employee Email",
            textInputType: TextInputType.emailAddress,
            validator: (value) {
              bool emailValid = RegExp(
                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
              ).hasMatch(value!);
              if (value.isNotEmpty && !emailValid) {
                return "Please enter your valid email";
              } else {
                return null;
              }
            },
            controller: controller.txtEmployeeEmail,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget channelPartner() {
    return Container(
      width: isWeb ? textFieldWidth : Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      color: ColorTheme.cDisabled,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Text(
                    "Channel Partner",
                    style: semiBoldTextStyle(
                      size: 16,
                    ),
                  )),
              customTypeAheadField(
                labelText: "Channel Partner",
                dataList: controller.arrCPSearchData,
                onSelected: (t) {
                  controller.txtCPCompanyName.text = t.text ?? "";
                  controller.txtCPVendorId.text = t.id ?? "";
                  controller.txtCPRERANo.text = t.rerano ?? "";
                },
                suggestion: (t) => "${t.text} (${t.city})",
                textController: controller.txtCP,
                apiCallback: (t) {
                  if (t.length > 2) {
                    return controller.retrieveCPSearchData(t);
                  } else {
                    return Future.value([]);
                  }
                },
              ),
              customTextField(
                  labelText: "Vendor ID",
                  controller: controller.txtCPVendorId,
                  readOnly: true),
              customTextField(
                labelText: "CP Company Name*",
                validator: (value) {
                  return controller.validation(
                      value, "Please enter CP Company Name");
                },
                controller: controller.txtCPCompanyName,
              ),
              customTextField(
                labelText:
                controller.txtCP.text.isNotEmpty ? "RERA No." : "RERA No.*",
                validator: (value) {
                  if (value!.isNotEmpty && value.length < 10) {
                    return "Please enter valid rera number";
                  } else if (value.isEmpty) {
                    if (controller.txtCP.text.isEmpty) {
                      return "Please enter rera number";
                    } else {
                      return null;
                    }
                  }
                  return null;
                },
                controller: controller.txtCPRERANo,
              ),
              customTextField(
                labelText: "CP Executive Name*",
                validator: isCPAllow == "1"
                    ? null
                    : (value) {
                  return controller.validation(
                      value, "Please Enter Executive Name");
                },
                textInputType: TextInputType.name,
                inputFormat: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp("[a-zA-Z \u0900-\u097F]")),
                ],
                controller: controller.txtCPExecutive,
              ),
              customTextField(
                labelText: "CP Executive Mobile No*",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Executive Mobile No";
                  } else if (value.length < 10) {
                    return "Please enter valid mobile number";
                  } else {
                    return null;
                  }
                },
                maxLength: 10,
                textInputType: TextInputType.number,
                inputFormat: [FilteringTextInputFormatter.digitsOnly],
                controller: controller.txtCPExecutiveMobile,
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }

  Widget purchaseDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (!isPurchaseDetailsPage)
        //   Text(
        //     "Purchase Details",
        //     style: TextStyle(
        //         color: ColorTheme.cFontWhite,
        //         fontWeight: FontTheme.fontSemiBold,
        //         fontSize: 18),
        //   ),
        // if (!isPurchaseDetailsPage)
        //   const SizedBox(
        //     height: 10,
        //   ),
        customTypeAheadField(
          labelText: "Purpose of Purchase*",
          validator: (value) =>
              controller.validation(value, "Please Select Purpose of Purchase"),
          textController: controller.txtPurchasePurpose,
          dataList: controller.arrPurpose,
          suggestion: (t) => t.description ?? "",
          onSelected: (t) =>
          controller.txtPurchasePurpose.text = t.description ?? '',
        ),
        customTypeAheadField(
          labelText: "Need Home Loan?",
          textController: controller.txtHomeLoan,
          dataList: controller.arrNeedLoan,
          suggestion: (t) => t.description ?? "",
          onSelected: (t) => controller.txtHomeLoan.text = t.description ?? '',
        ),
      ],
    );
  }

  Widget budget() {
    return SizedBox(
      width: isWeb ? textFieldWidth : Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 20,
          // ),
          if (isPurchaseDetailsPage || isWeb)
            Text(
              "Budget",
              style: TextStyle(
                  color: ColorTheme.cFontWhite,
                  fontWeight: FontTheme.fontSemiBold,
                  fontSize: 18),
            ),
          if (isPurchaseDetailsPage || isWeb)
            const SizedBox(
              height: 10,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Selected Budget: ",
                style: mediumTextStyle(color: ColorTheme.cFontWhite, size: 16),
              ),
              Obx(() => Text(
                controller.formatValue(controller.indicatorValue.value),
                style: semiBoldTextStyle(
                    color: ColorTheme.cAppTheme, size: 18),
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            String label =
            controller.formatValue(controller.indicatorValue.value);
            if (controller.indicatorValue.value == controller.minBudget.value) {
              label = "<$label";
            }
            if (controller.indicatorValue.value == controller.maxBudget.value) {
              label = ">$label";
            }

            if (label.contains("T")) {
              label = label.replaceAll("T", "K");
            }
            return SliderTheme(
              data: SliderThemeData(
                trackHeight: 5,
                // thumbShape:
                //     CustomSliderThumb(height: 30, label: label.toUpperCase()),
              ),
              child: Slider(
                  max: controller.maxBudget.value,
                  min: controller.minBudget.value,
                  activeColor: ColorTheme.cPurple,
                  inactiveColor: ColorTheme.cLineColor,
                  divisions: 98,

                  // label: label,
                  value: controller.indicatorValue.value,
                  onChanged: (value) {
                    controller.indicatorValueChange(value);
                  }),
            );
          }),
        ],
      ),
    );
  }

  Widget visitors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isPurchaseDetailsPage)
          Text(
            "Visitors",
            style: TextStyle(
                color: ColorTheme.cFontWhite,
                fontWeight: FontTheme.fontSemiBold,
                fontSize: 18),
          ),
        if (!isPurchaseDetailsPage)
          const SizedBox(
            height: 10,
          ),
        responsiveRowColumn(
          widget1: customTypeAheadField(
            labelText: "Visitors*",
            validator: (value) =>
                controller.validation(value, "Please Select SV Attendee"),
            textController: controller.txtSVAttendee,
            dataList: controller.arrAttendee,
            suggestion: (e) => e.description!,
            onSelected: (t) =>
            controller.txtSVAttendee.text = t.description ?? '',
          ),
          widget2: customTypeAheadField(
            labelText: "Configuration",
            textController: controller.txtConfiguration,
            dataList: controller.arrConfiguration,
            suggestion: (e) => e.description!,
            onSelected: (t) =>
            controller.txtConfiguration.text = t.description ?? '',
          ),
        ),
      ],
    );
  }
}
