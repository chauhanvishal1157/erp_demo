import 'dart:io';
import 'package:erp_demo/common/app_color.dart';
import 'package:erp_demo/common/common_app_bar.dart';
import 'package:erp_demo/common/common_decoration.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(
          title: "Account Details",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(
                    color: Colors.blue.shade100,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : AssetImage("assets/default_avatar.png") as ImageProvider,
                      child: _profileImage == null
                          ? Icon(Icons.person, size: 50, color: Colors.blue)
                          : null,
                    ),
                  ),
                   SizedBox(height: 20),
                   Text(
                    "#ts - Vishal Chauhan",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        border: Border.all(
                            color: Colors.green.shade200,
                        ),
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 8,
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 15,right: 15),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  information(
                      "full Name",
                      "#ts-Vishal Chauhan",
                      Colors.blue,
                      Icons.badge_outlined,
                  ),
                  information(
                    "Phone Number",
                    "+91 9876543210",
                    Colors.green,
                    Icons.call,
                  ),
                  information(
                    "Email Address",
                    "shisshivang@gmail.com",
                    Colors.blue,
                    Icons.mail_outline,
                  ),
        
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 50),
              decoration: CommonDecorations.card(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "Location Details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  information(
                    "Country",
                    "India",
                    Colors.red,
                    Icons.flag_outlined,
                  ),
                  information(
                    "State",
                    "Gujarat",
                    Colors.purple,
                    Icons.menu_book,
                  ),
                  information(
                    "City",
                    "Ahmedabad",
                    Colors.green,
                    Icons.business,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget information(
      String title,
      String subtitle,
      Color color,
      IconData icon
      ){
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(10),
      decoration: CommonDecorations.card(),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5,),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
