import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/wrapper.dart';
import '../widgets/input.dart';
// import '../services/api_service.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  // final ApiService _apiService = ApiService();
  final TextEditingController ageController = TextEditingController();
  String sex = "male";
  String chest_pain_type = "Typical angina";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                //1
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

                //2
                Wrapper(
                  label: "Sex",
                  child: DropdownButton(
                    isExpanded: true,
                    value: sex,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30),
                    underline: Container(
                      height: 4,
                      color: Colors.lightBlue,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "male",
                        child: Text("Male"),
                      ),
                      DropdownMenuItem(
                        value: "female",
                        child: Text("Female"),
                      )
                    ],
                    onChanged: (Object? value) {
                      sex = value as String;
                      setState(() {});
                    },
                  ),
                ),
                //3
              
                Wrapper(
                  label: "Chest pain type",
                  child: DropdownButton(
                    isExpanded: true,
                    value: chest_pain_type,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30),
                    underline: Container(
                      height: 4,
                      color: Colors.lightBlue,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "male",
                        child: Text("Male"),
                      ),
                      DropdownMenuItem(
                        value: "female",
                        child: Text("Female"),
                      )
                    ],
                    onChanged: (Object? value) {
                      sex = value as String;
                      setState(() {});
                    },
                  ),
                ),
                Button(
                    onClick: () {
                      // _apiService.predictHeartDisease(age: age,
                      //       sex: sex,
                      //       chestPainType: chestPainType,
                      //        bp: bp,
                      //        cholesterol: cholesterol,
                      //        fbsOver120: fbsOver120,
                      //        ekgResults: ekgResults,
                      //        maxHr: maxHr,
                      //        exerciseAngina: exerciseAngina,
                      //        stDepression: stDepression,
                      //        slopeOfSt: slopeOfSt,
                      //        numberOfVesselsFluro: numberOfVesselsFluro,
                      //        thallium: thallium)
                    },
                    text: "Submit")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
