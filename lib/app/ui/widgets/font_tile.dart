import 'package:flutter/material.dart';

class FontTile extends StatelessWidget {
  const FontTile({
    super.key,
    required this.title,
    required this.onChange,
    required this.value,
  });

  final String title;
  final int value;
  final ValueChanged<int> onChange;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              if (value >= 10) {
                onChange(value - 1);
              }
            },
            splashRadius: 18,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            padding: EdgeInsets.zero,
          ),
          Text("$value"),
          IconButton(
            onPressed: () {
              if (value <= 40) {
                onChange(value + 1);
              }
            },
            splashRadius: 18,
            icon: const Icon(Icons.keyboard_arrow_up_rounded),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
