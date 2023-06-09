import 'package:flutter/material.dart';

class NormalTextFormField extends StatelessWidget {
  const NormalTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.maxLines = 1});

  final TextEditingController controller;
  final String hintText;
  final String? Function(String? value)? validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: const TextStyle(fontSize: 14),
      maxLines: maxLines,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          isDense: true),
    );
  }
}
