import 'package:flutter/material.dart';

import '../styles/styles.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final Widget suffixIcon;
  final String? labelText;
  final String? Function(String?)? validate;
  final int? maxLength;

  const Input(
      {super.key,
      required this.controller,
      required this.inputType,
      required this.suffixIcon,
      this.labelText,
      this.validate,
       this.maxLength});
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: Styles.inputStyle,
        maxLength: maxLength,
        keyboardType: inputType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          suffixIconColor: Colors.lightBlue,
          fillColor: Colors.grey[900],
          filled: true,
          label: Text(
            labelText!,
            style: const TextStyle(
                color: Colors.lightBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          border: borderStyle(2, Colors.grey),
          focusedBorder: borderStyle(2, Colors.lightBlue),
          errorBorder: borderStyle(2, Colors.red),
        ),
        validator: validate,
      ),
    );
  }
}
