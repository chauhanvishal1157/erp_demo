import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonToast {
  static void show(
      BuildContext context, String msg) {
    final fToast = FToast();
    fToast.init(context);

    fToast.showToast(
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
