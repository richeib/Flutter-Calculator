import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _displayText = '0';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String? _operator;

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _clear();
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        _operator = value;
        _firstOperand = double.parse(_displayText);
        _displayText = '0';
      } else if (value == '=') {
        _calculateResult();
      } else {
        _updateDisplay(value);
      }
    });
  }

  void _clear() {
    _displayText = '0';
    _firstOperand = 0;
    _secondOperand = 0;
    _operator = null;
  }

  void _updateDisplay(String value) {
    if (_displayText == '0') {
      _displayText = value;
    } else {
      _displayText += value;
    }
  }

  void _calculateResult() {
    _secondOperand = double.parse(_displayText);
    switch (_operator) {
      case '+':
        _displayText = (_firstOperand + _secondOperand).toString();
        break;
      case '-':
        _displayText = (_firstOperand - _secondOperand).toString();
        break;
      case '*':
        _displayText = (_firstOperand * _secondOperand).toString();
        break;
      case '/':
        _displayText = _secondOperand != 0
            ? (_firstOperand / _secondOperand).toString()
            : 'Error';
        break;
      default:
        _displayText = '0';
    }
    _operator = null;
  }

  Widget _buildButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            primary: Colors.blueGrey,
          ),
          onPressed: () => _buttonPressed(value),
          child: Text(
            value,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: Text(
                _displayText,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('C'),
                  _buildButton('0'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
