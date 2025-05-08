import 'package:flutter/material.dart';
import '/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/roboat.png",
          ),
          Button(
              onClick: () {
                Navigator.pushReplacementNamed(context, "form_screen");
              },
              text: "Do Check")
        ],
      ),
    );
  }
}
