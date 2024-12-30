import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreTile extends StatelessWidget {
  const MoreTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: Colors.black54,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: Get.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
