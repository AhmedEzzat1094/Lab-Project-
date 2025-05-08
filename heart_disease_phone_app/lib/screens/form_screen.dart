import 'package:flutter/material.dart';
import '../styles/styles.dart';
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
  int sex = 0;
  // ignore: non_constant_identifier_names
  int chest_pain_type = 1;
  TextEditingController bpController = TextEditingController();
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
                  validate: (value) {
                    if (value!.isEmpty) {
                      "Age feild is required";
                    }
                    if (int.parse(value) < 0) {
                      "Age feild must be greater than zero";
                    }
                    if (int.parse(value) < 120) {
                      "Age feild must be smaller than or equal 120";
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Only integer numbers are allowed';
                    }
                  },
                ),

                //2
                Wrapper(
                  label: "Sex",
                  child: DropdownButton(
                    isExpanded: true,
                    value: sex,
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30),
                    underline: Styles.underline,
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("Male"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Female"),
                      )
                    ],
                    onChanged: (Object? value) {
                      sex = value as int;
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
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30),
                    underline: Styles.underline,
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Typical angina"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("Atypical angina"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("Non-anginal"),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text("Asymptomatic"),
                      )
                    ],
                    onChanged: (Object? value) {
                      chest_pain_type = value as int;
                      setState(() {});
                    },
                  ),
                ),
                //4
                Input(
                  labelText: "BP",
                  controller: bpController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.bloodtype_rounded,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                ),
                //5
                Wrapper(
                  label: "Chest pain type",
                  child: DropdownButton(
                    isExpanded: true,
                    value: chest_pain_type,
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30),
                    underline: Styles.underline,
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Typical angina"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("Atypical angina"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("Non-anginal"),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text("Asymptomatic"),
                      )
                    ],
                    onChanged: (Object? value) {
                      chest_pain_type = value as int;
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
