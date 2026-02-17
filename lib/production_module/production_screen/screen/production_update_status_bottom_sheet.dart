import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:flutter/material.dart';

import '../../../common/common_drop_down.dart';

class ProductionUpdateStatusBottomSheet extends StatefulWidget {
  final String orderNo;
  final int currentStatusId;
  final String currentStatus;
  const ProductionUpdateStatusBottomSheet({
    required this.orderNo,
    required this.currentStatusId,
    required this.currentStatus,
    super.key
  });

  @override
  State<ProductionUpdateStatusBottomSheet> createState() => _ProductionUpdateStatusBottomSheetState();
}

class _ProductionUpdateStatusBottomSheetState extends State<ProductionUpdateStatusBottomSheet> {

  String? statusValue;

  final Map<String, int> statusMap = {
    'Production': 1,
    'Dispatch': 2,
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
