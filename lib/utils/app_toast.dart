import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void displayToast(String message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.white,
    textColor: const Color.fromRGBO(20, 50, 65, 1.0),
    fontSize: 18,
    timeInSecForIosWeb: 1,
  );
}
