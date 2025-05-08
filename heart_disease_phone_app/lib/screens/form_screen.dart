import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            "Patient Values",
          ),
          backgroundColor: const Color(0xFF170055),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: const Column(
              children: [
              
              ],
            ),
          ),
        ),
      );
  }
}