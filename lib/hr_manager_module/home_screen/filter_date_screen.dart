import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/app_color.dart';

class FilterDate extends StatefulWidget {
  const FilterDate({super.key});

  @override
  State<FilterDate> createState() => _FilterDateState();
}

class _FilterDateState extends State<FilterDate> {
  String selected = "This Week";

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  final DateFormat apiFormat = DateFormat("yyyy-MM-dd");
  final DateFormat viewFormat = DateFormat("dd MMM yyyy");

  @override
  void initState() {
    super.initState();
    applyThisWeek();
  }

  void applyToday() {
    fromDate = DateTime.now();
    toDate = DateTime.now();
  }

  void applyThisWeek() {
    DateTime now = DateTime.now();
    fromDate = now.subtract(Duration(days: now.weekday - 1));
    toDate = now;
  }

  void applyThisMonth() {
    DateTime now = DateTime.now();
    fromDate = DateTime(now.year, now.month, 1);
    toDate = now;
  }

  void applyLastMonth() {
    DateTime now = DateTime.now();
    DateTime lastMonth = DateTime(now.year, now.month - 1, 1);
    fromDate = lastMonth;
    toDate = DateTime(now.year, now.month, 0);
  }

  void applyThisYear() {
    DateTime now = DateTime.now();
    fromDate = DateTime(now.year, 1, 1);
    toDate = now;
  }

  Future<void> _openCustomRange() async {
    final range = await showModalBottomSheet<DateTimeRange>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _CustomRangeCalendar(
        start: fromDate,
        end: toDate,
      ),
    );

    if (range != null) {
      fromDate = range.start;
      toDate = range.end;
    }
  }

  void handleSelection(String value) async {
    selected = value;

    if (value == "Today") applyToday();
    if (value == "This Week") applyThisWeek();
    if (value == "This Month") applyThisMonth();
    if (value == "Last Month") applyLastMonth();
    if (value == "This Year") applyThisYear();
    if (value == "Custom Range") await _openCustomRange();

    setState(() {});
  }

  Widget filterButton(String title) {
    bool isSelected = selected == title;

    return GestureDetector(
      onTap: () => handleSelection(title),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff0A8ED9)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: const Color(0xffD6E4EC)
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter by Date",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child:  Icon(
                      Icons.close
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding:  EdgeInsets.all(14),
              decoration: BoxDecoration(
                color:  Color(0xffEAF6FD),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selected,
                        style:  TextStyle(
                          color: Color(0xff0A8ED9),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${viewFormat.format(fromDate)} to ${viewFormat.format(toDate)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                filterButton("Today"),
                filterButton("This Week"),
                filterButton("This Month"),
                filterButton("Last Month"),
                filterButton("This Year"),
                filterButton("Custom Range"),
              ],
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context, {
                  "filter": selected,
                  "start": fromDate,
                  "end": toDate,
                });
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.action,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Apply Filter",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: (){
                selected = "This Week";
                applyThisWeek();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reset",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class _CustomRangeCalendar extends StatefulWidget {
  final DateTime start;
  final DateTime end;

  const _CustomRangeCalendar({
    required this.start,
    required this.end,
  });

  @override
  State<_CustomRangeCalendar> createState() => _CustomRangeCalendarState();
}

class _CustomRangeCalendarState extends State<_CustomRangeCalendar> {
  DateTime? start;
  DateTime? end;
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    start = widget.start;
    end = widget.end;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // FROM - TO
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text("From",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(DateFormat("dd MMM").format(start!)),
                  ],
                ),
              ),
              Container(width: 1, height: 40, color: Colors.grey.shade300),
              Expanded(
                child: Column(
                  children: [
                    const Text("To",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(DateFormat("dd MMM").format(end!)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2035),
            focusedDay: focusedDay,
            rangeStartDay: start,
            rangeEndDay: end,
            rangeSelectionMode: RangeSelectionMode.enforced,
            onRangeSelected: (s, e, f) {
              setState(() {
                start = s;
                end = e;
                focusedDay = f;
              });
            },
            calendarStyle: CalendarStyle(
              rangeHighlightColor: const Color(0xffA8D9F5),
              rangeStartDecoration: const BoxDecoration(
                color: Color(0xff0A8ED9),
                shape: BoxShape.circle,
              ),
              rangeEndDecoration: const BoxDecoration(
                color: Color(0xff0A8ED9),
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0A8ED9),
                  ),
                  onPressed: () {
                    if (start != null && end != null) {
                      Navigator.pop(
                        context,
                        DateTimeRange(start: start!, end: end!),
                      );
                    }
                  },
                  child: const Text(
                      "Apply",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
