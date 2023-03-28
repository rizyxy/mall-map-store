import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  MainLayout({super.key, this.child});

  Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: child,
    ));
  }
}
