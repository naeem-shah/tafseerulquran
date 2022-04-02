import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafseer/app/models/index_model.dart';

import '../../assets/custom_fonts.dart';

class IndexTile extends StatelessWidget {
  const IndexTile({
    Key? key,
    required this.indexModel,
    this.onTap,
  }) : super(key: key);

  final IndexModel indexModel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            leading: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.primaryColor.withOpacity(0.7),
              ),
              child: Text(
                "${indexModel.id}",
                style: Get.textTheme.subtitle1?.copyWith(color: Colors.white),
              ),
            ),
            trailing: Text(
              indexModel.nameEng,
              style: const TextStyle(),
            ),
            title: Text(
              indexModel.name,
              style: const TextStyle(
                fontFamily: AppFonts.nooreHuda,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
