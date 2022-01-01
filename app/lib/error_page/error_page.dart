import 'package:app/home/home.dart';
import 'package:app/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

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
            "Internal Server Error",
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          )),
          const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                "Sorry for inconvenience! Our Team is Working on this issue. We will fix it as soon as possible. Thank you for your patience",
                style: TextStyle(fontSize: 16),
              ))),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Splash()));
              },
              child: const Text("Back to Home")),
        ],
      ),
    ));
  }
}
