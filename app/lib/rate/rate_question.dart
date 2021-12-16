import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:katex_flutter/katex_flutter.dart';

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
        title:
            const Text("Rate Question", style: TextStyle(color: Colors.white)),
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
              child: Center(
                  child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ))),
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
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ))),
          KaTeX(
            laTeXCode: Text(
                r'Let $z \in C$ with ${Im}(z)=10$ and it satisfies $\frac{2 z-n}{2 z+n}=2 i-1$ for some natural number $n$, then ',
                style: Theme.of(context).textTheme.bodyText2),
          )
        ],
      ),
    );
  }
}
