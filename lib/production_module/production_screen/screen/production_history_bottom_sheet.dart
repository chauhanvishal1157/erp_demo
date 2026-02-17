import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/create_edit_screen.dart';

class ProductionHistoryBottomSheet extends StatefulWidget {
  final String statusName;
  final String orderName;
  final String orderNo;
  final String createAt;
  final String statusBgColor;
  final String statusTextColor;
  const ProductionHistoryBottomSheet({
    required this.statusName,
    required this.orderNo,
    required this.orderName,
    required this.createAt,
    required this.statusBgColor,
    required this.statusTextColor,
    super.key});

  @override
  State<ProductionHistoryBottomSheet> createState() => _ProductionHistoryBottomSheetState();
}

class _ProductionHistoryBottomSheetState extends State<ProductionHistoryBottomSheet> {

  String formatDateToMonth(String date) {
    try {
      final inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      final outputFormat = DateFormat('MMM dd, yyyy • hh:mm a');

      DateTime parsedDate = inputFormat.parse(date);
      return outputFormat.format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  Color hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }


  @override
  Widget build(BuildContext context) {
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
              icon: Icons.history,
              title: "Production History",
              themeColor: Colors.black,
              subtitle: "No : ${widget.orderNo}",
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Text(
                  "Timeline",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  "(update)",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black38,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:  EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: hexToColor(widget.statusBgColor).withValues(alpha: 0.1),
                    border: Border.all(
                        color: hexToColor(widget.statusBgColor),
                        width: 2
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.access_time,
                    size: 18,
                    color: hexToColor(widget.statusBgColor).withValues(alpha: 5),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: hexToColor(widget.statusBgColor).withValues(alpha: 1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: hexToColor(widget.statusBgColor).withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.statusName,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: hexToColor(widget.statusTextColor),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                                Icons.person_outline,
                                size: 18, color: Colors.black54
                            ),
                            SizedBox(width: 6),
                            Text(
                              widget.orderName,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.black54
                            ),
                            SizedBox(width: 6),
                            Text(
                              formatDateToMonth(widget.createAt),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),

          ],
        )
    );
  }
}
