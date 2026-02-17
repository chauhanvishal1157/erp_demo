import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';

class DeleteBranchMaster extends StatefulWidget {

   const DeleteBranchMaster({super.key,});

  @override
  State<DeleteBranchMaster> createState() => _DeleteBranchMasterState();
}

class _DeleteBranchMasterState extends State<DeleteBranchMaster> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
      decoration: BoxDecoration(
        color: AppColors.screenBg,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delete Branch",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.close_sharp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  size: 30,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alert!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "This action cannot be undone",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Colors.grey.shade300,
              ),
            ),
            child: Text(
                "Are you sure you want to delete this"
                " branch? All associated data will be"
                " permanently removed from the system.",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 15,bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    onTap: ()  {

                    },
                    child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        border: Border.all(
                            color: Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Delete Branch",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
