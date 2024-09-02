import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void CustomToastMessage({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      fontSize: 15,
      backgroundColor: Colors.grey,
      textColor: Colors.black,
      gravity: ToastGravity.BOTTOM);
}
