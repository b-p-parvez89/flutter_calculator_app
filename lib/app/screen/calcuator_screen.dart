import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/calculate_controller.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});

  // Inject the controller using Get.put()
  final CalculateController controller = Get.put(CalculateController());

  final List<String> buttons = [
  'C', '(', ')', '÷',
  '7', '8', '9', '×',
  '4', '5', '6', '-',
  '1', '2', '3', '+',
  '0', '.', '⌫', '='
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1. Output Screen Area
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Obx listens to userInput changes automatically
                    Obx(() => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        controller.userInput.value,
                        style: const TextStyle(fontSize: 28, color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                    )),
                    const SizedBox(height: 15),
                    // Obx listens to result changes automatically
                    Obx(() => Text(
                      controller.result.value,
                      style: const TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
              ),
            ),
            
            // 2. Keypad Area
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: const BoxDecoration(
                color: Color(0xFF222427),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  return _buildButton(buttons[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Beautiful Button Custom Component
  Widget _buildButton(String text) {
    bool isOperator = ['÷', '×', '-', '+', '='].contains(text);
    bool isSpecial = ['C', '(', ')', '⌫'].contains(text);

    Color buttonColor;
    Color textColor;

    if (text == '=') {
      buttonColor = const Color(0xFFFF9500); // Classic vibrant orange
      textColor = Colors.white;
    } else if (isOperator) {
      buttonColor = const Color(0xFF2C2F33);
      textColor = const Color(0xFFFF9500);
    } else if (isSpecial) {
      buttonColor = const Color(0xFF2C2F33);
      textColor = const Color(0xFF00D2FF); // Modern cyan accent
    } else {
      buttonColor = const Color(0xFF17181A);
      textColor = Colors.white;
    }

    return InkWell(
      onTap: () => controller.handelButtonPress(text),
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}