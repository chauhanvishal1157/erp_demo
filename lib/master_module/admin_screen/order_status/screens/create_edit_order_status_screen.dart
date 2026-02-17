import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/bloc/create_edit_order_status_bloc/create_edit_order_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../common/app_color.dart';
import '../../../../common/common_drop_down.dart';
import '../bloc/create_edit_order_status_bloc/create_edit_order_status_event.dart';
import '../bloc/create_edit_order_status_bloc/create_edit_order_status_state.dart';


class CreateEditOrderStatusScreen extends StatefulWidget {
  final bool isEdit;
  final String orderStatusId;
  final String orderStatusName;
  final String status;
  final String textColor;
  final String textBgColor;
  final String moduleStatus;


  const CreateEditOrderStatusScreen({
    required this.isEdit,
    required this.orderStatusId,
    required this.orderStatusName,
    required this.status,
    required this.textColor,
    required this.textBgColor,
    required this.moduleStatus,
    super.key,
  });

  @override
  State<CreateEditOrderStatusScreen> createState() => _CreateEditOrderStatusScreenState();
}

class _CreateEditOrderStatusScreenState extends State<CreateEditOrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEditOrderStatusBloc(),
      child:CreateEditOrderStatusScreenWidget(
        isEdit: widget.isEdit,
        orderStatusId: widget.orderStatusId,
        orderStatusName: widget.orderStatusName,
        status: widget.status,
        textColor: widget.textColor,
        textBgColor: widget.textBgColor,
        moduleStatus: widget.moduleStatus,
      ),
    );
  }
}


class CreateEditOrderStatusScreenWidget extends StatefulWidget {
  final bool isEdit;
  final String orderStatusId;
  final String orderStatusName;
  final String status;
  final String textColor;
  final String textBgColor;
  final String moduleStatus;

  const CreateEditOrderStatusScreenWidget({
    required this.isEdit,
    required this.orderStatusId,
    required this.orderStatusName,
    required this.status,
    required this.textColor,
    required this.textBgColor,
    required this.moduleStatus,
    super.key
  });

  @override
  State<CreateEditOrderStatusScreenWidget> createState() => _CreateEditOrderStatusScreenWidgetState();
}

class _CreateEditOrderStatusScreenWidgetState extends State<CreateEditOrderStatusScreenWidget> {

  TextEditingController orderNameController = TextEditingController();

  @override
  void initState() {
    orderNameController.text = widget.orderStatusName;
    if (widget.isEdit) {
      selectedStatus = widget.status == "1" ? "Active" : "Inactive";
    } else {
      selectedStatus = "Active";
    }
    moduleValue = 'Order';
    super.initState();
  }
  String? moduleValue;
  String selectedStatus = "";
  Color textColor = Color(0xFF0093E9);
  Color bgColor =  Color(0xFFDCE2E7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CommonAppBar(
          title: widget.isEdit == true
              ? "Update Order Status"
              : "Create Order Status",
      ),
      body: BlocConsumer<CreateEditOrderStatusBloc, CreateEditOrderStatusState>(
        listener: (context, state){
          if (state is LoadedCreateOrderStatusState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is FailureCreateOrderStatusState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          else if (state is LoadedEditOrderStatusState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            Navigator.of(context).pop(true);
          }
          else if(state is FailureEditOrderStatusState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
          builder: (context, state){
            if (state is LoadingCreateOrderStatusState) {
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 40,
                ),
              );
            }
            else if(state is LoadingEditOrderStatusState) {
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.blue,
                  size: 40,
                ),
              );
            }
            return  Stack(
              children: [
                SingleChildScrollView(
                  padding:  EdgeInsets.fromLTRB(15,15,15,100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color:  Colors.blue.shade50,
                          border: Border.all(color: Colors.blue.shade200),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children:  [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.isEdit == true
                               ? "Update the order status "
                                   "details below."
                                : "Create a new order status "
                                    "for better order management.",
                                style: TextStyle(
                                  color:AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CommonTextField(
                          controller: orderNameController,
                          label: "Order Status Name",
                          hint: "Enter order status name...",
                        showHeader: true,
                        headerIcon: Icons.arrow_circle_right_outlined,
                        headerText: "Status Name",
                      ),
                      CommonStatusDropdown(
                          value: selectedStatus,
                          onChanged: (val){
                            setState(() {
                              selectedStatus = val;
                            });
                          },
                        showHeader: true,
                        headerIcon: Icons.toggle_on,
                        headerText: "Status",
                      ),
                      CommonDropdown(
                        showHeader: true,
                        headerIcon: Icons.view_module_outlined,
                        headerText: "Module Status",
                        label: "Module",
                        value: moduleValue,
                        items: [
                          'Order',
                          'Production',
                          'Dispatch',
                        ],
                        onChanged: (val) {
                          setState(() => moduleValue = val);
                        },
                      ),
                      SectionTitle(
                        icon: Icons.palette_outlined,
                        title: "Appearance",
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5,),
                        padding: EdgeInsets.all(15),
                        decoration: CommonDecorations.card(),
                        child: Row(
                          children: [
                            Expanded(
                              child: buildColorSelector(
                                title: "Text Color",
                                color: textColor,
                                icon: Icons.text_format,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:  Text(
                                        'Pick a Text Color',
                                      ),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: textColor,
                                          onColorChanged: (Color color) {
                                            setState(() => textColor = color);
                                          },
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child:  Text(
                                            'Done',
                                          ),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: buildColorSelector(
                                title: "Background Color",
                                color: bgColor,
                                icon: Icons.format_color_fill_sharp,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        'Pick a Background Color',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: bgColor,
                                          onColorChanged: (Color color) {
                                            setState(() => bgColor = color);
                                          },
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child:  Text(
                                            'Done',
                                          ),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SectionTitle(
                        icon: Icons.preview,
                        title: "Preview",
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5,bottom: 15),
                        padding: EdgeInsets.all(15),
                        decoration: CommonDecorations.card(),
                        child: Column(
                          children: [
                            SectionTitle(
                              icon: Icons.preview,
                              title: "Preview",
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              margin: EdgeInsets.only(top: 10),
                              decoration: CommonDecorations.card(),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "#ORD001",
                                          style: TextStyle(
                                            color: textColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 7),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            "Status Name",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: textColor,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15,bottom: 5),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.shopping_bag_outlined,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(width: 5,),
                                        Text(
                                          "Order Details",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 15),
                                    child: Divider(
                                      color: Colors.grey.shade200,
                                      thickness: 8,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child:  Container(
                    padding: EdgeInsets.only(left: 15,right: 15,bottom: 20),
                    decoration: BoxDecoration(
                        color: Color(0xFFF6FAFF)
                    ),
                    child: GestureDetector(
                      onTap: () {
                        final mappedStatus =
                        selectedStatus == "Active" ? "1" : "0";
                        if(widget.isEdit == true){
                          BlocProvider.of<CreateEditOrderStatusBloc>(context).add(
                            EditOrderStatusEvent(
                                orderStatusId: widget.orderStatusId,
                                orderStatusName: orderNameController.text,
                                status:mappedStatus,
                                textColor: widget.textColor,
                                textBgColor: widget.textBgColor,
                                moduleStatus: widget.moduleStatus
                            )
                          );
                        }
                        else{
                          BlocProvider.of<CreateEditOrderStatusBloc>(context).add(
                            CreateOrderStatusEvent(
                                orderStatusName: orderNameController.text,
                                status:mappedStatus,
                                textColor: widget.textColor,
                                textBgColor: widget.textBgColor,
                                moduleStatus: widget.moduleStatus
                            ),
                          );
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:  AppColors.action,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                widget.isEdit == true
                                    ? "Update Order Status"
                                    : "Create Order Status",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
      )
    );
  }

  Widget buildColorSelector({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
                icon,
              color: AppColors.primary,
              size: 20,
            ),
            SizedBox(width: 5,),
            Text(
              title,
                style:  TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          decoration: CommonDecorations.card(),
          padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                   "Select Color",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                  ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionTitle({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Icon(
              icon,
              size: 18,
              color: AppColors.primary,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style:  TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
