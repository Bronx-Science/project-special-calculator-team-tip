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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                onChanged: (val) {
                  bill = double.parse(val);
                },
                decoration: const InputDecoration(hintText: 'Bill amount'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  const Text('Custom Tip %'),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {}, child: Icon(Icons.remove_circle)),
                  SizedBox(
                    width: 8,
                  ),
                  Text('$tip %'),
                  GestureDetector(onTap: () {}, child: Icon(Icons.add_circle)),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
            Row(
              children: <Widget>[
                Text('% Tax'),
                Spacer(),
                GestureDetector(onTap: () {}, child: Icon(Icons.remove_circle)),
                SizedBox(
                  width: 8,
                ),
                Text('$tax %'),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(onTap: () {}, child: Icon(Icons.add_circle)),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                if (bill > 0) {
                  calculate();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(24)),
                child: Text(
                  'Calculate!',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
            SizedBox(height: 16,),
            tip != 0 ? Text('Tip $tip') : Container(),
            SizedBox(
              height: 8,
            ),
            total != 0 ? Text('Total Amount: $total')): Container
      ),
    );
  }
}
