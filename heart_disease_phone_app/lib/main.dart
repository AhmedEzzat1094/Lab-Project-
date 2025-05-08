import "package:flutter/material.dart";
import "screens/result_screen.dart";
import "screens/form_screen.dart";
import "screens/home_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: "/",
      routes: {
        "/": (ctx) => const HomeScreen(),
        "form_screen": (ctx) => const FormScreen(),
        "result_screen": (ctx) => const ResultScreen()
      },
    );
  }
}
