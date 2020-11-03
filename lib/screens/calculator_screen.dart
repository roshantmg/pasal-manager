import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userQuestions = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '^',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CALCULATOR',
          style: TextStyle(fontFamily: 'Salsa'),
        ),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue[200],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestions,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  //clear button
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestions = '';
                          userAnswer = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.yellow,
                      textColor: Colors.white,
                    );
                  }
                  //delete button
                  else if (index == 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestions = userQuestions.substring(
                              0, userQuestions.length - 1);
                          userAnswer = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white,
                    );
                    //equal button
                  } else if (index == buttons.length - 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(
                          () {
                            equalPressed();
                          },
                        );
                      },
                      buttonText: buttons[index],
                      color: Colors.blue,
                      textColor: Colors.white,
                    );
                  } else {
                    return MyButton(
                      buttonTapped: () {
                        setState(
                          () {
                            userQuestions += buttons[index];
                          },
                        );
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.blue
                          : Colors.blue[50],
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.blue,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '/' ||
        x == 'x' ||
        x == '-' ||
        x == '+' ||
        x == '=' ||
        x == '^') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestions;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButton({this.color, this.textColor, this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: 25.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
