import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app/ad_state.dart';

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
      required this.explaination})
      : super(key: key);

  final List<dynamic> options;
  // ignore: prefer_typing_uninitialized_variables
  var statement;
  String quesUUid;
  double qualityRating;
  double difficultyRating;
  String explaination;

  @override
  createState() {
    return CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  bool showExplaination = false;
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
    return Scaffold(
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
                    child: Text(widget.statement)),
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
        if (showExplaination)
          Padding(
              padding: const EdgeInsets.all(8),
              child: Text(widget.explaination)),
        if (banner == null)
          const Text("Loading Ad...")
        else
          SizedBox(height: 100, child: AdWidget(ad: banner!))
      ]),
    );
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
                  return Colors.lightBlueAccent;
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
                    return Colors.lightBlueAccent;
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
              child: Text(
            _item.text,
          ))
        ],
      ),
    );
  }
}
