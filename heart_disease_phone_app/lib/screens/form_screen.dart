import 'package:flutter/material.dart';
import '../widgets/input.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(size: 35, color: Colors.grey[900]),
        foregroundColor: Colors.grey[900],
        title: const Text(
          "Syptoms Form",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Input(
                  labelText: "Age",
                  controller: ageController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                ),
                Input(
                  labelText: "Age",
                  controller: ageController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                ),
                Input(
                  labelText: "Age",
                  controller: ageController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                ),
                Input(
                  labelText: "Age",
                  controller: ageController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                ),
                Input(
                  labelText: "Age",
                  controller: ageController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                ),
                Input(
                  labelText: "Age",
                  controller: ageController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                ),
                Input(
                  labelText: "Age",
                  controller: ageController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                ),
                Input(
                  labelText: "Age",
                  controller: ageController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
