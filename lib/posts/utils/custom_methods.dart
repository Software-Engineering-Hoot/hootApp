import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/utils/errors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void flutterToast(String message, Color color) {
  Fluttertoast.showToast(
    msg: Errors.show(message),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16,
  );
}
