import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  double bill = 0, tip = 0, tax = 0, total = 0;

  void calculate() {
    setState(() {
      tip = bill * (tip / 100);
      tax = tax / 100;
      total = bill + tip + bill * tax;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tip Calculator")),
      body: const Column(
        children: <Widget>[
          Text("Welcome to Tip Calculator",
            style:  TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
      
    );
  }
}
