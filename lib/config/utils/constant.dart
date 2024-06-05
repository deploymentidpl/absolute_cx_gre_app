import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:greapp/config/Helper/size_config.dart';

import '../../model/common_model.dart';

const apiKey = "key_api";
bool isMobile = false;
bool isCompact = false;
bool isTablet = false;
bool isWeb = false;

String kOwnerPartyID = "8000000550";
String kOwnerPartyName = "Ramu Gajula";
String kLocationCode = "1707";

double kAppBarHeight = 65;
double kWebBarHeight = 120;

double textFieldWidth = 500;

String commonMessage = "";
String timezone = "";
RxInt svOwnedCount = 0.obs;
RxInt svWaitCount = 0.obs;
const appBarHeight = 55.0;
double stickyButtonHeight = 45.w;

double screenWidth = 0;
double screenHeight = 0;

String isCPAllow = "0";


RxList<CommonModel> arrCountry = RxList([]);


enum LeadAction { leadAdd, leadEdit }


const SizedBox sizedBox10 = SizedBox(height: 10);
const SizedBox sizedBox16 = SizedBox(height: 16);
const SizedBox sizedBox8 = SizedBox(height: 8);
const SizedBox sizedBox24 = SizedBox(height: 24);
const SizedBox sizedBox32 = SizedBox(height: 32);
const SizedBox sizedBox40 = SizedBox(height: 40);

enum AllowedFileTypes { image, document, any }

final formatterAadhaarLength = LengthLimitingTextInputFormatter(12);
final formatterOTPLength = LengthLimitingTextInputFormatter(6);
final formatterPanCardLength = LengthLimitingTextInputFormatter(10);
final formatterPostalCodeLength = LengthLimitingTextInputFormatter(6);
final formatterIFSCCodeLength = LengthLimitingTextInputFormatter(11);
final formatterDigitsOnly = FilteringTextInputFormatter.digitsOnly;
final formatterAmount =
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));
final formatterDenySpace = FilteringTextInputFormatter.deny(RegExp(r'\s'));
final formatterAllowSpace = FilteringTextInputFormatter.allow(RegExp(r'\s'));
final formatterAllowOnlyAlphanumeric =
    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"));
final formatterAllowOnlyAlphanumericWithAtSymbol =
    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@]"));
final formatterAllowOnlyAlphabets =
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"));
final formatterAllowOnlyAlphabetsWithSpace =
    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z][a-zA-Z\s]*$'));
final formatterAllowAlphabetsAndOtherCharacters =
    FilteringTextInputFormatter.allow(RegExp(r'[.,\-_:;A-Za-z\s]+'));
final formatterAllowOnlyAlphaNumericWithSpace =
    FilteringTextInputFormatter.allow(RegExp(r'^[0-9a-zA-Z\s]*$'));
final formatterAllowOnlyAlphaNumericWithSpaceAndDot =
    FilteringTextInputFormatter.allow(RegExp(r'^[.0-9a-zA-Z\s]*$'));
