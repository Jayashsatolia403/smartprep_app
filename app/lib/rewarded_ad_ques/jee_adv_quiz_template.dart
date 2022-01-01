import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:katex_flutter/katex_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app/ad_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;
  bool isCorrect;

  RadioModel(this.isSelected, this.buttonText, this.text, this.isCorrect);
}

class JeeCustomRadio extends StatefulWidget {
  JeeCustomRadio(
      {Key? key,
      required this.options,
      required this.statement,
      required this.quesUUid,
      required this.qualityRating,
      required this.difficultyRating,
      required this.isRated,
      required this.createdBy})
      : super(key: key);

  final List<dynamic> options;
  // ignore: prefer_typing_uninitialized_variables
  var statement;
  String quesUUid;
  double qualityRating;
  double difficultyRating;
  bool isRated;
  String createdBy;

  @override
  createState() {
    return JeeCustomRadioState();
  }
}

class JeeCustomRadioState extends State<JeeCustomRadio> {
  bool isBookmarked = false;
  bool isAnswered = false;
  Future<bool?> showRatingsPage(BuildContext context, String uuid) async {
    double difficultyRating = 1;
    double qualityRating = 1;

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
                    onPressed: () async {
                      String url =
                          await rootBundle.loadString('assets/text/url.txt');
                      final prefs = await SharedPreferences.getInstance();
                      String? token = prefs.getString("token");

                      await http.get(
                        Uri.parse(
                            '$url/rateQues?id=$uuid&difficulty=$difficultyRating&ratings=$qualityRating'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization': "Token $token"
                        },
                      );

                      setState(() {
                        widget.isRated = true;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ))
              ],
              title: Column(
                children: [
                  const Text("Please Rate the Question"),
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
                      qualityRating = rating;
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
                      difficultyRating = rating;
                    },
                  )
                ],
              ),
            ));
  }

  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);

    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
            adUnitId: adState.bannerAdUnitId,
            size: AdSize.largeBanner,
            request: const AdRequest(),
            listener: adState.listener)
          ..load();
      });
    });
  }

  // String text = widget.statement;

  List<RadioModel> sampleData = <RadioModel>[];

  List<String> alphabets = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  @override
  void initState() {
    super.initState();

    int n = widget.options.length;

    for (var i = 0; i < n; i++) {
      sampleData
          .add(RadioModel(false, alphabets[i], widget.options[i][0], false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (!widget.isRated) await showRatingsPage(context, widget.quesUUid);
          return widget.isRated;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "All Questions",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.deepPurple,
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
          ),
          body: Column(children: [
            Expanded(
                child: ListView.builder(
              itemCount: sampleData.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Column(children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 20, right: 15, bottom: 5),
                        child: KaTeX(
                          laTeXCode: Text(widget.statement,
                              style: const TextStyle(
                                fontSize: 18,
                              )),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: Row(children: [
                        Row(
                          children: [
                            const Text(
                              "Quality : ",
                              // style: TextStyle(fontSize: 12),
                            ),
                            for (var i = 0; i < 5; i++)
                              Icon(
                                Icons.star,
                                color: (widget.qualityRating > i)
                                    ? Colors.amber
                                    : Colors.white,
                              )
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Difficulty : "),
                            for (var i = 0; i < 5; i++)
                              Icon(
                                Icons.star,
                                color: (widget.difficultyRating > i)
                                    ? Colors.amber
                                    : Colors.white,
                              )
                          ],
                        ),
                      ]),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(children: [
                          const Text("Bookmark Question"),
                          IconButton(
                              onPressed: () async {
                                String url = await rootBundle
                                    .loadString('assets/text/url.txt');
                                final prefs =
                                    await SharedPreferences.getInstance();
                                String? token = prefs.getString("token");
                                await http.get(
                                  Uri.parse(
                                      '$url/bookmark_ques?uuid=${widget.quesUUid}'),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                    'Authorization': "Token $token"
                                  },
                                );

                                setState(() {
                                  isBookmarked = true;
                                });
                              },
                              icon: Icon(
                                Icons.star,
                                color: (isBookmarked
                                    ? Colors.amber
                                    : Colors.white),
                              ))
                        ])),
                    InkWell(
                      highlightColor: Colors.red,
                      splashColor: Colors.blueAccent,
                      onTap: () {
                        setState(() {
                          sampleData[index].isSelected = true;
                        });
                      },
                      child: RadioItem(sampleData[index], isAnswered),
                    )
                  ]);
                } else if (index == sampleData.length - 1) {
                  return Column(
                    children: [
                      InkWell(
                        highlightColor: Colors.red,
                        splashColor: Colors.blueAccent,
                        onTap: () {
                          setState(() {
                            sampleData[index].isSelected = true;
                          });
                        },
                        child: RadioItem(sampleData[index], isAnswered),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isAnswered = true;
                              for (var i = 0; i < widget.options.length; i++) {
                                sampleData[i].isCorrect = widget.options[i][1];
                              }
                            });
                          },
                          child: const Text("Check Answer"))
                    ],
                  );
                }
                return InkWell(
                  highlightColor: Colors.red,
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      sampleData[index].isSelected = true;
                    });
                  },
                  child: RadioItem(sampleData[index], isAnswered),
                );
              },
            )),
            if (banner == null)
              const Text("Loading Ad")
            else
              SizedBox(height: 100, child: AdWidget(ad: banner!))
          ]),
        ));
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  final bool isAnswered;
  // ignore: use_key_in_widget_constructors
  const RadioItem(this._item, this.isAnswered);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Row(
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            child: Center(
              child: Text(_item.buttonText,
                  style: TextStyle(
                      color: _item.isSelected || _item.isCorrect
                          ? Colors.white
                          : Colors.black,
                      fontSize: 18.0)),
            ),
            decoration: BoxDecoration(
              color: (() {
                if (_item.isCorrect) {
                  return Colors.lightGreenAccent;
                } else if (_item.isSelected && isAnswered) {
                  return Colors.red;
                } else if (_item.isSelected) {
                  return Colors.lightBlueAccent;
                } else {
                  return Colors.transparent;
                }
              }()),
              border: Border.all(
                width: 1.0,
                color: (() {
                  if (_item.isCorrect) {
                    return Colors.lightBlueAccent;
                  } else if (_item.isSelected && isAnswered) {
                    return Colors.red;
                  } else if (_item.isSelected) {
                    return Colors.lightBlueAccent;
                  } else {
                    return Colors.black;
                  }
                }()),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(2.0)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
              child: KaTeX(
            laTeXCode: Text(_item.text,
                style: TextStyle(
                  fontSize: 17,
                  color: (() {
                    if (!_item.isCorrect && _item.isSelected) {
                      return Colors.red;
                    } else if (_item.isCorrect) {
                      return Colors.lightBlueAccent;
                    } else {
                      return Colors.black;
                    }
                  }()),
                )),
          ))
        ],
      ),
    );
  }
}
