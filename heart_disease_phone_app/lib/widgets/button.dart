import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function() onClick;
  final String text;
  const Button({super.key, required this.onClick, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: MaterialButton(
        color: Colors.lightBlue,
        minWidth: 150,
        height: 60,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onClick,
        child: Text(
          text,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
