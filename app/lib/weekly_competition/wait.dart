import 'package:flutter/material.dart';

class Wait extends StatelessWidget {
  const Wait({Key? key, required this.minutes}) : super(key: key);

  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        'Please wait for $minutes Minutes More to View Results.',
        style: const TextStyle(fontSize: 20),
      ),
    ));
  }
}
