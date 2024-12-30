import 'package:flutter/material.dart';

class BgFrame extends StatelessWidget {
  final Widget? child;

  const BgFrame({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset("assets/images/splash_bg.png"),
            ),
            if (child != null) child!
          ],
        ),
      ),
    );
  }
}
