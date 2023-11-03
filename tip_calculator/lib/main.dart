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
        backgroundColor: const Color.fromARGB(255, 4, 61, 102),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 3, 42, 87),
            title: Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('assets/new_tip.png', height: 50),
              //const Text("Calculator", style: TextStyle(fontSize: 50)),
            ]))),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Tip Calculator!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight
                        .bold), //Theme.of(context).textTheme.headlineSmall,
              ),
              MyForm(),
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
  List<bool> selection = [true, false, false, false, false];
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
              padding: EdgeInsets.only(top: 15),
              child: Text("Bill:", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(
              width: 250,
              height: 100,
              child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 84, 203, 246))),
                      fillColor: Color.fromARGB(255, 181, 224, 255),
                      //Adds a Border
                      border: OutlineInputBorder()),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
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
              child: Text('Tip %', style: TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 10),
              child: ToggleButtons(
                borderColor: const Color.fromARGB(255, 84, 203, 246),
                fillColor: const Color.fromARGB(255, 84, 203, 246),
                borderRadius: BorderRadius.circular(10),
                selectedBorderColor: const Color.fromARGB(255, 84, 203, 246),
                isSelected: selection,
                onPressed: updateSelection,
                children: const [
                  Text('10%', style: TextStyle(color: Colors.white)),
                  Text('15%', style: TextStyle(color: Colors.white)),
                  Text('20%', style: TextStyle(color: Colors.white)),
                  Text('Chinese',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                  Text('Custom', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const Text("Custom Tip %: ", style: TextStyle(color: Colors.white)),
            SizedBox(
              width: 250,
              height: 100,
              child: TextFormField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 84, 203, 246))),
                    fillColor: Color.fromARGB(255, 181, 224, 255),
                    //Adds a Border
                    border: OutlineInputBorder()),
                style: const TextStyle(
                    fontSize: 20, height: 1, color: Colors.white),
                textAlign: TextAlign.center,
                validator: (String? value) {
                  //Check if Field is Blank
                  if (selection[4] == true &&
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
                child: Text("Tax %: ", style: TextStyle(color: Colors.white))),
            SizedBox(
              width: 250,
              height: 100,
              child: TextFormField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 84, 203, 246))),
                      fillColor: Color.fromARGB(255, 181, 224, 255),
                      //Adds a Border
                      border: OutlineInputBorder()),
                  style: const TextStyle(
                      fontSize: 20, height: 1, color: Colors.white),
                  textAlign: TextAlign.center,
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
              child: const Text('Calculate Total',
                  style: TextStyle(color: Colors.white)),
            )),
            if (total !=
                '0.00') // Check if 'tip' is not '0.00' before displaying
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  total, // Show the '$' symbol here
                  style: const TextStyle(fontSize: 35, color: Colors.white),
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
    final taxPercent = double.parse(
        (double.parse(taxController.text) / 100).toStringAsPrecision(2));
    String totalAmount = '';
    if (selection[3]) {
      totalAmount = ((bill * (1 + taxPercent)) + 2).toStringAsFixed(2);
    } else if (selection[4]) {
      tipPercent = double.parse(
          (double.parse(tipController.text) / 100).toStringAsPrecision(2));
      totalAmount =
          (bill + (bill * tipPercent) + (bill * taxPercent)).toStringAsFixed(2);
    } else {
      final selectedIndex = selection.indexWhere((element) => element);
      tipPercent = [0.1, 0.15, 0.2][selectedIndex];
      totalAmount =
          (bill + (bill * tipPercent) + (bill * taxPercent)).toStringAsFixed(2);
    }

    setState(() {
      total = '\$$totalAmount';
    });
  }
}
