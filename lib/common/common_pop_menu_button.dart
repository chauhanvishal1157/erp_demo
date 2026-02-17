import 'package:flutter/material.dart';

class CommonPopMenuButton extends StatelessWidget {
  final VoidCallback value1;
  final VoidCallback value2;
  final VoidCallback? value3;
  final VoidCallback? value4;

  final String? textValue1;
  final String? textValue2;
  final String? textValue3;
  final String? textValue4;

  final IconData? icon1;
  final IconData? icon2;
  final IconData? icon3;
  final IconData? icon4;

  final Color? containerColor1;
  final Color? containerColor2;
  final Color? containerColor3;
  final Color? containerColor4;
  final Color? popMenuColor;


  final Color? iconColor1;
  final Color? iconColor2;
  final Color? iconColor3;
  final Color? iconColor4;
  final Color? popMenuIconColor;


  final Color? textColor1;
  final Color? textColor2;
  final Color? textColor3;
  final Color? textColor4;
  final Widget? child;


  const CommonPopMenuButton({
    super.key,
    required this.value1,
    required this.value2,
    this.value3,
    this.value4,

    this.textValue1,
    this.textValue2,
    this.textValue3,
    this.textValue4,

    this.icon1,
    this.icon2,
    this.icon3,
    this.icon4,

    this.containerColor1,
    this.containerColor2,
    this.containerColor3,
    this.containerColor4,
    this.popMenuColor,

    this.iconColor1,
    this.iconColor2,
    this.iconColor3,
    this.iconColor4,
    this.popMenuIconColor,


    this.textColor1,
    this.textColor2,
    this.textColor3,
    this.textColor4,

    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (value) {
        if (value == 1) {
          value1();
        } else if (value == 2) {
          value2();
        } else if (value == 3 && value3 != null) {
          value3!();
        }else if (value == 4 && value4 != null) {
          value4!();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:containerColor1 ?? Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child:  Icon(
                  icon1 ?? Icons.edit,
                  color:iconColor1 ?? Colors.blue,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                  textValue1 ?? "Update",
                style: TextStyle(
                  color: textColor1 ?? Colors.black
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Container(
                padding:  EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: containerColor2 ?? Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child:  Icon(
                  icon2 ?? Icons.delete_outline,
                  color:iconColor2 ?? Colors.blue,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
               Text(
                 textValue2 ?? "Delete",
                 style: TextStyle(
                     color: textColor2 ?? Colors.black
                 ),
              ),
            ],
          ),
        ),
        if(value3 != null)
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Container(
                padding:  EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: containerColor3 ?? Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child:  Icon(
                  icon3 ?? Icons.delete_outline,
                  color: iconColor3 ?? Colors.blue,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                textValue3 ?? "History",
                style: TextStyle(
                    color: textColor3 ?? Colors.black
                ),
              ),
            ],
          ),
        ),
        if (value4 != null)
          PopupMenuItem(
            value: 4,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: containerColor4 ?? Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    icon4 ?? Icons.info_outline,
                    color: iconColor4 ?? Colors.blue,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  textValue4 ?? "View",
                  style: TextStyle(
                      color: textColor4 ?? Colors.black
                  ),
                ),
              ],
            ),
          ),

      ],
      child: child ??
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: popMenuColor ?? Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child:  Icon(
              Icons.more_vert,
              size: 16,
              color: popMenuIconColor ?? Colors.black87,
            ),
          ),
    );
  }


}
