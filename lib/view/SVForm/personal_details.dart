import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:pinput/pinput.dart';

import '../../config/Helper/common_api.dart';
import '../../config/Helper/function.dart';
import '../../config/utils/constant.dart';
import '../../controller/SVFormController/sv_form_controller.dart';
import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/comon_type_ahead_field.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/multi_select_dropdown.dart';

class PersonalDetails extends GetView<SiteVisitFormController> {
  final bool isPurchaseDetailsPage;

  const PersonalDetails(
      {super.key,
      this.isPurchaseDetailsPage = true,
      required this.controllerc});

  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SiteVisitFormController controllerc;

  @override
  Widget build(BuildContext context) {
    controller.update();
    if (isWeb) {
      controller.professionalDetailsFormKey = GlobalKey<FormState>();
      controller.personalDetailsFormKey = GlobalKey<FormState>();
    }
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
                  retrieveTitleList();
                },
                child: Container(
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    AssetsString.aRefresh,
                    height: 20,
                  ),
                ),
              ),
              dataList: arrTitle,
              suggestion: (t) => t.description ?? '',
              onSelected: (t) => controller.txtTitle.text = t.description ?? "",
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
            ),
            customTextField(
              labelText: "Email*",
              textCapitalization: TextCapitalization.words,
              maxLength: 72,
              textInputType: TextInputType.emailAddress,
              hintText: "Email",
              inputFormat: <TextInputFormatter>[
                // FilteringTextInputFormatter.allow(
                //     emailValid),
                // CustomTextInputFormatter()
              ],
              validator: (value) => emailValidation(value),
              controller: controller.txtEmail,
            ),
            responsiveRowColumn(
              widget1: customTextField(
                labelText: 'Mobile*',
                validator: (value) => controller.validation(
                    value, 'Please Fill Valid Mobile Number'),
                enabled: false,
                controller: controller.txtMobileNo,
                prefixWidget:
                    countryCodeDropDown(countryObj: controller.objCountry),
                //mainTextFieldColor: ColorTheme.cEnabled,
                inputFormat: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
              ),
              widget2: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => SizedBox(
                          width: 20,
                          child: Checkbox(
                            activeColor: ColorTheme.cAppTheme,
                            side: WidgetStateBorderSide.resolveWith(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.selected)) {
                                  return const BorderSide(
                                      color: Colors.transparent);
                                }
                                return null;
                              },
                            ),
                            value: controller.checkWhatsapp.value,
                            onChanged: (value) {
                              controller.checkWhatsapp.value = value!;
                              //  cntAddEdit.checkWhatsapp.refresh();

                              if (controller.checkWhatsapp.value &&
                                  controller.txtMobileNo.text.isNotEmpty) {
                                controller.txtWhatsappNumber.text =
                                    controller.txtMobileNo.text;
                                /*controller.objTelCountry =
                                  cntAddEdit.objCountry.value.countryCode;*/
                              } else {
                                controller.txtWhatsappNumber.text = '';
                                /*cntAddEdit.objWPCountry.value =
                                  arrCountry.singleWhere((element) =>
                                  element.code?.toUpperCase() == 'IN');*/
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Same As Mobile',
                        style:
                            mediumTextStyle(color: ColorTheme.cWhite, size: 16),
                      ),
                    ],
                  ),
                  Obx(() => customTextField(
                        width: Get.width,
                        readOnly: controller.checkWhatsapp.value == true &&
                                    controller
                                        .txtWhatsappNumber.text.isNotEmpty ||
                                controller.txtWhatsappNumber.text.isNotEmpty
                            ? true
                            : false,
                        labelText: 'WhatsApp No.*',
                        controller: controller.txtWhatsappNumber,
                        enabled: controller.checkWhatsapp.value == true &&
                                controller.txtWhatsappNumber.text.isNotEmpty
                            ? false
                            : true,
                        onChange: (value) {
                          controller.whatsappNumber.value = value;
                        },
                        textInputType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputFormat: [FilteringTextInputFormatter.digitsOnly],
                        maxLength:
                            controller.objCountry.value.countryCode == '+91'
                                ? 10
                                : 15,
                        prefixWidget: countryCodeDropDown(
                            countryObj: controller.objCountry),
                      )),
                ],
              ),
            ),
            // Row(children: [
            //   customTextField(
            //     labelText: 'Mobile*',
            //     validator: (value) => controller.validation(
            //         value, 'Please Fill Valid Mobile Number'),
            //     enabled: false,
            //     controller: controller.txtMobileNo,
            //     prefixWidget:
            //     countryCodeDropDown(countryObj: controller.objCountry),
            //     //mainTextFieldColor: ColorTheme.cEnabled,
            //     inputFormat: [FilteringTextInputFormatter.digitsOnly],
            //     maxLength: 10,
            //   ),
            //   Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Obx(
            //                 () => SizedBox(
            //               width: 20,
            //               child: Checkbox(
            //                 activeColor: ColorTheme.cAppTheme,
            //                 side: MaterialStateBorderSide.resolveWith(
            //                       (Set<MaterialState> states) {
            //                     if (states.contains(MaterialState.selected)) {
            //                       return const BorderSide(
            //                           color: Colors.transparent);
            //                     }
            //                   },
            //                 ),
            //                 value: controller.checkWhatsapp.value,
            //                 onChanged: (value) {
            //                   controller.checkWhatsapp.value = value!;
            //                   //  cntAddEdit.checkWhatsapp.refresh();
            //
            //                   if (controller.checkWhatsapp.value &&
            //                       controller.txtMobileNo.text.isNotEmpty) {
            //                     controller.txtWhatsappNumber.text =
            //                         controller.txtMobileNo.text;
            //                     /*controller.objTelCountry =
            //                       cntAddEdit.objCountry.value.countryCode;*/
            //                   } else {
            //                     controller.txtWhatsappNumber.text = '';
            //                     /*cntAddEdit.objWPCountry.value =
            //                       arrCountry.singleWhere((element) =>
            //                       element.code?.toUpperCase() == 'IN');*/
            //                   }
            //                 },
            //               ),
            //             ),
            //           ),
            //           const SizedBox(
            //             width: 5,
            //           ),
            //           Text(
            //             'Same As Mobile',
            //             style:
            //             mediumTextStyle(color: ColorTheme.cWhite, size: 16),
            //           ),
            //         ],
            //       ),
            //       Obx(() => customTextField(
            //         readOnly: controller.checkWhatsapp.value == true &&
            //             controller
            //                 .txtWhatsappNumber.text.isNotEmpty ||
            //             controller.txtWhatsappNumber.text.isNotEmpty
            //             ? true
            //             : false,
            //         labelText: 'WhatsApp No.*',
            //         controller: controller.txtWhatsappNumber,
            //         enabled: controller.checkWhatsapp.value == true &&
            //             controller.txtWhatsappNumber.text.isNotEmpty
            //             ? false
            //             : true,
            //         onChange: (value) {
            //           controller.whatsappNumber.value = value;
            //         },
            //         textInputType: const TextInputType.numberWithOptions(
            //             signed: true, decimal: true),
            //         inputFormat: [FilteringTextInputFormatter.digitsOnly],
            //         maxLength:
            //         controller.objCountry.value.countryCode == '+91'
            //             ? 10
            //             : 15,
            //         prefixWidget: countryCodeDropDown(
            //             countryObj: controller.objCountry),
            //       )),
            //     ],
            //   ),
            // ],),
            customTextField(
                labelText: "Res. Telephone Number",
                controller: controller.txtTelephoneNo,
                textInputType: TextInputType.number,
                inputFormat: [FilteringTextInputFormatter.digitsOnly],
                hintText: "9876543210",
                maxLength: 10,
                prefixWidget:
                    countryCodeDropDown(countryObj: controller.objResCountry)),
            customTypeAheadField(
                refreshWidget: GestureDetector(
                  onTap: () {
                    retrieveAgeList();
                  },
                  child: Container(
                      color: Colors.transparent,
                      child: SvgPicture.asset(
                        AssetsString.aRefresh,
                        height: 20,
                      )),
                ),
                dataList: arrAgeGroup,
                onSelected: (t) {
                  controller.txtAgeGroup.text = t.description ?? "";
                  controller.txtAgeGroup.text = t.description ?? '';
                  controller.objAgeGroup.value = t;
                  controller.objAgeGroup.refresh();
                },
                suggestion: (t) => t.description ?? "",
                labelText: "Age Group*",
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
                  textInputType: TextInputType.number,
                  hintText: "Area Pincode",
                  inputFormat: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp("[a-zA-Z0-9 \u0900-\u097F]")),
                  ]),
            ),
            multiSelectDropDown(
              label: 'Sourcing Manager',
              list: arrEmployee,
              selectedList: controller.arrSelectedSourcingManager,
              suggestion: (p) => p.empFormattedName,
            ),
            const SizedBox(
              height: 30,
            ),
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
                    labelText: 'Site Visit Source*',
                    validator: (value) => controller.validation(
                        value, 'Please Select Site Visit Source'),
                    textController: controller.txtSource,
                    dataList: arrLeadSource,
                    suggestion: (t) => t.description ?? '',
                    onSelected: (t) {
                      controller.txtSource.text = t.description ?? '';
                      controller.objSource.value = t;
                      controller.objSource.refresh();
                    },
                    refreshWidget:
                        RefreshButton(onTap: () => retrieveLeadSourceList())),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => controller.objSource.value.description == null
                    ? const SizedBox.shrink()
                    : controller.objSource.value.description!.toUpperCase() ==
                            'Customer Reference'.toUpperCase()
                        ? customerReference()
                        : (controller.objSource.value.description!
                                    .toUpperCase() ==
                                'Employee Reference'.toUpperCase()
                            ? employeeReference()
                            : controller.objSource.value.description!
                                        .toUpperCase() ==
                                    'channel partner'.toUpperCase()
                                ? channelPartner()
                                : const SizedBox.shrink())),
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
                budget()
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            isWeb ? continuePD() : const SizedBox()
          ],
        ),
      ),
    );
  }

  // Widget purchaseDetailsView() {
  //   return Padding(
  //     padding: EdgeInsets.all(10.w),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [purchaseDetails(), visitors(), budget()],
  //     ),
  //   );
  // }
  Widget continuePD() {
    return GestureDetector(
      onTap: () {
        if (controller.personalDetailsFormKey.currentState!.validate()) {
          controller.commonNextTap();
        }
      },
      // onTap:() {
      //   if (controller.tabIndex.value < 3) {
      //     if (controller.tabIndex.value == 1 &&
      //         controller.personalDetailsFormKey.currentState!.validate()) {
      //       controller.tabIndex.value = 1;
      //     }
      //   }
      //   // if (cntSVForm.tabIndex.value == 1 &&
      //   //     cntSVForm.purchaseDetailsFormKey.currentState!.validate()) {
      //   //   cntSVForm.tabIndex.value = 2;
      //   // }
      //   if (controller.tabIndex.value == 1 &&
      //       controller.personalDetailsFormKey.currentState!.validate()) {
      //     controller
      //         .addEditSvFormDetails(SVFormType.personalDetails)
      //         .then((value) {
      //       if (value) {
      //         controller.tabIndex.value = 2;
      //         controller.tabIndex.refresh();
      //       }
      //     });
      //   }
      //   if (controller.tabIndex.value == 2 &&
      //       controller.professionalDetailsFormKey.currentState!.validate()) {
      //     controller.tabIndex.value = 3;
      //   }
      //   controller.tabIndex.refresh();
      // },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 40,
        color: ColorTheme.cAppTheme,
        child:   Text(
          "Next",
          style: TextStyle(
              color: ColorTheme.cWhite,
              fontWeight: FontTheme.fontSemiBold,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget customerReference() {
    return Container(
      width: isMobile ? Get.width : textFieldWidth,
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
            'Customer Referral',
            style: semiBoldTextStyle(
              size: 16,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          customTextField(
            labelText: 'Customer Mobile*',
            validator: (value) =>
                controller.validation(value, 'Please Fill Valid Mobile Number'),
            controller: controller.txtCustomerMobile,
            prefixWidget:
                countryCodeDropDown(countryObj: controller.objCountry),
            //mainTextFieldColor: ColorTheme.cEnabled,
            inputFormat: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 10,
            onChange: (value) {
              if (controller.txtCustomerMobile.length == 10) {
                controller.getCustomerReferral();
              } else {
                controller.txtCustomerId.text = '';
                controller.txtCustomerName.text = '';
              }
            },
          ),
          /*customTypeAheadField(
              dataList: arrCustomerRefSearch,
              onSelected: (t) {
                controller.txtCustomerMobile.text = t.custMobPhNumber ?? "";
                retrieveCustomerRefUnit(
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
                  return retrieveCustomerRefSearchData(e, "");
                } else {
                  return Future.value([]);
                }
              })*/
          /* customTypeAheadField(
            labelText: "Unit No",
            textController: controller.txtCustomerUnitNo,
            */
          /*validator: (value) =>
                controller.validation(value, "Please enter Unit No."),*/
          /*
            dataList: controller.arrCustomerRefUnit,
            onSelected: (t) async {
              controller.txtCustomerUnitNo.text = t.materialID ?? "";
              */
          /*await retrieveCustomerRefSearchData(
                  controller.txtCustomerMobile.text, t.materialID ?? "")
                  .whenComplete(() {
                if (arrCustomerRefSearch.isNotEmpty) {
                  controller.txtCustomerId.text =
                      arrCustomerRefSearch[0].ownerID ?? "";
                  controller.txtCustomerName.text =
                      arrCustomerRefSearch[0].ownerName ?? "";
                  controller.txtProjectName.text =
                      arrCustomerRefSearch[0].project ?? "";
                }
              });
              arrCustomerRefSearch.clear();*/
          /*
            },
            suggestion: (t) => t.materialID ?? "",
          )*/
          customTextField(
            labelText: 'Unit No',
            controller: controller.txtCustomerUnitNo,
          ),
          customTextField(
            labelText: 'Customer ID',
            inputFormat: [FilteringTextInputFormatter.digitsOnly],
            controller: controller.txtCustomerId,
          ),
          customTextField(
            inputFormat: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
            ],
            labelText: 'Customer Name',
            /*validator: (value) =>
                controller.validation(value, "Please enter customer name"),*/
            controller: controller.txtCustomerName,
          ),
          customTextField(
            labelText: 'Project Name',
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
      width: isMobile ? Get.width : textFieldWidth,
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
              child: Text('Employee Referral',
                  style: semiBoldTextStyle(size: 16))),
          SizedBox(
            height: 20.h,
          ),
          customTypeAheadField(
              hintStyle: TextStyle(color: Colors.grey[600]),
              labelText: 'Employee ID*',
              textController: controller.txtEmployeeId,
              dataList: controller.arrEmployee,
              suggestion: (e) => e.employeeId,
              onSelected: (t) async {
                controller.txtEmployeeId.text = t.employeeId ;

                await controller.getEmployeeSearch();
              },
              validator: (value) =>
                  controller.validation(value, 'Please select employee id'),
              fillColor: ColorTheme.cThemeCard),
          customTextField(
            maxLength: 6,
            onChange: (value) {
              if (value.isEmpty) {
                controller.txtEmployeeName.text = '';
                controller.txtEmployeeMobile.text = '';
                controller.txtEmployeeEmail.text = '';
              }
              if (value.length > 5) {
                employeeDetailsApi(false, controller.txtEmployeeId.text.trim());
              }
            },
            labelText: 'Employee Name',
            controller: controller.txtEmployeeName,
          ),
          customTextField(
            textInputType: TextInputType.number,
            inputFormat: [FilteringTextInputFormatter.digitsOnly],
            labelText: 'Employee Mobile',
            controller: controller.txtEmployeeMobile,
          ),
          SizedBox(
            height: 5.h,
          ),
          customTextField(
            inputFormat: [
              LowerCaseTextFormatter(),
            ],
            labelText: 'Employee Email',
            textInputType: TextInputType.emailAddress,
            validator: emailValidation,
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
      width: isMobile ? Get.width : textFieldWidth,
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
                    'Channel Partner',
                    style: semiBoldTextStyle(
                      size: 16,
                    ),
                  )),
              InkWell(
                onTap: () {
                  controller.txtCPCompanyName.clear();
                },
                /*   customTypeAheadField(
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    labelText: "Channel Partner*",
                    textController: controller.txtCPCompanyName,
                    dataList: controller.arrChannelList,
                    suggestion: (e) => e.companyDescription!,
                    onSelected: (t) async {
                      controller.txtCPCompanyName.text = t.firstName ?? "";

                      await controller.getChannelSearch();
                    },
                    validator: (value) =>
                        validation(value, "Please select employee id"),
                    fillColor: ColorTheme.cThemeCard),*/
                child: customTypeAheadField(
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    labelText: 'Channel Partner*',
                    textController: controller.txtCPCompanyName,
                    dataList: controller.arrChannelList,
                    suggestion: (e) => e.companyDescription!,
                    onSelected: (t) async {
                      controller.objChannel.value = t;
                      controller.txtCpUserName.text = t.firstName ?? '';

                      await controller.getChannelSearch();
                    },
                    validator: (value) => controller.validation(
                        value, 'Please select employee id'),
                    fillColor: ColorTheme.cThemeCard),
              ),
              customTextField(
                labelText: 'Vendor ID',
                validator: (value) {
                  if (value!.isNotEmpty && value.length < 10) {
                    return 'Please enter valid Vendor Id';
                  } else if (value.isEmpty) {
                    if (controller.txtCPVendorId.text.isEmpty) {
                      return 'Please enter Vendor Id';
                    } else {
                      return null;
                    }
                  } else {
                    return null;
                  }
                },
                controller: controller.txtCPVendorId,
              ),
              customTextField(
                labelText: 'CP Company Name',
                /* validator: (value) {
                  return controller.validation(
                      value, "Please enter CP Company Name");
                },*/
                controller: controller.txtCPCompanyName,
              ),
              customTextField(
                labelText:
                    controller.txtCP.text.isNotEmpty ? 'RERA No.' : 'RERA No.',
                /* validator: (value) {
                  if (value!.isNotEmpty && value.length < 10) {
                    return "Please enter valid rera number";
                  } else if (value.isEmpty) {
                    if (controller.txtCP.text.isEmpty) {
                      return "Please enter rera number";
                    } else {
                      return null;
                    }
                  } else {
                    return null;
                  }
                },*/
                controller: controller.txtCPReraNo,
              ),
              customTextField(
                labelText: 'CP Executive Name',
                /* validator: isCPAllow == "1"
                    ? null
                    : (value) {
                        return controller.validation(
                            value, "Please Enter Executive Name");
                      },*/
                textInputType: TextInputType.name,
                inputFormat: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp('[a-zA-Z \u0900-\u097F]')),
                ],
                controller: controller.txtCpUserName,
              ),
              customTextField(
                labelText: 'CP Executive Mobile No*',
                /*  validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Executive Mobile No";
                  } else if (value.length < 10) {
                    return "Please enter valid mobile number";
                  } else {
                    return null;
                  }
                },*/
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
        customTypeAheadField(
            labelText: 'Purpose of Purchase*',
            validator: (value) => controller.validation(
                value, 'Please Select Purpose of Purchase'),
            textController: controller.txtPurchasePurpose,
            dataList: arrPurPoseOfPurchaseList,
            suggestion: (t) => t.description ?? '',
            onSelected: (t) {
              controller.txtPurchasePurpose.text = t.description ?? '';
              controller.objPurpose.value = t;
              controller.objPurpose.refresh();
            },
            refreshWidget:
                RefreshButton(onTap: () => retrievePurposeOfPurChase())),
      ],
    );
  }

  Widget budget() {
    return SizedBox(
      width: isWeb ? textFieldWidth : Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTypeAheadField(
            refreshWidget: GestureDetector(
              onTap: () {
                retrieveBudgetList();
              },
              child: Container(
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    AssetsString.aRefresh,
                    height: 20,
                  )),
            ),
            labelText: 'Budget',
            textController: controller.txtBudget,
            dataList: arrBudget,
            suggestion: (e) => e.description!,
            onSelected: (t) {
              controller.txtBudget.text = t.description ?? '';
              controller.objBudget.value = t;
              controller.objBudget.refresh();
            },
          )
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
              onSelected: (t) {
                controller.txtSVAttendee.text = t.description ?? '';
                controller.objAttendee.value = t;
              }),
          widget2: customTypeAheadField(
            labelText: "Configuration",
            textController: controller.txtConfiguration,
            dataList: arrConfiguration,
            suggestion: (e) => e.description!,
            onSelected: (t) {
              controller.txtConfiguration.text = t.description ?? '';
              controller.objConfiguration.value = t;
              controller.objConfiguration.refresh();
            },
          ),
        ),
      ],
    );
  }
}
