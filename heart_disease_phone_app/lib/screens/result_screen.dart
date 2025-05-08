import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 35, color: Colors.grey[900]),
        foregroundColor: Colors.grey[900],
        title: const Text(
          "Result",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body:const  Column(
        children: [

        ],
      ),
    );
  }
}
