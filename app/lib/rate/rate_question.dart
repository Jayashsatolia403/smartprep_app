import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_tex/flutter_tex.dart';

// import 'package:katex_flutter/katex_flutter.dart';

// Future<bool> rateQuestion(int difficulty, int quality) {
//   return false;
// }

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
          const TeXView(
            child: TeXViewColumn(children: [
              TeXViewInkWell(
                id: "id_0",
                child: TeXViewColumn(children: [
                  TeXViewDocument(r"""<<p>                                
                       When \(\left[\mathrm{M}^{-1} \mathrm{~L}^{-2} \mathrm{~T}^{4} \mathrm{~A}^{2}\right] \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                       $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""",
                      style: TeXViewStyle.fromCSS(
                          'padding: 15px; color: white; background: green'))
                ]),
              )
            ]),
            style: TeXViewStyle(
              elevation: 10,
              borderRadius: TeXViewBorderRadius.all(25),
              border: TeXViewBorder.all(TeXViewBorderDecoration(
                  borderColor: Colors.blue,
                  borderStyle: TeXViewBorderStyle.Solid,
                  borderWidth: 5)),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}