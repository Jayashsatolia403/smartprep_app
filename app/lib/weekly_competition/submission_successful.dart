import 'package:app/weekly_competition/previous_competitions.dart';
import 'package:flutter/material.dart';

class SubmissionSuccessFul extends StatelessWidget {
  const SubmissionSuccessFul({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Submission Successful ",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "It will take 10 minute to submit and evaluate your answers.",
            style: TextStyle(fontSize: 20),
          ),
          // ElevatedButton(
          //     style: ButtonStyle(
          //         backgroundColor:
          //             MaterialStateProperty.all(Colors.deepPurpleAccent)),
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const PreviousCompetitions(),
          //           ));
          //     },
          //     child: const Text(
          //       "Go to Result",
          //       style: TextStyle(color: Colors.white),
          //     )),
        ],
      )),
    );
  }
}
