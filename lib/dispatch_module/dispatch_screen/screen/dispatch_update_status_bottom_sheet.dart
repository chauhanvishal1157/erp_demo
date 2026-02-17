import 'package:flutter/material.dart';

import '../../../common/common_action_button.dart';
import '../../../common/common_drop_down.dart';
import '../../../common/create_edit_screen.dart';

class DispatchUpdateStatusBottomSheet extends StatefulWidget {
  final String orderNo;
  final int currentStatusId;
  final String currentStatus;
  const DispatchUpdateStatusBottomSheet({
    required this.orderNo,
    required this.currentStatusId,
    required this.currentStatus,
    super.key
  });

  @override
  State<DispatchUpdateStatusBottomSheet> createState() => _DispatchUpdateStatusBottomSheetState();
}

class _DispatchUpdateStatusBottomSheetState extends State<DispatchUpdateStatusBottomSheet> {

  String? statusValue;

  final Map<String, int> statusMap = {
    'Order Dispatched': 1,
    'Order Completed': 2,
    'Return Order': 3,
    'Cancel Order': 4,
  };

  @override
  void initState() {
    statusValue = widget.currentStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
              icon: Icons.edit_outlined,
              title: "Update Status",
              themeColor: Colors.black,
              subtitle: "Order #${widget.orderNo}",
            ),
            CommonDropdown(
              label: "Status",
              value: statusValue,
              items:  statusMap.keys.toList(),
              onChanged: (val) {
                setState(() => statusValue = val);
              },
            ),
            CommonActionButton(
              title: "Update Status",
              onTap: (){},
            )
          ],
        )
    );
  }
}
