
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigatePush(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);


void navigateReplacement(context, widget) =>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
Future<bool?> toast({required String message, required ToastsStates states}) {
  return Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(states),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastsStates { SUCCESS, ERROR, WARNING, MYAPP }

Color chooseToastColor(ToastsStates states) {
  Color color;
  switch (states) {
    case ToastsStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastsStates.ERROR:
      color = Colors.red;
      break;
    case ToastsStates.MYAPP:
      color = Colors.pink;
      break;
    default:
      color = Colors.amber;
      break;
  }
  return color;
}
