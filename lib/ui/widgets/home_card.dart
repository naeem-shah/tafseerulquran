import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCardWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onTap;

  const HomeCardWidget({Key key,@required this.title,@required this.iconData, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(iconData,size: 60,color: Get.theme.accentColor,),
          SizedBox(height: 16,),
          Text(title,style: TextStyle(fontSize: 18),),
          SizedBox(height: 16,)
        ],
      ),
    );
  }
}
