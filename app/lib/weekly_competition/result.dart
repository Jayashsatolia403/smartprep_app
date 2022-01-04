import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({Key? key, required this.correctOptions}) : super(key: key);

  final String correctOptions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result")),
      body: Center(
        child: Text(
          'Correct Questions: $correctOptions',
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
