import 'package:erp_demo/common/common_list_tile_screen.dart';
import 'package:erp_demo/task_module/report_screen/screen/particular_employee_screen.dart';
import 'package:erp_demo/task_module/report_screen/screen/task_report_screen.dart';
import 'package:flutter/material.dart';
import '../../../common/app_color.dart';
import '../../../common/custom_app_bar.dart';

class ReportTaskScreen extends StatefulWidget {
  const ReportTaskScreen({super.key});

  @override
  State<ReportTaskScreen> createState() => _ReportTaskScreenState();
}

class _ReportTaskScreenState extends State<ReportTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.screenBg,
      appBar: CustomAppBar(
        leadingIcon:  Icons.article_outlined,
        title: "Report",
        subtitle: "Task Reports"
      ),
      body: Column(
        children: [
          CommonListTile(
              title: "Task Report",
              subTitle:  "To see Your Task Reports",
              icon:  Icons.trending_up,
              color:  Colors.orange,
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context)=>TaskReportScreen(),
                ),);
              },
          ),
          CommonListTile(
              title: "Particular Employee",
              subTitle:  "To see Particular Employee Task Reports",
              icon:  Icons.group,
              color:  Colors.purple,
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context)=>ParticularEmployeeScreen(),
                ),);
              },
          ),
        ],
      ),
    );
  }
}
