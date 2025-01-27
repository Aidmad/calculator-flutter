import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '0';

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '0';
      } else if (value == '=') {
        try {
          result = _calculateResult(input);
        } catch (e) {
          result = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  String _calculateResult(String expression) {
    try {
      final sanitizedExpression = expression.replaceAll('×', '*').replaceAll('÷', '/');
      Parser parser = Parser();
      Expression exp = parser.parse(sanitizedExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
    } catch (e) {
      return 'Error';
    }
  }

  Widget _buildButton(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0), // Adds spacing between buttons
        child: ElevatedButton(
          onPressed: () => _buttonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16.0), // Reduced padding to make buttons smaller
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Slightly rounded corners
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), // Adjusted text size
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator by me'),
      ),
      body: Column(
        children: [
          // Display Section
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(input, style: TextStyle(fontSize: 30.0)),
                  SizedBox(height: 10),
                  Text(result, style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Divider(),
          // Buttons Grid
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7', Color(0xFF95C4F3)),
                  _buildButton('8', Color(0xFF95C4F3)),
                  _buildButton('9', Color(0xFF95C4F3)),
                  _buildButton('÷', Color(0xFF0F80ED)),
                ],
              ),
              Row(
                children: [
                  _buildButton('4', Color(0xFF95C4F3)),
                  _buildButton('5', Color(0xFF95C4F3)),
                  _buildButton('6', Color(0xFF95C4F3)),
                  _buildButton('×', Color(0xFF0F80ED)),
                ],
              ),
              Row(
                children: [
                  _buildButton('1', Color(0xFF95C4F3)),
                  _buildButton('2', Color(0xFF95C4F3)),
                  _buildButton('3', Color(0xFF95C4F3)),
                  _buildButton('-', Color(0xFF0F80ED)),
                ],
              ),
              Row(
                children: [
                  _buildButton('C', Color(0xFFD62126)),
                  _buildButton('0', Color(0xFF95C4F3)),
                  _buildButton('.', Color(0xFF95C4F3)),
                  _buildButton('+', Color(0xFF0F80ED)),
                ],
              ),
              Row(
                children: [
                  _buildButton('=', Color(0xFF0F80ED)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}