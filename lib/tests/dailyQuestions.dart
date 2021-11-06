import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/ad_state.dart';

import 'package:http/http.dart' as http;

import 'quizTemplate.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';





List<dynamic> allOptions = <dynamic>[];
List<dynamic> questionStatements = <dynamic>[];
int limit = 0;


Future<List<dynamic>> getDailyQuestions(String type) async {
  final tokenRes = await http.get(
    Uri.parse('http://192.168.1.11:8000/getToken'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  String token = jsonDecode(tokenRes.body);



  final response = await http.get(
    Uri.parse('http://192.168.1.11:8000/getQues?exam=ias'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token $token"
    },
  );



  for (var id in jsonDecode(response.body)) {
    final ques = await http.get(
      Uri.parse('http://192.168.1.11:8000/getQuesByID?quesID=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    print(jsonDecode(ques.body));

    questionStatements.add(jsonDecode(ques.body)['statement']);
    allOptions.add(jsonDecode(ques.body)['options']);
  }

  limit = questionStatements.length;

  if (type == 'dailyQuestions') return questionStatements;
  if (type == 'allOptions') return allOptions;

  

  print(jsonDecode(response.body).runtimeType);

  List<dynamic> json = jsonDecode(response.body);

  return json;
}



class DailyQuestions extends StatefulWidget {
  const DailyQuestions({Key? key}) : super(key: key);

  @override
  _DailyQuestionsState createState() => _DailyQuestionsState();
}

class _DailyQuestionsState extends State<DailyQuestions> {
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


  List<String> questions = <String>['a', 'b', 'c', 'd'];


  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> _dailyQuestions = getDailyQuestions("dailyQuestions");
    int limit = questionStatements.length;



    return FutureBuilder<List<dynamic>> (
        future: _dailyQuestions,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapShot) {
          if (snapShot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Daily Questions", style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.purple,
                  toolbarHeight: 100,
                ),
                body: Scaffold(
                    body: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var i=0; i < limit; i++) Padding(
                                padding: EdgeInsets.only(left: 20, top: 100, bottom: 100),
                                child: ElevatedButton(
                                  child: Text(questionStatements[i]),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CustomRadio(options: allOptions[i], statement: questionStatements[i],)),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(250, 20),
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
                                      alignment: Alignment.center
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        if (banner == null) Text("yo")
                        else Container(
                          height: 50,
                          child: AdWidget(ad: banner!)
                        )
                      ],
                    )
                )
            );
          }
          else {
            return Text("Problems");
          }
        }
    );
  }
}















