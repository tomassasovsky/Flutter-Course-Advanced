import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_calculator/controllers/calculator_controller.dart';
import 'package:getx_calculator/widgets/sub_result.dart';
import 'line_separator.dart';
import 'main_result.dart';

class MathResults extends StatelessWidget {
  final calculatorController = Get.find<CalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SubResult(text: '${calculatorController.firstNumber}'),
          SubResult(text: '${calculatorController.operation}'),
          SubResult(text: '${calculatorController.secondNumber}'),
          LineSeparator(),
          MainResultText(text: '${calculatorController.mathResult}'),
        ],
      ),
    );
  }
}
