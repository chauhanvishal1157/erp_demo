import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskHistoryBottomSheet extends StatefulWidget {
  final String taskId;
  final String taskName;
  final String status;
  final String startDate;

  const TaskHistoryBottomSheet({
    required this.taskId,
    required this.taskName,
    required this.status,
    required this.startDate,
    super.key});

  @override
  State<TaskHistoryBottomSheet> createState() => _TaskHistoryBottomSheetState();
}

class _TaskHistoryBottomSheetState extends State<TaskHistoryBottomSheet> {

  String formatDateToMonth(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('MMM dd, yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
                icon: Icons.history,
                title: "Task History",
                subtitle: "ID:${widget.taskId}",
              themeColor: Colors.black,
            ),
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
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:  EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: getStatusColor(widget.status).withValues(alpha: 0.1),
                    border: Border.all(
                        color: getStatusColor(widget.status).withValues(alpha: 1),
                        width: 2
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.access_time,
                    size: 18,
                    color: getStatusColor(widget.status).withValues(alpha: 1),
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
                        color: getStatusColor(widget.status).withValues(alpha: 0.3),
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
                            color: getStatusColor(widget.status).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            getStatusText(widget.status),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: getStatusColor(widget.status).withValues(alpha: 1),
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
                              widget.taskName,
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
                              formatDateToMonth(widget.startDate),
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

  Color getStatusColor(String statusWidget) {
    switch (widget.status) {
      case '1':
        return Colors.orange;
      case '2':
        return Colors.blue;
      case '3':
        return Colors.red;
      case '4':
        return Colors.green;
      case '5':
        return Colors.black;
      case '6':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String statusWidget) {
    switch (widget.status) {
      case "1":
        return "Pending";
      case "2":
        return "InProgress";
      case "3":
        return "Rejected";
      case "4":
        return "Completed";
      case "5":
        return "Re-open";
      case "6":
        return "Closed";
      default:
        return "Pending";
    }
  }
}
