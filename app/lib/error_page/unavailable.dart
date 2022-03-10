import 'package:app/weekly_competition/previous_competitions.dart';
import 'package:flutter/material.dart';

class Unavailable extends StatelessWidget {
  const Unavailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          const Center(
              child: Text(
            "Contest Not Available",
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                "Dear Student, Weekly contests are only available on Sundays. If you are looking for previous competitions Click Below.",
                style: TextStyle(fontSize: 16),
              ))),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PreviousCompetitions()));
              },
              child: const Text("Back to Home")),
        ],
      ),
    ));
  }
}
