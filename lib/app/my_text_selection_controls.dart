import 'package:flutter/material.dart';

class MyTextSelectionControls extends TextSelectionControls {
  @override
  Widget buildHandle(
      BuildContext context, TextSelectionHandleType type, double textLineHeight,
      [VoidCallback? onTap]) {
    return const CircleAvatar(
      radius: 8.0,
      backgroundColor: Colors.red,
    );
  }

  @override
  Widget buildToolbar(
      BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset selectionMidpoint,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ClipboardStatusNotifier? clipboardStatus,
      Offset? lastSecondaryTapDownPosition) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.copy),
            label: Text('Copy'),
          ),
        ],
      ),
    );
  }

  @override
  Offset getHandleAnchor(TextSelectionHandleType type, double textLineHeight) {
    // TODO: implement getHandleAnchor
    throw UnimplementedError();
  }

  @override
  Size getHandleSize(double textLineHeight) {
    // TODO: implement getHandleSize
    throw UnimplementedError();
  }
}
