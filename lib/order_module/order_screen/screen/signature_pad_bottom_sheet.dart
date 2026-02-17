import 'package:erp_demo/common/create_edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePadBottomSheet extends StatefulWidget {
  const SignaturePadBottomSheet({super.key});

  @override
  State<SignaturePadBottomSheet> createState() => _SignaturePadBottomSheetState();
}

class _SignaturePadBottomSheetState extends State<SignaturePadBottomSheet> {

  SignatureController controller = SignatureController();

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonBottomSheetHeader(
                icon: CupertinoIcons.signature,
                title: "Signature",
                subtitle: "add your signature",
            ),
            Container(
          width: MediaQuery.of(context).size.width / 1.05,
          height: 150,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 4,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Signature(
              controller: controller,
              backgroundColor: Colors.grey.shade100,
            ),
          ),
        ),
            CommonBottomActionButtons(
                onTap: (){
                  setState(() {
                    controller.clear();
                  });
                },
                submitText: "Save",
                submitIcon: Icons.save_outlined
            )
          ],
        )
    );
  }
}
