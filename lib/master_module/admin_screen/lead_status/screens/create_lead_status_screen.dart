import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CreateLeadStatus extends StatefulWidget {
  const CreateLeadStatus({super.key});

  @override
  State<CreateLeadStatus> createState() => _CreateLeadStatusState();
}

class _CreateLeadStatusState extends State<CreateLeadStatus> {

  TextEditingController leadNameController = TextEditingController();

  String selectedStatus = 'Active';
  Color textColor = Colors.black;
  Color bgColor =  Color(0xFFDCE2E7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Create Lead Status"
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15,15,15,100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color:  Colors.blue.shade50,
                    border: Border.all(color : Colors.blue.shade200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children:  [
                      Icon(
                        Icons.info_outline,
                        color:AppColors.primary,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Create a new lead status "
                              "for better order management.",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CommonTextField(
                    controller: leadNameController,
                    label: "Lead Status Name",
                    hint: "Enter lead status name...",
                  showHeader: true,
                  headerText:  "Status Name",
                  headerIcon: Icons.arrow_circle_right_outlined,
                ),
                CommonStatusDropdown(
                  value: selectedStatus,
                  onChanged: (val){
                    setState(() {
                      selectedStatus = val;
                    });
                  },
                  headerText: "Status",
                  headerIcon: Icons.toggle_on,
                  showHeader: true,
                ),
                SectionTitle(
                  icon: Icons.palette_outlined,
                  title: "Appearance",
                ),
                Container(
                  margin: EdgeInsets.only(top: 5,bottom: 15),
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
                                title:  Text('Pick a Text Color'),
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
                                    child:  Text('Done'),
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
                                    child:  Text('Done'),
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
                  margin: EdgeInsets.only(top: 5,bottom: 30),
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
              child: Container(
                padding: EdgeInsets.only(left: 15,right: 15,bottom: 20),
                decoration: BoxDecoration(
                  color: AppColors.screenBg
                ),
                child: GestureDetector(
                  onTap: () {
                    if (leadNameController.text.isEmpty) return;

                    Map<String, dynamic> newStatus = {
                      "title": leadNameController.text,
                      "bgColor": bgColor,
                      "textColor": textColor,
                      "status": selectedStatus,
                    };
                    Navigator.pop(context, newStatus);
                  },
                  child: Container(
                      padding: EdgeInsets.all(14),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:  AppColors.action,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            "Create Lead Status",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ), )
        ],
      )
    );
  }

  // Color Selector
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
              color:AppColors.primary,
              size: 20,
            ),
            SizedBox(width: 5,),
            Text(
              title,
              style:  TextStyle(
                color:AppColors.primary,
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

// Section Title Widget
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
            color:AppColors.primary,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style:  TextStyle(
              color:AppColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

