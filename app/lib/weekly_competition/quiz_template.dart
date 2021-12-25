import 'package:app/weekly_competition/quiz_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:katex_flutter/katex_flutter.dart';

import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app/ad_state.dart';

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}

class CustomRadio extends StatefulWidget {
  CustomRadio({Key? key, required this.question}) : super(key: key);

  Question question;

  @override
  createState() {
    return CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
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

    int n = widget.question.options.length;

    for (var i = 0; i < n; i++) {
      sampleData
          .add(RadioModel(false, alphabets[i], widget.question.options[i][0]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        left: 15, top: 20, right: 15, bottom: 30),
                    child: KaTeX(
                      laTeXCode: Text(widget.question.statement,
                          style: const TextStyle(
                            fontSize: 18,
                          )),
                    )),
                InkWell(
                  highlightColor: Colors.red,
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      for (var element in sampleData) {
                        element.isSelected = false;
                      }
                      sampleData[index].isSelected = true;
                    });
                  },
                  child: RadioItem(sampleData[index]),
                )
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
                });
              },
              child: RadioItem(sampleData[index]),
            );
          },
        )),
        if (banner == null)
          const Text("yo")
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
                      color: _item.isSelected ? Colors.white : Colors.black,
                      fontSize: 18.0)),
            ),
            decoration: BoxDecoration(
              color: (() {
                if (_item.isSelected) {
                  return Colors.lightBlueAccent;
                } else {
                  return Colors.transparent;
                }
              }()),
              border: Border.all(
                width: 1.0,
                color: (() {
                  if (_item.isSelected) {
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
                    if (_item.isSelected) {
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
