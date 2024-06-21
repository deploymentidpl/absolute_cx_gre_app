
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greapp/widgets/SideBarMenuWidget/sidebar_menu_widget.dart';

import '../config/Helper/function.dart';
import '../config/utils/app_constant.dart';
import '../config/utils/constant.dart';
import '../controller/BLockUnit/block_unit_selection_controller.dart';
import '../model/BookingForm/unit_status_detail.dart';
import '../style/text_style.dart';
import '../style/theme_color.dart';
import 'comon_type_ahead_field.dart';

class BlockedUnitInventory extends StatelessWidget {
  final bool showTowerDropDown;
  final BlockUnitSelectionController _controller =
  Get.put(BlockUnitSelectionController());
  final String title;
  final bool isMobile;
  double width;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Function(FloorModel, String) onTap;

  BlockedUnitInventory({super.key,
    required this.isMobile,
    this.width = 500,
    required this.showTowerDropDown, this.title = 'Inventory View', required this.onTap}) {
    if (isMobile) {
      width = double.infinity;
    }
  }


  @override
  Widget build(BuildContext context) {
    return

      !isMobile ? SideBarMenuWidget(

        width: 600,
        sideBarWidget: SizedBox(
          height: Get.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox16,
                      Text(
                        title,
                        style: mediumTextStyle(
                            size: 16, color: ColorTheme.cFontWhite),
                      ),
                      sizedBox16,
                      if (showTowerDropDown)
                        SizedBox(
                          width: 140,
                          child: customTypeAheadField(
                            readOnly: true,
                            isSizedBoxHeight: false,
                            fillColor: ColorTheme.cAppTheme,
                            labelStyle: mediumTextStyle(
                                size: 14, color: ColorTheme.cFontWhite),
                            labelText: '',
                            dataList: ['Tower1', 'Tower2'],
                            onSelected: (selectedValue) {},
                            suggestion: (suggestion) => suggestion,
                            textController: TextEditingController(),
                            validator: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'Please select payment plan';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      sizedBox16,
                      _web(),
                      const SizedBox(height: 150)
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child:
                  _getBottomList())
            ],
          ),
        ),
      ) :


      SafeArea(
          child: Scaffold(
            backgroundColor: ColorTheme.cThemeCard,
            // appBar: CustomAppbar(_scaffoldKey, title: title),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBox16,
                            if (showTowerDropDown)
                              SizedBox(
                                width: 140,
                                child: customTypeAheadField(
                                  readOnly: true,
                                  isSizedBoxHeight: false,
                                  fillColor: ColorTheme.cAppTheme,
                                  labelStyle: mediumTextStyle(
                                      size: 16, color: ColorTheme.cFontWhite),
                                  labelText: '',
                                  dataList: ['Tower1', 'Tower2'],
                                  onSelected: (selectedValue) {},
                                  suggestion: (suggestion) => suggestion,
                                  textController: TextEditingController(),
                                  validator: (value) {
                                    if ((value ?? '').isEmpty) {
                                      return 'Please select payment plan';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            sizedBox16,
                            _getList(),
                            const SizedBox(height: 170)

                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child:
                        _getBottomList())
                  ],
                )),
          ));
  }


  Widget _mobile() {
    return _getList();
  }

  Widget _web() {
    return _getList();
  }


  Widget _getBottomList() {
    return Container(
    height: 130,

    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    color:isMobile? ColorTheme.cThemeCard:ColorTheme.cThemeBg,
    width:isMobile ? Get.width: 600,
    child:
    GridView.builder(
      shrinkWrap: true,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:isMobile ?3: 4, // Number of elements per row
          crossAxisSpacing: 5, // Space between columns
          mainAxisSpacing: 5, // Space between rows
        //  childAspectRatio: Get.width / (Get.height / 1.8), // Dynamically calculate the aspect ratio based on the screen size
       // childAspectRatio:10,
        mainAxisExtent: 30,

      ),
      itemCount: AppConstant.unitStatus.length,
      // Number of items in the grid
      itemBuilder: (_, index) {

        return getBottomItem(index:index);
      },
    )
    );
  }

  
  
  Widget getBottomItem({required int index}){

    return GestureDetector(
      onTap: () {
        _controller.applyFilter(type: AppConstant.unitStatus[index]);
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() =>
                Container(
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:
                            getBlockUnitColorBasedOnStatus(
                            status: AppConstant.unitStatus[index])
                    ),
                    child: _controller.selectedFilter.value ==
                        AppConstant.unitStatus[index] ?
                    SizedBox(height: 14, width: 14,
                      child: Checkbox(
                        fillColor: MaterialStateProperty.all(
                            getBlockUnitColorBasedOnStatus(
                            status: AppConstant.unitStatus[index])),
                        value: true, onChanged: (newVal) {
                        _controller.applyFilter(
                            type: AppConstant.unitStatus[index]);
                      },
                      ),
                    ) :
                    const SizedBox.shrink()

                ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                AppConstant.unitStatus[index],
                style: mediumTextStyle(
                    size: 10, color: ColorTheme.cFontWhite),
              ),
            ),
          ]),
    );
  }
  
  
  Widget _getList() {
    return Obx(
          () =>
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _controller.filterList.value.floors.length,
              itemBuilder: (_, index) {
                return Container(
                  // height: 50,
                  // constraints: const BoxConstraints(maxHeight: 80),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                          BorderSide(width: 1, color: ColorTheme.cLineColor))),
                  child: 1 > 0 ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: isMobile ? 30 : 30,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxHeight: 50),
                          decoration: BoxDecoration(
                              color: ColorTheme.cAppTheme),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Text(
                              _controller.filterList.value.floors[index]
                                  .floorId,
                              style: semiBoldTextStyle(
                                  size: 12, color: ColorTheme.cWhite))),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Wrap(
                          runSpacing: 5,
                          spacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: _controller
                              .filterList.value.floors[index].units.map((e) =>
                              GestureDetector(
                                onTap: () {
                                  onTap(_controller
                                      .filterList
                                      .value
                                      .floors[index], e.unitId);
                                },
                                child: Container(
                                  height: isMobile ? 30 : 30,
                                  constraints: const BoxConstraints(
                                      minWidth: 80,
                                      maxHeight: 50,
                                      maxWidth: 90),
                                  decoration: BoxDecoration(
                                      color:
                                          getBlockUnitColorBasedOnStatus(
                                          status: e.status)),
                                  alignment: Alignment.center,

                                  padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 0 : 20,
                                      vertical: 6),
                                  child: Text(
                                    e.unitId,
                                    style: semiBoldTextStyle(size: 12),
                                  ),
                                ),
                              )).toList(),
                        ),
                      )
                    ],
                  )
                      :
                  Row(
                    children: [
                      Container(
                          height: 50,
                          constraints: const BoxConstraints(minWidth: 100),
                          decoration: BoxDecoration(
                              color: ColorTheme.cAppTheme),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Text(
                              _controller.filterList.value.floors[index]
                                  .floorId,
                              style: semiBoldTextStyle(
                                  size: 12, color: ColorTheme.cWhite))),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ListView.separated(
                            padding: EdgeInsets.zero,
                            separatorBuilder: (_, index1) =>
                            const SizedBox(width: 10),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: false,
                            itemCount: _controller
                                .filterList.value.floors[index].units.length,
                            itemBuilder: (_, index1) {
                              return GestureDetector(
                                onTap: () {
                                  onTap(_controller
                                      .filterList
                                      .value
                                      .floors[index], _controller
                                      .filterList
                                      .value
                                      .floors[index].units[index1].unitId);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          getBlockUnitColorBasedOnStatus(
                                          status: _controller
                                              .filterList
                                              .value
                                              .floors[index]
                                              .units[index1]
                                              .status)),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 6),
                                  child: Text(
                                    _controller.filterList.value.floors[index]
                                        .units[index1].unitId,
                                    style: semiBoldTextStyle(size: 12),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
