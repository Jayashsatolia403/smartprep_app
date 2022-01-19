import 'package:flutter/material.dart';

class SubmissionSuccessFul extends StatelessWidget {
  const SubmissionSuccessFul({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: const [
          Text("Submission Successful"),
          Text("You can go to results page now"),
        ],
      )),
    );
  }
}
