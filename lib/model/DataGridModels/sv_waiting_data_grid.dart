import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../SVWaitListModel/sv_wait_list_model.dart';

class SvWaitingDataGrid extends DataGridSource {
  SvWaitingDataGrid({required List<SVWaitListModel> dataList}) {
    List<SVOwnerDataModel> ownerList = dataList[0].svownerdata;

    if (ownerList.length == dataList[0].count.length) {
      for (int i = 0; i < ownerList.length; i++) {
        data.add(DataGridRow(cells: [
          DataGridCell<String>(columnName: 'time', value: ownerList[i].name),
          DataGridCell<String>(
              columnName: 'count', value: dataList[0].count[i].toString()),
        ]));
      }
    }
  }

  List<DataGridRow> data = [];

  @override
  List<DataGridRow> get rows => data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        color: e.columnName == 'source'
            ? ColorTheme.cThemeBg
            : ColorTheme.cThemeBg,
        child: Text(
          e.value.toString(),
          style: regularTextStyle(color: ColorTheme.cWhite, size: 13),
        ),
      );
    }).toList());
  }
}
