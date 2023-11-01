import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 84, 203, 246),
          title: Image.asset('assets/tip_logo.png', height: 80),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Tip Calculator!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const MyForm(),
            ],
          ),
        ),
      ),
    );
  }
}

//FORM

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  double bill = 0.0;
  double tipPercent = 0.0;
  double taxPercent = 0.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final billController =
      TextEditingController(); //Used to Retrive data inputted into text fields
  final tipController = TextEditingController();
  final taxController = TextEditingController();
  List<bool> selection = [true, false, false, false];
  String total = '0.00';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Bill:"),
            ),
            SizedBox(
              width: 200,
              child: TextFormField(
                  decoration: const InputDecoration(
                      //Adds a Border
                      border: OutlineInputBorder()),
                  style: const TextStyle(
                      fontSize: 20, height: 2, color: Colors.black),
                  validator: (String? value) {
                    //Check if Field is Blank
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null) {
                      return 'Please enter a bill';
                    }
                    return null;
                  },
                  controller: billController),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('Tip %'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 10),
              child: ToggleButtons(
                isSelected: selection,
                onPressed: updateSelection,
                children: const [
                  Text('10%'),
                  Text('15%'),
                  Text('20%'),
                  Text('Custom')
                ],
              ),
            ),
            const Text("Custom Tip %: "),
            SizedBox(
              width: 200,
              child: TextFormField(
                decoration: const InputDecoration(
                    //Adds a Border
                    border: OutlineInputBorder()),
                style: const TextStyle(
                    fontSize: 20, height: 2, color: Colors.black),
                validator: (String? value) {
                  //Check if Field is Blank
                  if (selection[3] == true &&
                      (value == null ||
                          value.isEmpty ||
                          double.tryParse(value) == null)) {
                    return 'Please enter the tip';
                  }
                  return null;
                },
                controller: tipController,
              ),
            ),
            const Padding(
                padding: EdgeInsetsDirectional.only(top: 10),
                child: Text("Tax %: ")),
            SizedBox(
              width: 200,
              child: TextFormField(
                  decoration: const InputDecoration(
                      //Adds a Border
                      border: OutlineInputBorder()),
                  validator: (String? value) {
                    //Check if Field is Blank
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null) {
                      return 'Please enter a tax';
                    }
                    return null;
                  },
                  controller: taxController),
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                  calculateTotal();
                }
              },
              child: const Text('Submit'),
            )),
            if (total !=
                '0.00') // Check if 'tip' is not '0.00' before displaying
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  total, // Show the '$' symbol here
                  style: const TextStyle(fontSize: 30),
                ),
              ),
          ],
        ));
  }

  void updateSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < selection.length; i++) {
        selection[i] = selectedIndex == i;
      }
    });
  }

  void calculateTotal() {
    final bill =
        double.parse(double.parse(billController.text).toStringAsPrecision(2));
    if (selection[3] != false) {
      tipPercent = double.parse(
          (double.parse(tipController.text) / 100).toStringAsPrecision(2));
    } else {
      final selectedIndex = selection.indexWhere((element) => element);
      tipPercent = [0.1, 0.15, 0.2][selectedIndex];
    }
    final taxPercent = double.parse(
        (double.parse(taxController.text) / 100).toStringAsPrecision(2));

    final totalAmount =
        (bill + (bill * tipPercent) + (bill * taxPercent)).toStringAsFixed(2);

    setState(() {
      total = '\$$totalAmount';
    });
  }
}
