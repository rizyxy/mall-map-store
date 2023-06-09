import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Text("MALL"),
        Text(
          "MAP",
          style: TextStyle(color: Colors.red),
        )
      ],
    );
  }
}
