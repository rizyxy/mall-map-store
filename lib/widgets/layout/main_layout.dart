import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: child,
    ));
  }
}
