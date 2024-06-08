import 'package:get/get.dart';
import 'package:greapp/model/OwnerDataModel/owner_data_model.dart';

import '../../model/SVCountsModel/sv_counts_model.dart';
import '../../model/SourceWiseSVCountModel/source_wise_sv_count_model.dart';

class DashboardController extends GetxController {
  RxInt svCount = 27.obs;
  RxList<SVCountsModel> svList = RxList([]);
  RxList<OwnerDataListModel> ownerDataList = RxList([]);
  RxList<SourceWiseSVCountModel> sourceWiseSVCountList = RxList([]);
  RxBool showOverAllSVChart = true.obs;
  RxBool showSVWaitListChart = true.obs;
  DashboardController(){
    getSVList();
    getOwnerDataList();
    getSourceWiseSVCountList();
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
    ownerDataList.addAll(OwnerDataBaseModel.fromJson( {
      "success": true,
      "message": "Data found",
      "data": [
        {
          "ownerdata": [
            {
              "id": "8000000057",
              "name": "Rohit Singh"
            },
            {
              "id": "8000000232",
              "name": "Cluster Head"
            },
            {
              "id": "8000000098",
              "name": "Ajay Sharma"
            },
            {
              "id": "8000000105",
              "name": "Vishnu Jain"
            },
            {
              "id": "8000000053",
              "name": "Shekhar Singh"
            },
            {
              "id": "8000000085",
              "name": "A Abhinav"
            },
            {
              "id": "8000000082",
              "name": "Amit Dhoot"
            },
            {
              "id": "8000000102",
              "name": "Aditi Sharma"
            },
            {
              "id": "8000000091",
              "name": "test678 test"
            },
            {
              "id": "8000000056",
              "name": "madhu Rao"
            },
            {
              "id": "8000000108",
              "name": "Varun Sharma"
            },
            {
              "id": "8000000094",
              "name": "Shruti Jain"
            },
            {
              "id": "8000001397",
              "name": "Babu Vigneshwar J"
            },
            {
              "id": "8000009550",
              "name": "GURU PRASAD"
            },
            {
              "id": "8000009700",
              "name": "Haseena M"
            },
            {
              "id": "8000000553",
              "name": "Srinivasa Rao"
            },
            {
              "id": "8000000550",
              "name": "Ramu Gajula"
            },
            {
              "id": "8000000560",
              "name": "Shekina Victor S"
            },
            {
              "id": "8000000989",
              "name": "A Saravanan"
            },
            {
              "id": "8000001149",
              "name": "Dinesh G"
            },
            {
              "id": "8000001206",
              "name": "Ajit Kumar Sahoo"
            },
            {
              "id": "8000001226",
              "name": "Ajay Gope"
            },
            {
              "id": "8000001335",
              "name": "Srinivas H G"
            },
            {
              "id": "8000001473",
              "name": "Bhallal Dev"
            },
            {
              "id": "80003000560",
              "name": "Ravi Kumar T"
            },
            {
              "id": "REC789878",
              "name": "RECEPTIONIST DEV"
            }
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
    sourceWiseSVCountList.addAll(SourceWiseSVCountBaseModel.fromJson(
        {
          "success": true,
          "message": "Data found",
          "data": [
            {
              "Source": "Direct",
              "Count": 2,
              "Percentage": 100,
              "Code": "Z00"
            },
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
        }

    ).data);
  }
}
