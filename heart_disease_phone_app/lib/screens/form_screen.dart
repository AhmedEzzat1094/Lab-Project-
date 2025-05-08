import 'package:flutter/material.dart';
import '../styles/styles.dart';
import '../widgets/button.dart';
import '../widgets/wrapper.dart';
import '../widgets/input.dart';
import '../services/api_service.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final ApiService _apiService = ApiService();

  // Controllers for text inputs
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bpController = TextEditingController();
  final TextEditingController cholesterolController = TextEditingController();
  final TextEditingController maxHrController = TextEditingController();
  final TextEditingController stDepressionController = TextEditingController();

  // State variables for dropdowns
  int sex = 0;
  int chestPainType = 1;
  int fbsOver120 = 0;
  int ekgResults = 0;
  int exerciseAngina = 0;
  int slopeOfSt = 1;
  int numberOfVesselsFluro = 0;
  int thallium = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(size: 35, color: Colors.grey[900]),
        foregroundColor: Colors.grey[900],
        title: const Text(
          "Symptoms Form",
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Age
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
                    if (value!.isEmpty) return "Age field is required";
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Only integer numbers are allowed';
                    }
                    final age = int.tryParse(value) ?? 0;
                    if (age <= 0) return "Age must be greater than zero";
                    if (age > 120) return "Age must be 120 or less";
                    return null;
                  },
                ),

                // 2. Sex
                Wrapper(
                  label: "Sex",
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: sex,
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                    underline: Styles.underline,
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("Female"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Male"),
                      )
                    ],
                    onChanged: (int? value) {
                      setState(() => sex = value ?? 0);
                    },
                  ),
                ),

                // 3. Chest Pain Type
                Wrapper(
                  label: "Chest pain type",
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: chestPainType,
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
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
                        child: Text("Non-anginal pain"),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text("Asymptomatic"),
                      )
                    ],
                    onChanged: (int? value) {
                      setState(() => chestPainType = value ?? 1);
                    },
                  ),
                ),

                // 4. Blood Pressure
                Input(
                  labelText: "Resting Blood Pressure (mm Hg)",
                  controller: bpController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.monitor_heart_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                  validate: (value) {
                    if (value!.isEmpty) return "BP is required";
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Only numbers allowed';
                    }
                    final bp = int.tryParse(value) ?? 0;
                    if (bp < 50) return "BP too low (min 50)";
                    if (bp > 250) return "BP too high (max 250)";
                    return null;
                  },
                ),

                // 5. Cholesterol
                Input(
                  labelText: "Serum Cholesterol (mg/dl)",
                  controller: cholesterolController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.bloodtype_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                  validate: (value) {
                    if (value!.isEmpty) return "Cholesterol is required";
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Only numbers allowed';
                    }
                    final cholesterol = int.tryParse(value) ?? 0;
                    if (cholesterol < 100) return "Minimum 100 mg/dl";
                    if (cholesterol > 600) return "Maximum 600 mg/dl";
                    return null;
                  },
                ),

                // 6. Fasting Blood Sugar
                Wrapper(
                  label: "Fasting Blood Sugar > 120 mg/dl",
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: fbsOver120,
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                    underline: Styles.underline,
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("No"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Yes"),
                      )
                    ],
                    onChanged: (int? value) {
                      setState(() => fbsOver120 = value ?? 0);
                    },
                  ),
                ),

                // 7. EKG Results
                Wrapper(
                  label: "Resting EKG Results",
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: ekgResults,
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                    underline: Styles.underline,
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("Normal"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("ST-T Abnormality"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("LV Hypertrophy"),
                      )
                    ],
                    onChanged: (int? value) {
                      setState(() => ekgResults = value ?? 0);
                    },
                  ),
                ),

                // 8. Max Heart Rate
                Input(
                  labelText: "Maximum Heart Rate Achieved",
                  controller: maxHrController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.favorite_outline,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  maxLength: 3,
                  validate: (value) {
                    if (value!.isEmpty) return "Heart rate is required";
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Only numbers allowed';
                    }
                    final hr = int.tryParse(value) ?? 0;
                    if (hr < 50) return "Minimum 50 bpm";
                    if (hr > 220) return "Maximum 220 bpm";
                    return null;
                  },
                ),

                // 9. Exercise Angina
                Wrapper(
                  label: "Exercise-Induced Angina",
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: exerciseAngina,
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                    underline: Styles.underline,
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("No"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Yes"),
                      )
                    ],
                    onChanged: (int? value) {
                      setState(() => exerciseAngina = value ?? 0);
                    },
                  ),
                ),

                // 10. ST Depression
                Input(
                  labelText: "ST Depression Induced by Exercise",
                  controller: stDepressionController,
                  inputType: TextInputType.number,
                  suffixIcon: const Icon(
                    Icons.show_chart_outlined,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  validate: (value) {
                    if (value!.isEmpty) return "ST depression is required";
                    final stDepression = double.tryParse(value) ?? 0.0;
                    if (stDepression < 0) return "Minimum 0";
                    if (stDepression > 10) return "Maximum 10";
                    return null;
                  },
                ),

                // 11. Slope of ST Segment
                Wrapper(
                  label: "Slope of Peak Exercise ST Segment",
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: slopeOfSt,
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                    underline: Styles.underline,
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Upsloping"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("Flat"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("Downsloping"),
                      )
                    ],
                    onChanged: (int? value) {
                      setState(() => slopeOfSt = value ?? 1);
                    },
                  ),
                ),

                // 12. Number of Vessels (Fluoroscopy)
                Wrapper(
                  label: "Number of Major Vessels (0-3)",
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: numberOfVesselsFluro,
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                    underline: Styles.underline,
                    items: const [
                      DropdownMenuItem(value: 0, child: Text("0")),
                      DropdownMenuItem(value: 1, child: Text("1")),
                      DropdownMenuItem(value: 2, child: Text("2")),
                      DropdownMenuItem(value: 3, child: Text("3")),
                    ],
                    onChanged: (int? value) {
                      setState(() => numberOfVesselsFluro = value ?? 0);
                    },
                  ),
                ),

                // 13. Thallium Stress Test
                Wrapper(
                  label: "Thallium Stress Test Result",
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: thallium,
                    style: Styles.inputStyle,
                    dropdownColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                    underline: Styles.underline,
                    items: const [
                      DropdownMenuItem(
                        value: 3,
                        child: Text("Normal"),
                      ),
                      DropdownMenuItem(
                        value: 6,
                        child: Text("Fixed Defect"),
                      ),
                      DropdownMenuItem(
                        value: 7,
                        child: Text("Reversible Defect"),
                      )
                    ],
                    onChanged: (int? value) {
                      setState(() => thallium = value ?? 3);
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Submit Button
                Button(
                  onClick: () {
                    if (formKey.currentState!.validate()) {
                      // Uncomment when API service is ready
                      _apiService
                          .predictHeartDisease(
                        age: int.parse(ageController.text),
                        sex: sex,
                        chestPainType: chestPainType,
                        bp: int.parse(bpController.text),
                        cholesterol: int.parse(cholesterolController.text),
                        fbsOver120: fbsOver120,
                        ekgResults: ekgResults,
                        maxHr: int.parse(maxHrController.text),
                        exerciseAngina: exerciseAngina,
                        stDepression: double.parse(stDepressionController.text),
                        slopeOfSt: slopeOfSt,
                        numberOfVesselsFluro: numberOfVesselsFluro,
                        thallium: thallium,
                      )
                          .then((result) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(result['hasDisease']
                                ? "Risk Detected"
                                : "No Risk Detected"),
                            content: Text(result['message']),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text("OK"),
                              )
                            ],
                          ),
                        );
                      });

                      // Temporary demo response
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Submission Successful"),
                          content: const Text(
                              "All fields validated. Ready for API integration."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  text: "Submit",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    bpController.dispose();
    cholesterolController.dispose();
    maxHrController.dispose();
    stDepressionController.dispose();
    super.dispose();
  }
}
