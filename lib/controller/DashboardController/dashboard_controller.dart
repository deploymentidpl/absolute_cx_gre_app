import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/model/OwnerDataModel/owner_data_model.dart';
import 'package:greapp/style/assets_string.dart';
import 'package:greapp/style/theme_color.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../model/SVCountsModel/sv_counts_model.dart';
import '../../model/SVWaitListModel/sv_wait_list_model.dart';
import '../../model/SourceWiseSVCountModel/source_wise_sv_count_model.dart';

class DashboardController extends GetxController {
  RxInt svCount = 27.obs;
  RxList<SVCountsModel> svList = RxList([]);
  RxList<OwnerDataListModel> ownerDataList = RxList([]);
  RxList<SourceWiseSVCountModel> sourceWiseSVCountList = RxList([]);
  RxList<SVWaitListModel> svWaitList = RxList([]);
  RxBool showOverAllSVChart = true.obs;
  RxBool showSVWaitListChart = true.obs;
  RxBool assignedSV = true.obs;
  Rx<SizingInformation> sizingInformation = SizingInformation(
    deviceScreenType: DeviceScreenType.mobile,
    refinedSize: RefinedSize.large,
    screenSize: Size(350, 750), localWidgetSize: Size(30,40),
  ).obs;

  DashboardController() {
    getSVList();
    getOwnerDataList();
    getSourceWiseSVCountList();
    getSVWaitList();
  }

  getSVList() {
    svList.addAll(SVCountsBaseModel.fromJson({
      "success": true,
      "message": "Data found",
      "data": [
        {
          "Lable": [
            "9am-10am",
            "10am-11am",
            "11am-12pm",
            "12pm-1pm",
            "1pm-2pm",
            "2pm-3pm",
            "3pm-4pm",
            "4pm-5pm",
            "5pm-6pm",
            "6pm-7pm",
            "7pm-8pm",
            "8pm-9pm"
          ],
          "Count": [0, 4, 8, 5, 0, 6, 6, 3, 3, 2, 1, 0]
        }
      ]
    }).data);
  }

  getOwnerDataList() {
    ownerDataList.addAll(OwnerDataBaseModel.fromJson({
      "success": true,
      "message": "Data found",
      "data": [
        {
          "ownerdata": [
            {"id": "8000000057", "name": "Rohit Singh"},
            {"id": "8000000232", "name": "Cluster Head"},
            {"id": "8000000098", "name": "Ajay Sharma"},
            {"id": "8000000105", "name": "Vishnu Jain"},
            {"id": "8000000053", "name": "Shekhar Singh"},
            {"id": "8000000085", "name": "A Abhinav"},
            {"id": "8000000082", "name": "Amit Dhoot"},
            {"id": "8000000102", "name": "Aditi Sharma"},
            {"id": "8000000091", "name": "test678 test"},
            {"id": "8000000056", "name": "madhu Rao"},
            {"id": "8000000108", "name": "Varun Sharma"},
            {"id": "8000000094", "name": "Shruti Jain"},
            {"id": "8000001397", "name": "Babu Vigneshwar J"},
            {"id": "8000009550", "name": "GURU PRASAD"},
            {"id": "8000009700", "name": "Haseena M"},
            {"id": "8000000553", "name": "Srinivasa Rao"},
            {"id": "8000000550", "name": "Ramu Gajula"},
            {"id": "8000000560", "name": "Shekina Victor S"},
            {"id": "8000000989", "name": "A Saravanan"},
            {"id": "8000001149", "name": "Dinesh G"},
            {"id": "8000001206", "name": "Ajit Kumar Sahoo"},
            {"id": "8000001226", "name": "Ajay Gope"},
            {"id": "8000001335", "name": "Srinivas H G"},
            {"id": "8000001473", "name": "Bhallal Dev"},
            {"id": "80003000560", "name": "Ravi Kumar T"},
            {"id": "REC789878", "name": "RECEPTIONIST DEV"}
          ],
          "count": [
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            5,
            11,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0
          ]
        }
      ]
    }).data);
  }

  getSourceWiseSVCountList() {
    sourceWiseSVCountList.addAll(SourceWiseSVCountBaseModel.fromJson({
      "success": true,
      "message": "Data found",
      "data": [
        {"Source": "Direct", "Count": 2, "Percentage": 100, "Code": "Z00"},
        {
          "Source": "Channel Partner",
          "Count": 0,
          "Percentage": 0,
          "Code": "Z15"
        },
        {
          "Source": "Customer Reference",
          "Count": 0,
          "Percentage": 0,
          "Code": "Z03"
        },
        {
          "Source": "Employee Reference",
          "Count": 0,
          "Percentage": 0,
          "Code": "Z04"
        }
      ]
    }).data);
  }

  getSVWaitList() {
    svWaitList.addAll(SVWaitListBaseModel.fromJson({
      "SVWaitlist": [
        {
          "order": 4324,
          "token": "#707",
          "owner": {
            "name": "Addison Doe",
            "image": "url_to_image",
            "claim": true
          },
          "details": {"priority": 10, "id": "#20187", "cp": true},
          "status": "",
          "project": {
            "location": "Andheri East, Mumbai, Maharashtra",
            "project_name": "ACX Sydney",
            "bhk": "4 BHK",
            "price": "1.75-2 Cr."
          },
          "source": {"icon":AssetsString.aDummyNews, "name": ""},
          "sourcing_manager": {
            "name": "Rebecca Adams",
            "image":  AssetsString.aDummySM1
          },
          "date": {"start_date": "2024-05-08T11:18:45.000000Z", "end_date": "2024-06-10T07:18:20.000000Z"}
        },
        {
          "order": 4325,
          "token": "#708",
          "owner": {
            "name": "Joey Doe",
            "image": AssetsString.aDummyProfile3,
            "claim": false
          },
          "details": {"priority": 3, "id": "#20189", "cp": false},
          "status": "SV Scheduled",
          "project": {
            "location": "Andheri West, Mumbai, Maharashtra",
            "project_name": "ACX Hueston",
            "bhk": "1 BHK",
            "price": "25-50 Lakhs"
          },
          "source": {"icon": AssetsString.aDummyFB, "name": "Facebook"},
          "sourcing_manager": {"name": "Daniel White", "image": AssetsString.aDummySM2},
          "date": {"start_date": "2024-05-08T11:18:45.000000Z", "end_date": "2024-06-10T07:18:20.000000Z"}
        },
        {
          "order": 4326,
          "token": "#709",
          "owner": {
            "name": "Alex Doe",
            "image": AssetsString.aDummyProfile2,
            "claim": false
          },
          "details": {
            "priority": 1,
            "id": "#20297",
            "cp": false,
            "missed_call": true
          },
          "status": "SV Scheduled",
          "project": {
            "location": "Ville Parle West, Mumbai, Maharashtra",
            "project_name": "ACX Paris",
            "bhk": "3 BHK",
            "price": "1.25-1.5 Cr."
          },
          "source": {"icon": AssetsString.aDummyB, "name": "B"},
          "sourcing_manager": {
            "name": "Stanley Brown",
            "image": AssetsString.aDummySM3
          },
          "date": {"start_date": "2024-05-08T11:18:45.000000Z", "end_date": "2024-06-10T07:18:20.000000Z"}
        }
      ]
    }).data);
  }

  Color getRandomColor() {
    List<Color> colors = [
      ColorTheme.cLeadScore,
      ColorTheme.cBrown,
      ColorTheme.cDeepRed
    ];

    final random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }
}
