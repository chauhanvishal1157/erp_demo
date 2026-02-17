import 'package:erp_demo/common/common_toast.dart' show CommonToast;
import 'package:erp_demo/master_module/admin_screen/order_status/bloc/delete_order_status_bloc/delete_order_status_bloc.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/bloc/delete_order_status_bloc/delete_order_status_event.dart';
import 'package:erp_demo/master_module/admin_screen/order_status/bloc/delete_order_status_bloc/delete_order_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../common/app_color.dart';


class DeleteOrderStatusBottomSheet extends StatefulWidget {
  final String orderStatusId;

  const DeleteOrderStatusBottomSheet({
    required this.orderStatusId,
    super.key
  });

  @override
  State<DeleteOrderStatusBottomSheet> createState() => _DeleteOrderStatusBottomSheetState();
}

class _DeleteOrderStatusBottomSheetState extends State<DeleteOrderStatusBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteOrderStatusBloc(),
      child: DeleteOrderStatusBottomSheetWidget(
        orderStatusId: widget.orderStatusId,
      ),
    );
  }
}


class DeleteOrderStatusBottomSheetWidget extends StatefulWidget {
  final String orderStatusId;

  const DeleteOrderStatusBottomSheetWidget({
    required this.orderStatusId,
    super.key
  });

  @override
  State<DeleteOrderStatusBottomSheetWidget> createState() => _DeleteOrderStatusBottomSheetWidgetState();
}

class _DeleteOrderStatusBottomSheetWidgetState extends State<DeleteOrderStatusBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteOrderStatusBloc , DeleteOrderStatusState>(
      listener: (context, state){
        if(state is LoadedDeleteOrderStatusState){
          CommonToast.show(context,state.message);
          Navigator.of(context).pop(true);
        }
        else if(state is FailureDeleteOrderStatusState){
          CommonToast.show(context,state.error);
        }

      },
      builder:(context, state){
        if(state is LoadingDeleteOrderStatusState){
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        return  Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
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
                    "Delete Order Status",
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
                      " Order Status? All associated data will be"
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
                          BlocProvider.of<DeleteOrderStatusBloc>(context).add(
                              DeleteOrderStatusEvent(
                                  orderStatusId: widget.orderStatusId
                              ),
                          );
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
                                "Delete",
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
      },
    );

  }
}
