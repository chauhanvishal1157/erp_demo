import 'package:erp_demo/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditLeadStatus extends StatefulWidget {

  final Map<String, dynamic>? initialData;

  const EditLeadStatus({super.key, this.initialData});

  @override
  State<EditLeadStatus> createState() => _EditLeadStatusState();
}

class _EditLeadStatusState extends State<EditLeadStatus> {

  late TextEditingController leadNameController;
  String selectedStatus = 'Active';
  Color textColor = Colors.black;
  Color bgColor =  Color(0xFFDCE2E7);

  @override
  void initState() {
    super.initState();

    leadNameController = TextEditingController(text: widget.initialData?["title"] ?? "");
    selectedStatus = widget.initialData?["status"] ?? "Active";
    textColor = widget.initialData?["textColor"] ?? Colors.black;
    bgColor = widget.initialData?["bgColor"] ?? Color(0xFFDCE2E7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        title: Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: 8,),
            Text(
              "Edit Lead Status",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
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
                    border: Border.all(color: Colors.blue.shade200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children:  [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Update the order status details below. ",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SectionTitle(
                  icon: Icons.arrow_circle_right_outlined,
                  title: "Status Name",
                ),
                Container(
                  margin: EdgeInsets.only(top: 5,bottom: 15),
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 6,
                            offset: Offset(1, 1)
                        )
                      ]
                  ),
                  child: TextFormField(
                    style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                    controller: leadNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Order Status Name",
                      labelStyle:  TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      hintText: "Enter order status name...",
                      hintStyle:  TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SectionTitle(
                  icon: Icons.toggle_on,
                  title: "Status",
                ),
                buildDropdown(
                  "Select Status",
                  selectedStatus,
                  ['Active', 'In Active'],
                  onChanged: (val) {
                    if (val != null) setState(() => selectedStatus = val); // ⬅️ check for null
                  },
                ),

                SectionTitle(
                  icon: Icons.palette_outlined,
                  title: "Appearance",
                ),
                Container(
                  margin: EdgeInsets.only(top: 5,bottom: 15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 6,
                            offset: Offset(1, 1)
                        )
                      ]
                  ),
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
                                title: const Text('Pick a Text Color'),
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
                                    child: const Text('Done'),
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
                                    child: const Text('Done'),
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
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 6,
                            offset: Offset(1, 1)
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      SectionTitle(
                        icon: Icons.preview,
                        title: "Preview",
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 6,
                                  offset: Offset(1, 1)
                              )
                            ]
                        ),
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
              child:   Container(
                padding: EdgeInsets.only(left: 15,right: 15,bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: GestureDetector(
                  onTap: () {
                    if(leadNameController.text.isEmpty) return;
                    Map<String,dynamic> updatedStatus = { // ⬅️ create updated map
                      "title": leadNameController.text,
                      "bgColor": bgColor,
                      "textColor": textColor,
                      "status": selectedStatus, // ⬅️ updated status
                    };
                    Navigator.pop(context, updatedStatus); // ⬅️ return to previous screen
                  },
                  child: Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(top: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:  Color(0xFF0093E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            "Update Lead Status",
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
      )

    );
  }
  Widget buildDropdown(
      String label,
      String value,
      List<String> items,
      {required ValueChanged<String?> onChanged}
      ) {
    return Container(
      margin: EdgeInsets.only(top: 5,bottom: 15),
      padding:  EdgeInsets.symmetric(horizontal: 10,),
      decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 6,
                offset: Offset(1, 1)
            )
          ]
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        icon:  Icon(
          Icons.keyboard_arrow_down,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle:  TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          border: InputBorder.none,
        ),
        onChanged:onChanged,
        items: items.map((e) => DropdownMenuItem(
          value: e,
          child: Row(
            children: [
              if (label == "Select Status")
                Container(
                  width: 10,
                  height: 10,
                  margin:  EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: e == "Active"
                        ? Colors.green
                        : Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              Text(
                e,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        )).toList(),
      ),
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
              color: Colors.blue,
              size: 20,
            ),
            SizedBox(width: 5,),
            Text(
              title,
              style:  TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
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
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.blue,
        ),
        SizedBox(width: 8),
        Text(
          title,
          style:  TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
