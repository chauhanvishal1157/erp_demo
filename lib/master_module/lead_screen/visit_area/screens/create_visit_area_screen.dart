import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/screens/select_branch_screen.dart';
import 'package:erp_demo/master_module/lead_screen/visit_area/visit_area_customer/screen/visit_area_customer_screen.dart';
import 'package:flutter/material.dart';
import '../../../../common/common_field.dart';
import '../../../../common/create_edit_screen.dart';

class CreateVisitArea extends StatefulWidget {

  const CreateVisitArea({super.key});

  @override
  State<CreateVisitArea> createState() => _CreateVisitAreaState();
}

class _CreateVisitAreaState extends State<CreateVisitArea> {

  TextEditingController areaNameController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();

  String branchId = "";
  String branchName = "";
  String customerName = "";


  @override
  Widget build(BuildContext context) {
    return  CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
              icon: Icons.add_circle_outline,
              title:  "Create  New Area",
              subtitle:  "Add a new Area",
            ),
            CommonTextField(
              controller: areaNameController,
              label: "Area Name",
              hint: "Enter Area Name..",
              showHeader: true,
              headerText: "Area Name",
              headerIcon: Icons.location_on_outlined,
            ),
            CommonTextField(
              controller: branchNameController,
              label: "Branch",
              hint:  "Tap to select branch",
              readOnly: true,
              showHeader: true,
              headerText: "Select Branch",
              headerIcon: Icons.select_all_outlined,
              onTap: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=> SelectBranchScreen(),
                  ),
                ).then(
                      (value) {
                    branchId = value[0];
                    branchName = value[1];
                    branchNameController.text = value[1];
                    setState(() {});
                  },
                );
              },
              suffixIconBoxed: false,
              suffixIcon: Icons.arrow_forward_ios,
            ),
            if (branchName.isNotEmpty)...[

              CommonTextField(
                controller: customerNameController,
                label: "Customer",
                hint:  "Tap to select Customer",
                readOnly: true,
                showHeader: true,
                headerText: "Select Customer",
                headerIcon: Icons.person_outline,
                onTap: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>VisitAreaCustomerScreen(
                        branchId: branchId.toString(),
                      ),
                    ),
                  ).then((value){
                    customerName = value.join(", ");
                    customerNameController.text = customerName;
                    setState(() {});
                  });
                },
                suffixIconBoxed: false,
                suffixIcon: Icons.arrow_forward_ios,
              ),
            ],

            CommonActionButton(
                title: "Save",
                onTap: (){
                  Navigator.pop(context);
                },
            )
          ],
        )
    );
  }
}
