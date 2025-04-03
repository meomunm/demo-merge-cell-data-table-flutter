import 'dart:async';
import 'dart:math';

import 'package:demo_merge_data_table/custom_render_box/custom_render_box.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';


class CustomerLastTransactionTableWidget extends StatefulWidget {
  const CustomerLastTransactionTableWidget({super.key, required this.data});
  final List<CustomerLastTransactionTableData> data;


  @override
  State<CustomerLastTransactionTableWidget> createState() => _CustomerLastTransactionTableWidgetState();
}


class _CustomerLastTransactionTableWidgetState extends State<CustomerLastTransactionTableWidget> {
  final double widthHeaderPinnedDefault = 150;
  final double widthRow2 = 150;
  final double widthRow3 = 150;
  final double widthRow4 = 150;
  final double widthRow5 = 150;
  final double widthRow6 = 150;
  final double widthRow7 = 150;
  final double widthRow8 = 150;
  final Map<int, double> itemColumnHeights = {};
  final Map<int, double> itemRowHeights = {};
  late double totalWidth;
  late LinkedScrollControllerGroup verticalScrollController;
  late ScrollController controllerA;
  late ScrollController controllerB;

  /// START Dummies data
  final TextStyle kCaptionMETextStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: Colors.black, // Màu mặc định, có thể thay đổi bằng copyWith
    fontFamily: 'Roboto',
  );

  final TextStyle kCaptionRETextStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: Colors.black, // Mặc định, có thể thay đổi bằng copyWith
    fontFamily: 'Roboto',
  );


  final Color textNeutralBase = Color(0xFF666666); // Màu trung tính, có thể thay đổi theo thiết kế
  /// END Dummies data

  @override
  void initState() {
    super.initState();
    verticalScrollController = LinkedScrollControllerGroup();
    controllerA = verticalScrollController.addAndGet();
    controllerB = verticalScrollController.addAndGet();
    totalWidth = widthRow2 + widthRow3 + widthRow4 + widthRow5 + widthRow6 + widthRow7 + widthRow8;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // controllerA.addListener(() {
      //   if (controllerA.position.pixels == controllerA.position.maxScrollExtent) {
      //     context.read<CustomerLastTransactionDetailBloc>().add(CustomerLastTransactionDetailLoadMoreEvent());
      //   }
      // });


      // _calculateHeights();
    });
  }


  @override
  void dispose() {
    controllerA.dispose();
    controllerB.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: widthHeaderPinnedDefault,
          child: Column(children: [
            _buildPinnedColumn(context: context, headerTitle: 'AppLocalizations.of(context)!.smartAnalyticsCustomer_customerLastTransactionDetailPage_customer', index: 1),
            Expanded(
              child: ListView.builder(
                controller: controllerA,
                itemBuilder: (c, index) {
                  final itemData = widget.data[index];
                  final isLegendItem = itemData.isLegend;
                  if (isLegendItem) {
                    return _buildLegendItemRow(context: context, headerTitle: itemData.row1, width: widthHeaderPinnedDefault, index: index);
                  }
                  return _buildItemPinnedRow(context: context, headerTitle: itemData.row1, width: widthHeaderPinnedDefault, index: index);
                },
                itemCount: widget.data.length,
              ),
            )
          ],),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildItemHeader(context: context),
                Expanded(
                  child: SizedBox(
                    width: totalWidth,
                    child: ListView.builder(
                      controller: controllerB,
                      itemBuilder: (c, index) {
                        final itemData = widget.data[index];
                        final isLegendItem = itemData.isLegend;
                        if (isLegendItem) {
                          return _buildLegendsItem(context: context, headerTitle: '', index: index);
                        }
                        return _buildItemsRow(context: context, data: widget.data[index], index: index);
                      },
                      itemCount: widget.data.length,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildPinnedColumn({required BuildContext context, required String headerTitle, required int index}) {
    return CustomRenderObjectWidget(
      onChildSizeChanged: (size) {
        scheduleMicrotask(() {
          setState(() {
            itemColumnHeights[index] = max(itemColumnHeights[index] ?? 0, size.height);
          });
        });
      },
      child: Container(
        width: widthHeaderPinnedDefault,
        height: itemColumnHeights[index] ,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
          color: Color(0xFFE5F1FE),
          border: Border(
            top: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            bottom: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            right: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            left: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
          ),
        ),
        child: Text(
          headerTitle,
          style: kCaptionMETextStyle.copyWith(color: textNeutralBase),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }


  Widget _buildColumn({required BuildContext context, required String headerTitle, required double width, required int index}) {
    return CustomRenderObjectWidget(
      onChildSizeChanged: (size) {
        scheduleMicrotask(() {
          setState(() {
            itemColumnHeights[index] = max(itemColumnHeights[index] ?? 0, size.height);
          });
        });
      },
      child: Container(
        width: width,
        height: itemColumnHeights[index] ,
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
        decoration: const BoxDecoration(
          color: Color(0xFFE5F1FE),
          border: Border(
            top: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            bottom: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            right: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            left: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
          ),
        ),
        child: Text(
          headerTitle,
          style: kCaptionMETextStyle.copyWith(color: textNeutralBase),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }


  Widget _buildItemPinnedRow({required BuildContext context, required String headerTitle, required double width, required int index}) {
    return CustomRenderObjectWidget(
      onChildSizeChanged: (size) {
        scheduleMicrotask(() {
          setState(() {
            itemRowHeights[index] = max(itemRowHeights[index] ?? 0, size.height);
          });
        });
      },
      child: Container(
        width: width,
        height: itemRowHeights[index] ,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            bottom: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            right: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            left: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
          ),
        ),
        child: Text(
          headerTitle,
          style: kCaptionRETextStyle.copyWith(color: textNeutralBase),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }


  Widget _buildItemRow({required BuildContext context, required String headerTitle, required double width, required int index}) {
    return CustomRenderObjectWidget(
      onChildSizeChanged: (size) {
        scheduleMicrotask(() {
          setState(() {
            itemRowHeights[index] = max(itemRowHeights[index] ?? 0, size.height);
          });
        });
      },
      child: Container(
        width: width,
        height: itemRowHeights[index] ,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            bottom: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            right: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
            left: BorderSide(color: Color(0xFFE8EAED), width: 0.5),
          ),
        ),
        child: Text(
          headerTitle,
          style: kCaptionRETextStyle.copyWith(color: textNeutralBase),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }


  Widget _buildLegendItemRow({required BuildContext context, required String headerTitle, required double width, required int index}) {
    return CustomRenderObjectWidget(
      onChildSizeChanged: (size) {
        scheduleMicrotask(() {
          setState(() {
            itemRowHeights[index] = max(itemRowHeights[index] ?? 0, size.height);
          });
        });
      },
      child: Container(
        width: width,
        height: itemRowHeights[index] ,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
          color: Color(0xFFFFF3E5),
        ),
        child: Text(
          headerTitle,
          style: kCaptionRETextStyle.copyWith(color: textNeutralBase),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }


  Widget _buildItemsRow({required BuildContext context, required CustomerLastTransactionTableData data, required int index}) {
    return Row(
      children: [
        _buildItemRow(context: context, headerTitle: data.row2, width: widthRow2, index: index),
        _buildItemRow(context: context, headerTitle: data.row3, width: widthRow3, index: index),
        _buildItemRow(context: context, headerTitle: data.row4, width: widthRow4, index: index),
        _buildItemRow(context: context, headerTitle: data.row5, width: widthRow5, index: index),
        _buildItemRow(context: context, headerTitle: data.row6, width: widthRow6, index: index),
        _buildItemRow(context: context, headerTitle: data.row7, width: widthRow7, index: index),
        _buildItemRow(context: context, headerTitle: data.row8, width: widthRow8, index: index),
      ],
    );
  }


  Widget _buildLegendsItem({required BuildContext context, required String headerTitle, required int index}) {
    return Row(
      children: [
        _buildLegendItemRow(context: context, headerTitle: headerTitle, width: widthRow2, index: index),
        _buildLegendItemRow(context: context, headerTitle: '', width: widthRow3, index: index),
        _buildLegendItemRow(context: context, headerTitle: '', width: widthRow4, index: index),
        _buildLegendItemRow(context: context, headerTitle: '', width: widthRow5, index: index),
        _buildLegendItemRow(context: context, headerTitle: '', width: widthRow6, index: index),
        _buildLegendItemRow(context: context, headerTitle: '', width: widthRow7, index: index),
        _buildLegendItemRow(context: context, headerTitle: '', width: widthRow8, index: index),
      ],
    );
  }




  Widget _buildItemHeader({required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildColumn(context: context, headerTitle: 'AppLocalizations.of(context)!.smartAnalyticsCustomer_customerLastTransactionDetailPage_creationDate', width: widthRow2, index: 1),
        _buildColumn(context: context, headerTitle: 'AppLocalizations.of(context)!.smartAnalyticsCustomer_customerLastTransactionDetailPage_gender', width: widthRow3, index: 1),
        _buildColumn(context: context, headerTitle: 'AppLocalizations.of(context)!.smartAnalyticsCustomer_customerLastTransactionDetailPage_age', width: widthRow4, index: 1),
        _buildColumn(context: context, headerTitle: 'AppLocalizations.of(context)!.smartAnalyticsCustomer_customerLastTransactionDetailPage_accumulatedRevenue', width: widthRow5, index: 1),
        _buildColumn(context: context, headerTitle: 'AppLocalizations.of(context)!.smartAnalyticsCustomer_customerLastTransactionDetailPage_accumulatedTransactions', width: widthRow6, index: 1),
        _buildColumn(context: context, headerTitle: 'AppLocalizations.of(context)!.smartAnalyticsCustomer_customerLastTransactionDetailPage_lastTransaction', width: widthRow7, index: 1),
        _buildColumn(context: context, headerTitle: 'AppLocalizations.of(context)!.smartAnalyticsCustomer_customerLastTransactionDetailPage_notTransaction', width: widthRow8, index: 1),
      ],
    );
  }
}


/// Hiện tại chưa support common cho các case Data dữ liệu khác
/// Đang cố định 8 cột (Fix cứng cả title)
class CustomerLastTransactionTableData {
  const CustomerLastTransactionTableData({
    required this.isLegend,
    required this.groupType,
    required this.sumCustomer,
    required this.row1,
    required this.row2,
    required this.row3,
    required this.row4,
    required this.row5,
    required this.row6,
    required this.row7,
    required this.row8,
  });
  final bool isLegend;
  final num groupType;
  final num sumCustomer;
  final String row1;
  final String row2;
  final String row3;
  final String row4;
  final String row5;
  final String row6;
  final String row7;
  final String row8;
}

final List<CustomerLastTransactionTableData> testCustomerData = List.generate(
  30,
      (index) => CustomerLastTransactionTableData(
    isLegend: index % 5 == 0, // Cứ mỗi 5 dòng là legend
    groupType: (index % 4) + 1, // Giới hạn groupType từ 1 đến 4
    sumCustomer: 100 + (index * 10), // Tăng dần tổng số khách hàng
    row1: "Data ${index}A Data ${index}A Data ${index}A Data ${index}A\nData ${index}A Data ${index}A Data ${index}A",
    row2: "Data ${index}B",
    row3: "Data ${index}C",
    row4: "Data ${index}D",
    row5: "Data ${index}E",
    row6: "Data ${index}F",
    row7: "Data ${index}G",
    row8: "Data ${index}H",
  ),
);

