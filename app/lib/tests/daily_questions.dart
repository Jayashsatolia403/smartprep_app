import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/ad_state.dart';

import 'package:http/http.dart' as http;

import 'quiz_template.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/services.dart' show rootBundle;




List<dynamic> allOptions = <dynamic>[];
List<dynamic> questionStatements = <dynamic>[];
int limit = 0;


Future<List<dynamic>> getDailyQuestions(String type) async {
  String ip = await rootBundle.loadString('assets/text/ip.txt');

  final tokenRes = await http.get(
    Uri.parse('http://$ip:8000/getToken'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  String token = jsonDecode(tokenRes.body);

  final response = await http.get(
    Uri.parse('http://$ip:8000/getQues?exam=jeeAdv'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token $token"
    },
  );

  questionStatements = <dynamic>[];
  allOptions = <dynamic>[];

  for (var id in jsonDecode(response.body)) {
    final ques = await http.get(
      Uri.parse('http://$ip:8000/getQuesByID?quesID=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );


    questionStatements.add(jsonDecode(ques.body)['statement']);
    allOptions.add(jsonDecode(ques.body)['options']);
  }

  limit = questionStatements.length;

  // print(questionStatements);
  // print(allOptions);

  if (type == 'dailyQuestions') return questionStatements;
  if (type == 'allOptions') return allOptions;

  List<dynamic> json = jsonDecode(response.body);

  return json;
}



class DailyQuestions extends StatefulWidget {
  const DailyQuestions({Key? key, required this.exam}) : super(key: key);

  final String exam;

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
            size: const AdSize(height: 150, width: 360),
            request: const AdRequest(),
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
                  title: const Text("Daily Questions", style: TextStyle(color: Colors.white)),
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
                                padding: const EdgeInsets.only(left: 20, top: 50, bottom: 20),
                                child: ElevatedButton(
                                  child: Text(questionStatements[i]),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CustomRadio(options: allOptions[i], statement: questionStatements[i],)),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(250, 20),
                                      primary: Colors.grey,
                                      onPrimary: Colors.black,
                                      alignment: Alignment.center
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        if (banner == null) const Text("yo")
                        else SizedBox(
                            height: 150,
                            child: AdWidget(ad: banner!)
                        )
                      ],
                    )
                )
            );
          }
          else {
            return const Text("Problems");
          }
        }
    );
  }
}