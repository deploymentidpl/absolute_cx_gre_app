
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../SVCountsModel/sv_counts_model.dart';

class OverAllSvPerHourDataGrid extends DataGridSource {
  OverAllSvPerHourDataGrid({required List<SVCountsModel> dataList}) {

      for (int i = 0; i < dataList.first.lable.length; i++) {
        data.add(DataGridRow(cells: [
          DataGridCell<String>(columnName: 'time', value: dataList.first.lable[i]),
          DataGridCell<String>(
              columnName: 'count', value: dataList.first.count[i].toString()),
        ]));
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