import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/ad_state.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'jee_adv_quiz_template.dart';
import 'quiz_template.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/services.dart' show rootBundle;

class DailyQuestions extends StatefulWidget {
  const DailyQuestions({Key? key}) : super(key: key);

  @override
  _DailyQuestionsState createState() => _DailyQuestionsState();
}

class _DailyQuestionsState extends State<DailyQuestions> {
  String exam = "";
  Future<List<dynamic>> getDailyQuestions() async {
    String url = await rootBundle.loadString('assets/text/url.txt');
    List<dynamic> allOptions = <dynamic>[];
    List<dynamic> questionStatements = <dynamic>[];
    List<dynamic> result = <dynamic>[];

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? examName = prefs.getString("exam_name");

    setState(() {
      exam = examName ?? "Exam";
    });

    final response = await http.get(
      Uri.parse('$url/getQues?exam=$examName'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    final resJson = jsonDecode(response.body);

    print(resJson);

    for (var id in resJson) {
      questionStatements.add([
        id['statement'],
        id['uuid'],
        id['ratings'],
        id['difficulty'],
        id['isRated'],
        id['createdBy'],
        id['explaination']
      ]);
      allOptions.add(id['options']);
    }

    result.add(questionStatements);
    result.add(allOptions);

    return result;
  }

  late Future<List<dynamic>> _dailyQuestions;

  @override
  void initState() {
    _dailyQuestions = getDailyQuestions();
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
            size: const AdSize(height: 150, width: 360),
            request: const AdRequest(),
            listener: adState.listener)
          ..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _dailyQuestions,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapShot) {
          if (snapShot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Daily Questions",
                      style: TextStyle(color: Colors.white)),
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
                          for (var i = 0; i < snapShot.data![0].length; i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 50, bottom: 20),
                              child: ElevatedButton(
                                child: Text(snapShot.data![0][i][0],
                                    style:
                                        const TextStyle(color: Colors.white)),
                                onPressed: () {
                                  if (exam == "jeeAdv") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => JeeCustomRadio(
                                                options: snapShot.data![1][i],
                                                statement: snapShot.data![0][i]
                                                    [0],
                                                quesUUid: snapShot.data![0][i]
                                                    [1],
                                                qualityRating: snapShot.data![0]
                                                    [i][2],
                                                difficultyRating:
                                                    snapShot.data![0][i][3],
                                                isRated: snapShot.data![0][i]
                                                    [4],
                                                createdBy: snapShot.data![0][i]
                                                    [5],
                                                explaination: snapShot.data![0]
                                                    [i][6],
                                              )),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CustomRadio(
                                                options: snapShot.data![1][i],
                                                statement: snapShot.data![0][i]
                                                    [0],
                                                quesUUid: snapShot.data![0][i]
                                                    [1],
                                                qualityRating: snapShot.data![0]
                                                    [i][2],
                                                difficultyRating:
                                                    snapShot.data![0][i][3],
                                                isRated: snapShot.data![0][i]
                                                    [4],
                                                createdBy: snapShot.data![0][i]
                                                    [5],
                                                explaination: snapShot.data![0]
                                                    [i][6],
                                              )),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(250, 20),
                                    primary: Colors.black,
                                    onPrimary: Colors.black,
                                    alignment: Alignment.center),
                              ),
                            )
                        ],
                      ),
                    ),
                    if (banner == null)
                      const Text("Loading Ad")
                    else
                      SizedBox(height: 150, child: AdWidget(ad: banner!))
                  ],
                )));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
