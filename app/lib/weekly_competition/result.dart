import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

Map<String, int> totalQuestions = {
  "ias": 100,
  "iasHindi": 100,
  "neet": 180,
  "ras": 150,
  "rasHindi": 150,
  "ibpsPO": 100,
  "ibpsClerk": 100,
  "sscCGL": 100,
  "sscCGLHindi": 100,
  "sscCHSL": 100,
  "nda": 150,
  "cat": 90,
  "ntpc": 100,
  "reet1": 150,
  "reet2": 150,
  "reet2Science": 150,
  "patwari": 150,
  "grade2nd": 100,
  "grade2ndScience": 150,
  "grade2ndSS": 150,
  "sscGD": 100,
  "sscMTS": 100,
  "rajPoliceConst": 150,
  "rajLDC": 150,
  "rrbGD": 150,
  "sipaper1": 100,
  "sipaper2": 100
};

class Result extends StatelessWidget {
  const Result({Key? key, required this.correctOptions, required this.examName})
      : super(key: key);

  final int correctOptions;
  final String examName;

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Correct": correctOptions.toDouble(),
      "Incorrect": totalQuestions[examName]!.toDouble() - correctOptions
    };

    return Scaffold(
      appBar: AppBar(title: const Text("Result")),
      body: Center(
          child: PieChart(
        dataMap: dataMap,
        colorList: const [Colors.green, Colors.red],
      )),
    );
  }
}
