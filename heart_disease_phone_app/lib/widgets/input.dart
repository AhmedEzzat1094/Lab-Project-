import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final Key formKey;
  final TextEditingController controller;
  final TextInputType inputType;
  final Widget suffixIcon;
  final String? labelText;
  final String? Function(String?)? validate;

  const Input(
      {super.key,
      required this.formKey,
      required this.controller,
      required this.inputType,
      required this.suffixIcon,
      this.labelText,
      this.validate});
  InputBorder borderStyle(double width, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: width,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField();
  }
}
