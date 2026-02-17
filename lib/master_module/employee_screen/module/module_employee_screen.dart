import 'package:erp_demo/common/common_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class ModuleEmployeeScreen extends StatefulWidget {
  const ModuleEmployeeScreen({super.key});

  @override
  State<ModuleEmployeeScreen> createState() => _ModuleEmployeeScreenState();
}

class _ModuleEmployeeScreenState extends State<ModuleEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonAppBar(title: "Modules Master"),
    );
  }
}
