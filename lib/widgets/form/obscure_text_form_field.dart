import 'package:flutter/material.dart';

class ObscureTextFormField extends StatefulWidget {
  const ObscureTextFormField(
      {super.key, required this.hintText, required this.controller});

  final String hintText;
  final TextEditingController controller;

  @override
  State<ObscureTextFormField> createState() => _ObscureTextFormFieldState();
}

class _ObscureTextFormFieldState extends State<ObscureTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
          suffixIcon: InkWell(
            child: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          isDense: true),
    );
  }
}
