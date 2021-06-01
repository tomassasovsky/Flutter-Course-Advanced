import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_calculator/controllers/calculator_controller.dart';
import 'package:getx_calculator/widgets/calc_button.dart';
import 'package:getx_calculator/widgets/math_results.dart';

class CalculatorScreen extends StatelessWidget {
  final calculatorController = Get.put(CalculatorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(child: Container()),
              MathResults(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton(
                    text: 'AC',
                    bgColor: Color(0xffA5A5A5),
                    onPressed: () => calculatorController.allClear(),
                  ),
                  CalculatorButton(
                    text: '+/-',
                    bgColor: Color(0xffA5A5A5),
                    onPressed: () => calculatorController.changeNegativePositive(),
                  ),
                  CalculatorButton(
                    text: 'del',
                    bgColor: Color(0xffA5A5A5),
                    onPressed: () => calculatorController.deleteLastEntry(),
                  ),
                  CalculatorButton(
                    text: '/',
                    bgColor: Color(0xffF0A23B),
                    onPressed: () => calculatorController.selectOperation('/'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton(
                    text: '7',
                    onPressed: () => calculatorController.addNumber('7'),
                  ),
                  CalculatorButton(
                    text: '8',
                    onPressed: () => calculatorController.addNumber('8'),
                  ),
                  CalculatorButton(
                    text: '9',
                    onPressed: () => calculatorController.addNumber('9'),
                  ),
                  CalculatorButton(
                    text: 'X',
                    bgColor: Color(0xffF0A23B),
                    onPressed: () => calculatorController.selectOperation('X'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton(
                    text: '4',
                    onPressed: () => calculatorController.addNumber('4'),
                  ),
                  CalculatorButton(
                    text: '5',
                    onPressed: () => calculatorController.addNumber('5'),
                  ),
                  CalculatorButton(
                    text: '6',
                    onPressed: () => calculatorController.addNumber('6'),
                  ),
                  CalculatorButton(
                    text: '-',
                    bgColor: Color(0xffF0A23B),
                    onPressed: () => calculatorController.selectOperation('-'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton(
                    text: '1',
                    onPressed: () => calculatorController.addNumber('1'),
                  ),
                  CalculatorButton(
                    text: '2',
                    onPressed: () => calculatorController.addNumber('2'),
                  ),
                  CalculatorButton(
                    text: '3',
                    onPressed: () => calculatorController.addNumber('3'),
                  ),
                  CalculatorButton(
                    text: '+',
                    bgColor: Color(0xffF0A23B),
                    onPressed: () => calculatorController.selectOperation('+'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CalculatorButton(
                    text: '0',
                    big: true,
                    onPressed: () => calculatorController.addNumber('0'),
                  ),
                  CalculatorButton(
                    text: '.',
                    onPressed: () => calculatorController.addDecimalPoint(),
                  ),
                  CalculatorButton(
                    text: '=',
                    bgColor: Color(0xffF0A23B),
                    onPressed: () => calculatorController.calculateResult(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
