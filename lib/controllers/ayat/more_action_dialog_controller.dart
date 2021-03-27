import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MoreActionController extends GetxController{

  final editingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    editingController.text = "10";
  }

  void onAdd(){

    int text = int.tryParse(editingController.text)??1;
    editingController.text = "${++text}";
    print(editingController.text);
  }
}