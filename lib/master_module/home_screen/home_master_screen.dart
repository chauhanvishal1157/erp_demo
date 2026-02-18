import 'package:flutter/material.dart';

import '../../common/app_color.dart';
import '../../common/common_home_app_bar.dart';


class HomeMasterScreen extends StatefulWidget {
  const HomeMasterScreen({super.key});

  @override
  State<HomeMasterScreen> createState() => _HomeMasterScreenState();
}

class _HomeMasterScreenState extends State<HomeMasterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: CommonHomeAppBar(),
      body: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: (){

              },
                child: Text("CHAUHAN")),
          )
        ],
      ),
    );
  }
}
