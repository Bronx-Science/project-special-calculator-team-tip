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
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to Tip Calculator!'),
              //Spacer(flex: 1),
              MyForm()
            ],
          ),
        )
      )
    );
  }
}

//FORM

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key:key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  double bill=0.0;
  double tipPercent=0.0;
  double taxPercent=0.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final billController = TextEditingController(); //Used to Retrive data inputted into text fields
  final tipController = TextEditingController();
  final taxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          const Text("Bill:"),
          TextFormField(
            decoration: const InputDecoration(    //Adds a Border
              border: OutlineInputBorder()
            ),
            validator: (String? value) {            //Check if Field is Blank
              if(value == null || value.isEmpty) {
                return 'Please enter a bill';
              }
              return null;
            },
            controller: billController
          ),
          const Text("Tip %: "),
          TextFormField(
            decoration: const InputDecoration(    //Adds a Border
              border: OutlineInputBorder()
            ),
            validator: (String? value) {            //Check if Field is Blank
              if(value == null || value.isEmpty) {
                return 'Please enter a tip';
              }
              return null;
            },
            controller: tipController
          ),
          const Text("Tax %: "),
          TextFormField(
            decoration: const InputDecoration(    //Adds a Border
              border: OutlineInputBorder()
            ),
            validator: (String? value) {            //Check if Field is Blank
              if(value == null || value.isEmpty) {
                return 'Please enter a tax';
              }
              return null;
            },
            controller: taxController
          ),
          Center(child:
            ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                // Process data.
                bill = double.parse(billController.text);
                tipPercent = double.parse(tipController.text)/100;
                taxPercent = double.parse(taxController.text)/100;
                }
                print(bill);
                print(tipPercent);
                print(taxPercent);
              },
              child: const Text('Submit'),
            )
          )
        ]
      )
    );
  }
}