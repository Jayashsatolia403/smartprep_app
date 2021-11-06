import 'package:flutter/material.dart';


class TestLayout extends StatefulWidget {
  const TestLayout({Key? key}) : super(key: key);

  @override
  _TestLayoutState createState() => _TestLayoutState();
}

class _TestLayoutState extends State<TestLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Row(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: null,
                              child: const Text("Physics", style: TextStyle(fontSize: 20, color: Colors.white),),
                            ),
                            const SizedBox(width: 20),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: null,
                              child: const Text("Chemistry", style: TextStyle(fontSize: 20, color: Colors.white),),
                            ),
                            const SizedBox(width: 20),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: null,
                              child: const Text("Maths", style: TextStyle(fontSize: 30, color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      border: Border.all(
                          width: 1.0,
                          color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                    ),
                  )
              )
            ]
        )
    );
  }
}
