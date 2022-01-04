import 'package:app/article/article_view.dart';
import 'package:app/exam_select/select_exam.dart';
import 'package:app/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

List<List<String>> urlTitles = [
  [
    "Ten Things Successful People Do Differently ",
    "https://www.linkedin.com/pulse/things-successful-people-who-actually-happy-do-dr-travis-bradberry",
    "https://www.incimages.com/uploaded_files/image/1024x576/getty_495142964_198701.jpg"
  ],
  [
    "13 Things You Should Give Up If You Want To Be Successful",
    "https://medium.com/@zdravko/13-things-you-need-to-give-up-if-you-want-to-be-successful-44b5b9b06a26#.7pe14to63",
    "https://miro.medium.com/max/2400/1*Nm4_WwWrQT2eveqwpr6d9g.jpeg"
  ],
  [
    "Is achieving true happiness a possibility?",
    "https://rawsomeee.medium.com/is-achieving-true-happiness-a-possibility-209ca036a5bc",
    "https://cdn2.psychologytoday.com/assets/styles/manual_crop_1_91_1_1528x800/public/field_blog_entry_teaser_image/2021-07/success3.jpg"
  ],
  [
    "Don't Make A New Year Resolution!",
    "https://roybntz.medium.com/dont-make-a-new-year-resolution-83139f5c0e66",
    "https://miro.medium.com/max/1400/0*Td1PDbC9Mkw-sqjp"
  ]
];

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = urlTitles
        .map((item) => Container(
                child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArticleView(url: item[1])));
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item[2],
                            fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              item[0],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            )))
        .toList();

    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: imageSliders,
      ),
    );
  }
}
