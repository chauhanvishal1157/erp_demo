import 'package:flutter/material.dart';
import '../../../common/common_action_button.dart';
import '../../../common/common_drop_down.dart';
import '../../../common/create_edit_screen.dart';

class OrderUpdateStatusBottomSheet extends StatefulWidget {
  final String orderNo;
  final int currentStatusId;
  final String currentStatus;
  const OrderUpdateStatusBottomSheet({
    required this.orderNo,
    required this.currentStatusId,
    required this.currentStatus,
    super.key
  });

  @override
  State<OrderUpdateStatusBottomSheet> createState() => _OrderUpdateStatusBottomSheetState();
}

class _OrderUpdateStatusBottomSheetState extends State<OrderUpdateStatusBottomSheet> {

  String? statusValue;

  final Map<String, int> statusMap = {
    'Pending': 1,
    'Production': 2,
    'Order Cancel': 3,
    'Printing': 4,
    'Test Production': 5,
    'Order Dispatched':6,
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
