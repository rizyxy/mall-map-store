import 'package:flutter/material.dart';

class ObscureTextFormField extends StatefulWidget {
  const ObscureTextFormField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.validator});

  final String hintText;
  final TextEditingController controller;

  final String? Function(String? value)? validator;

  @override
  State<ObscureTextFormField> createState() => _ObscureTextFormFieldState();
}

class _ObscureTextFormFieldState extends State<ObscureTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: _isObscure,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () => setState(() {
              _isObscure = !_isObscure;
            }),
            child: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          isDense: true),
    );
  }
}
