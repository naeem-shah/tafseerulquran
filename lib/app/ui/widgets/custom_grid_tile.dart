import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGridTile extends StatelessWidget {
  const CustomGridTile({
    Key? key,
    required this.imagePath,
    required this.title,
    this.onTap,
    this.size = 60,
  }) : super(key: key);

  final String imagePath;
  final String title;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imagePath,
                height: size,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: Get.textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
