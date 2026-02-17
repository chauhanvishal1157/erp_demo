import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/master_module/admin_screen/branch/bloc/create_edit_delete_master_branch_bloc/create_edit_master_branch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBranchMasterBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String branchId;
  final String branchName;

  const CreateBranchMasterBottomSheet({
    required this.isEdit,
    required this.branchId,
    required this.branchName,
    super.key
  });

  @override
  State<CreateBranchMasterBottomSheet> createState() => _CreateBranchMasterBottomSheetState();
}

class _CreateBranchMasterBottomSheetState extends State<CreateBranchMasterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> CreateEditMasterBranchBloc(),
      child: CreateBranchMasterBottomSheetWidget(
          isEdit: widget.isEdit,
          branchId: widget.branchId,
          branchName: widget.branchName,
      ),
    );
  }
}


class CreateBranchMasterBottomSheetWidget extends StatefulWidget {
  final bool isEdit;
  final String branchId;
  final String branchName;

  const CreateBranchMasterBottomSheetWidget({
    required this.isEdit,
    required this.branchId,
    required this.branchName,
    super.key
  });

  @override
  State<CreateBranchMasterBottomSheetWidget> createState() => _CreateBranchMasterBottomSheetWidgetState();
}

class _CreateBranchMasterBottomSheetWidgetState extends State<CreateBranchMasterBottomSheetWidget> {

  TextEditingController branchNameController = TextEditingController();

  @override
  void initState() {
    branchNameController.text = widget.branchName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
                icon:  Icons.person_add_outlined,
                title: "Create Branch",
                subtitle:  "Add a new Branch"
            ),
            CommonTextField(
              controller: branchNameController,
              label:  "Branch Name",
              hint: "Enter Branch Name..",
              headerText:  "Branch Name",
              headerIcon: Icons.business,
              showHeader: true,
            ),
            CommonBottomActionButtons(
                onTap: (){
                  Navigator.of(context).pop(
                      [true, branchNameController.text]);},
                submitText: "Create",
                submitIcon: Icons.add
            )
          ],
        )
    );
    //   SingleChildScrollView(
    //   child: Padding(
    //     padding: EdgeInsets.only(
    //       bottom: MediaQuery.of(context).viewInsets.bottom,
    //     ),
    //     child: Container(
    //       padding: EdgeInsets.only(bottom:20),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         borderRadius: BorderRadius.only(
    //             topRight: Radius.circular(20),
    //             topLeft: Radius.circular(20),
    //         ),
    //       ),
    //       child: Column(
    //         children: [
    //
    //
    //
    //
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Container(
    //                 margin: EdgeInsets.all(15),
    //                 padding: EdgeInsets.all(8),
    //                 decoration: BoxDecoration(
    //                   color: Colors.blue.shade50,
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 child: Icon(
    //                   Icons.person_add_outlined,
    //                   size: 20,
    //                   color: AppColors.primary,
    //                 ),
    //               ),
    //               Expanded(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "Create Branch",
    //                       style: TextStyle(
    //                         color: AppColors.primary,
    //                         fontWeight: FontWeight.w500,
    //                         fontSize: 16,
    //                       ),
    //                     ),
    //                     Text(
    //                       "Add a new Branch",
    //                       style: TextStyle(
    //                         color: Colors.black54,
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               GestureDetector(
    //                 onTap: (){
    //                   Navigator.pop(context);
    //                 },
    //                 child: Container(
    //                   margin: EdgeInsets.all(15),
    //                   padding: EdgeInsets.all(4),
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey.shade100,
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //                   child: Icon(
    //                     Icons.close_sharp,
    //                     size: 20,
    //                     color: Colors.grey,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Divider(
    //             height: 1,
    //             color: Colors.grey.shade300,
    //             thickness: 1,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
