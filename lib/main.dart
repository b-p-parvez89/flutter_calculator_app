import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/screen/calcuator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Calculator',
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF17181A),
      ),
    );
  }
}
