import 'package:erp_demo/common/common_action_button.dart';
import 'package:erp_demo/common/common_drop_down.dart';
import 'package:erp_demo/common/common_field.dart';
import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:erp_demo/product_module/bloc/tax_type_bloc/tax_type_bloc.dart';
import 'package:erp_demo/product_module/bloc/tax_type_bloc/tax_type_event.dart';
import 'package:erp_demo/product_module/bloc/tax_type_bloc/tax_type_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class TaxTypeBottomSheet extends StatefulWidget {
  final String taxType;

  const TaxTypeBottomSheet({
    required this.taxType,
    super.key});

  @override
  State<TaxTypeBottomSheet> createState() => _TaxTypeBottomSheetState();
}

class _TaxTypeBottomSheetState extends State<TaxTypeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaxTypeBloc(),
      child: TaxTypeBottomSheetWidget(taxType: widget.taxType,),
    );
  }
}


class TaxTypeBottomSheetWidget extends StatefulWidget {
  final String taxType;

  const TaxTypeBottomSheetWidget({
    required this.taxType,
    super.key});

  @override
  State<TaxTypeBottomSheetWidget> createState() => _TaxTypeBottomSheetWidgetState();
}

class _TaxTypeBottomSheetWidgetState extends State<TaxTypeBottomSheetWidget> {


  TextEditingController taxTypeController = TextEditingController();
  String? selectedTaxRate;



  @override
  void initState() {
    taxTypeController.text = widget.taxType;

    BlocProvider.of<TaxTypeBloc>(context)
        .add(FetchTaxTypeEvents(
        taxType: widget.taxType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<TaxTypeBloc, TaxTypeState>(
      builder: (context, state) {
        if (state is InitialTaxTypeState) {
          return Center(
           child:  SpinKitFadingCircle(
             color: Colors.blue,
             size: 40,
           ),
          );
        }
        else if(state is LoadingTaxTypeState){
          return  Center(
            child:  SpinKitFadingCircle(
              color: Colors.blue,
              size: 40,
            ),
          );
        }
        else if(state is LoadedTaxTypeState){

          return  CommonBottomSheetContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  CommonBottomSheetHeader(
                    icon: Icons.receipt_long_outlined,
                    title: "Add Tax Details",
                    themeColor: Colors.black,
                    subtitle: "Add tax details below",
                  ),
                  CommonTextField(
                      controller: taxTypeController,
                      label: "Tax Type",
                      readOnly: true,
                      hint: "Enter Tax Type",
                  ),
                  CommonDropdown(
                    label: "Tax Rate",
                    hint: "Select Tax Rate",
                    value: selectedTaxRate,
                    items: state.list.map((e) => e.taxRate)
                        .map((e) => "$e%")
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedTaxRate = val;
                      });
                    },
                  ),
                  CommonActionButton(
                      title: "Add Tax",
                      onTap: (){
                        Navigator.of(context).pop([selectedTaxRate]);
                      },
                  )
                ],
              )
          );
        }
        else if(state is FailureTaxTypeState){
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      },
    );
  }
}
