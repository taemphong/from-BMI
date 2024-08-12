import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: BMIFormScreen(),
  ));
}

class BMIFormScreen extends StatefulWidget {
  const BMIFormScreen({Key? key}) : super(key: key);

  @override
  State<BMIFormScreen> createState() => _BMIFormScreenState();
}

class _BMIFormScreenState extends State<BMIFormScreen> {
  double weight = 0, height = 0, bmiResult = 0;
  final _formKey = GlobalKey<FormState>();

  Future<dynamic> _showMessageDialog(BuildContext context, String msg) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text(
                'Result',
                style: TextStyle(fontSize: 16),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(msg),
                  ],
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ]);
        });
  }

  void calculateBMI() {
  setState(() {
    bmiResult = weight / (height * height);
  });

  String message;
  if (bmiResult < 18.5) {
    message = "Underweight";
  } else if (bmiResult >= 18.5 && bmiResult < 25) {
    message = "Healthy weight";
  } else if (bmiResult >= 25 && bmiResult < 30) {
    message = "Overweight";
  } else {
    message = "Obesity";
  }

  _showMessageDialog(context, 'Your BMI is: ${bmiResult.toStringAsFixed(2)}\n$message');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(22, 20, 20, 0),
              alignment: Alignment.topLeft,
              child: const Text('Weight (kg)'),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  hintText: 'Enter your weight in kilograms',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 32.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  weight = double.parse(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Weight is required';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(22, 20, 20, 0),
              alignment: Alignment.topLeft,
              child: const Text('Height (m)'),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                ],
                decoration: InputDecoration(
                  labelText: 'Height (m)',
                  hintText: 'Enter your height in meters',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 32.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  height = double.parse(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Height is required';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text('Calculate BMI'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    calculateBMI();
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                'BMI Result: $bmiResult',
                style: const TextStyle(fontSize: 30, color: Colors.deepPurple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
