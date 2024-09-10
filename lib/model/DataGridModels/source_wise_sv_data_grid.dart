
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../style/text_style.dart';
import '../../style/theme_color.dart';
import '../SourceWiseSVCountModel/source_wise_sv_count_model.dart';

class SourceWiseSVDataGrid extends DataGridSource {
  SourceWiseSVDataGrid(
      {required List<SourceWiseDataModel> dataList}) {
    data = dataList
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'source', value: e.source),
      DataGridCell<String>(
          columnName: 'count', value: e.count.toString()),
      DataGridCell<String>(
          columnName: 'percentage', value: e.percentage.toString()),
    ]))
        .toList();
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
              style: regularTextStyle(
                  color: ColorTheme.cWhite,
                  size: 13),
            ),
          );
        }).toList());
  }
}