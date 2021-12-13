import 'package:flutter/material.dart';

class RateQuestion extends StatefulWidget {
  const RateQuestion({Key? key}) : super(key: key);

  @override
  _RateQuestionState createState() => _RateQuestionState();
}

class _RateQuestionState extends State<RateQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rate Question"),
        foregroundColor: Colors.deepPurpleAccent,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(
        children: const [
          Text("Quality of Question"),
          Text("Difficulty of Question"),
        ],
      ),
    );
  }
}
