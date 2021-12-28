import 'package:app/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:katex_flutter/katex_flutter.dart';

class RateQuestion extends StatefulWidget {
  const RateQuestion({Key? key}) : super(key: key);

  @override
  _RateQuestionState createState() => _RateQuestionState();
}

class _RateQuestionState extends State<RateQuestion> {
  Future<bool?> showRattinPage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: [
                ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ))
              ],
              title: Column(
                children: [
                  const Text("Quality"),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      // Navigator.pop(context);
                    },
                  ),
                  const Text("Difficulty"),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      // Navigator.pop(context);
                    },
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showRattinPage(context);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Splash()),
                  );
                }),
            title: const Text("Rate Question",
                style: TextStyle(color: Colors.white)),
            // foregroundColor: Colors.deepPurpleAccent,
            backgroundColor: Colors.deepPurpleAccent,
          ),
          body: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  "Quality of Question",
                  style: TextStyle(fontSize: 20),
                )),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    ],
                  )),
              const Center(
                  child: Text(
                "Difficulty of Question",
                style: TextStyle(fontSize: 20),
              )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ))),
            ],
          ),
        ));
  }
}
