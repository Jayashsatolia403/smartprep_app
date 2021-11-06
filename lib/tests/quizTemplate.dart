import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter/material.dart';
import 'package:frontend/ad_state.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'quizTemplate.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:frontend/ad_state.dart';




class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;
  bool isCorrect;

  RadioModel(this.isSelected, this.buttonText, this.text, this.isCorrect);
}


class CustomRadio extends StatefulWidget {

  CustomRadio({Key? key, required this.options, required this.statement}) : super(key: key);

  final List<dynamic> options;
  final String statement;



  @override
  createState() {
    return new CustomRadioState();
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
            size: AdSize.banner,
            request: AdRequest(),
            listener: adState.listener
        )..load();
      });
    });
  }


  String text = "Done : Performing hot reload Syncing files to device GIONEE S10 lite Reloaded 1 of 559 libraries in 2,000ms. Performing hot reload Syncing files to device GIONEE S10 lite Reloaded 1 of 559 libraries in 2,000ms. Performing hot reload Syncing files to device GIONEE S10 lite Reloaded 1 of 559 libraries in 2,000ms.";

  List<RadioModel> sampleData = <RadioModel>[];

  List<String> alphabets = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
  'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int n = widget.options.length;

    print(widget.options);

    for (var i=0; i < n; i++) {
      sampleData.add(new RadioModel(false, alphabets[i], widget.options[i][0], false));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.statement);
    return Scaffold(
      appBar: AppBar(
        title: Text("All Questions", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Column(
        children: [
          Expanded(
          child: ListView.builder(
            itemCount: sampleData.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(children: [
                  Padding(
                      padding : EdgeInsets.only(left:15, top: 20, right: 15, bottom: 30),
                      child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 18,
                          )
                      )
                  ),
                  InkWell(
                    highlightColor: Colors.red,
                    splashColor: Colors.blueAccent,
                    onTap: () {
                      setState(() {
                        sampleData.forEach((element) => element.isSelected = false);
                        sampleData[index].isSelected = true;
                      });
                    },
                    child: RadioItem(sampleData[index]),
                  )]
                );
              }
              return new InkWell(
                highlightColor: Colors.red,
                splashColor: Colors.blueAccent,
                onTap: () {
                  setState(() {
                    sampleData.forEach((element) => element.isSelected = false);
                    sampleData[index].isSelected = true;

                    for (var i=0; i < widget.options.length; i++) {
                      sampleData[i].isCorrect = widget.options[i][1];
                    }
                  });
                },
                child: RadioItem(sampleData[index]),
              );
            },
          )
        ),
          if (banner == null) Text("yo")
          else Container(
              height: 50,
              child: AdWidget(ad: banner!)
          )
        ]
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color:
                      _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Colors.blueAccent
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Colors.blueAccent
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          SizedBox(
              width: 20
          ),
          new Container(
            child: Expanded(
              child: Text(_item.text, style: TextStyle(
                fontSize: 17,
                backgroundColor: (() {
                  if (!_item.isCorrect && _item.isSelected) return Colors.red;
                  else if (_item.isCorrect) return Colors.lightBlueAccent;
                  else return Colors.white;
                }())
              )),
            ),

          )
        ],
      ),
    );
  }
}