import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toaster {

  static Future<bool?> toast(String message) => Fluttertoast.showToast(msg: message,backgroundColor: Colors.black54);
}