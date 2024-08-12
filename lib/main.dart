import 'package:flutter/material.dart';
import 'formValidation1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Form Elements'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        
        children: [
          Image.asset(
            'assets/bmi.jpg', 
          width: 200, 
          height: 200, 
        ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: Text('กดปุ่มเพื่อคำนวณ BMI')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              elevation: 0, // Shadow scale
            ),
            onPressed: () {
              // TODO: go to FormValidationPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BMIFormScreen(),
                ),
              );
            },
            child: const Text('BMI Calculator'),
          ),
        ],
      ),
    );
  }
}
