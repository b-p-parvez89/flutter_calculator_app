// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculateController extends GetxController {
  RxString userInput = ''.obs;
  RxString result = '0'.obs;

  void handelButtonPress(String text) {
    if (text == 'C') {
      userInput.value = '';
      result.value = '0';
    } 
    else if (text == '⌫') {
      if (userInput.value.isNotEmpty) {
        userInput.value =
            userInput.value.substring(0, userInput.value.length - 1);

        if (userInput.value.isEmpty) {
          result.value = '0';
        } else {
          _evaluateExpression();
        }
      }
    } 
    else if (text == '=') {
      _evaluateExpression();
      userInput.value = result.value;
    } 
    else {
      userInput.value += text;
      _evaluateExpression();
    }
  }

  void _evaluateExpression() {
    if (userInput.value.isEmpty) {
      result.value = '0';
      return;
    }

    try {
      String expression = userInput.value;

      // Replace calculator symbols
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');

      Parser parser = Parser();
      Expression exp = parser.parse(expression);

      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval.isInfinite || eval.isNaN) {
        result.value = 'Error';
        return;
      }

      if (eval % 1 == 0) {
        result.value = eval.toInt().toString();
      } else {
        result.value = eval
            .toStringAsFixed(8)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }
    } catch (e) {
      result.value = '0';
    }
  }
}