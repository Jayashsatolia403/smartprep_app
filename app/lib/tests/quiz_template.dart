import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

class CustomRadio extends StatefulWidget {
  CustomRadio(
      {Key? key,
      required this.options,
      required this.statement,
      required this.quesUUid,
      required this.qualityRating,
      required this.difficultyRating,
      required this.isRated,
      required this.createdBy,
      required this.explaination})
      : super(key: key);

  final List<dynamic> options;
  // ignore: prefer_typing_uninitialized_variables
  var statement;
  String quesUUid;
  double qualityRating;
  double difficultyRating;
  bool isRated;
  String createdBy;
  String explaination;

  @override
  createState() {
    return CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  bool isBookmarked = false;
  bool isReported = false;
  bool showExplaination = false;
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
                            MaterialStateProperty.all<Color>(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () async {
                      setState(() {
                        widget.isRated = true;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shadowColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
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
                      setState(() {
                        qualityRating = rating;
                      });
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
                      setState(() {
                        difficultyRating = rating;
                      });
                    },
                  )
                ],
              ),
            ));
  }

  Future<bool?> showSolution() async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(widget.explaination)));
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
                      child: Text(
                        widget.statement,
                        style: const TextStyle(fontSize: 19),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showSolution();
                      },
                      icon: const ImageIcon(
                        AssetImage("assets/images/sln_bulb.png"),
                        color: Colors.blue,
                      ),
                      iconSize: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(children: [
                          Row(children: [
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
                                      : Colors.red),
                                ))
                          ]),
                          Row(children: [
                            const Text("Report Question"),
                            IconButton(
                                onPressed: () async {
                                  String url = await rootBundle
                                      .loadString('assets/text/url.txt');
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  String? token = prefs.getString("token");
                                  await http.get(
                                    Uri.parse(
                                        '$url/report_question?uuid=${widget.quesUUid}'),
                                    headers: <String, String>{
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                      'Authorization': "Token $token"
                                    },
                                  );

                                  setState(() {
                                    isReported = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  color:
                                      (isReported ? Colors.amber : Colors.red),
                                ))
                          ])
                        ])),
                    InkWell(
                      highlightColor: Colors.red,
                      splashColor: Colors.blueAccent,
                      onTap: () {
                        setState(() {
                          for (var element in sampleData) {
                            element.isSelected = false;
                          }
                          sampleData[index].isSelected = true;

                          for (var i = 0; i < widget.options.length; i++) {
                            sampleData[i].isCorrect = widget.options[i][1];
                          }

                          showExplaination = true;
                        });
                      },
                      child: RadioItem(sampleData[index]),
                    ),
                  ]);
                }
                return InkWell(
                  highlightColor: Colors.red,
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      for (var element in sampleData) {
                        element.isSelected = false;
                      }
                      sampleData[index].isSelected = true;

                      for (var i = 0; i < widget.options.length; i++) {
                        sampleData[i].isCorrect = widget.options[i][1];
                      }

                      showExplaination = true;
                    });
                  },
                  child: RadioItem(sampleData[index]),
                );
              },
            )),
            if (banner == null)
              const Text("Loading Ad...")
            else
              SizedBox(height: 100, child: AdWidget(ad: banner!))
          ]),
        ));
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  // ignore: use_key_in_widget_constructors
  const RadioItem(this._item);
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
                  return Colors.green;
                } else if (_item.isSelected) {
                  return Colors.red;
                } else {
                  return Colors.transparent;
                }
              }()),
              border: Border.all(
                width: 1.0,
                color: (() {
                  if (_item.isCorrect) {
                    return Colors.green;
                  } else if (_item.isSelected) {
                    return Colors.red;
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
              child: Text(_item.text, style: const TextStyle(fontSize: 15)))
        ],
      ),
    );
  }
}
