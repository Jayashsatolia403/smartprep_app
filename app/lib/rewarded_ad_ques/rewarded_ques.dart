import 'dart:convert';

import 'package:app/tests/quiz_template.dart';
import 'package:flutter/material.dart';
import 'package:app/ad_state.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/services.dart' show rootBundle;

class RewardedQuestions extends StatefulWidget {
  const RewardedQuestions({Key? key}) : super(key: key);

  @override
  _RewardedQuestionsState createState() => _RewardedQuestionsState();
}

class _RewardedQuestionsState extends State<RewardedQuestions> {
  String exam = "";
  Future<List<dynamic>> getRewardedQuestions() async {
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
      Uri.parse('$url/get_questions_by_ad?exam=$examName'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    final resJson = jsonDecode(utf8.decode(response.bodyBytes));

    for (var id in resJson) {
      late String statement;
      late String createdBy;
      late String explaination;

      try {
        statement = (id['statement'] as String).replaceAll("\\n", "\n");
        createdBy = (id['createdBy'] as String).replaceAll("\\n", "\n");
        explaination = (id['explaination'] as String).replaceAll("\\n", "\n");
      } catch (error) {
        statement = id['statement'];
        createdBy = id['createdBy'];
        explaination = id['explaination'];
      }

      questionStatements.add([
        statement,
        id['uuid'],
        id['ratings'],
        id['difficulty'],
        id['isRated'],
        createdBy,
        explaination
      ]);

      allOptions.add(id['options']);
    }

    result.add(questionStatements);
    result.add(allOptions);

    return result;
  }

  // ignore: non_constant_identifier_names
  late Future<List<dynamic>> _RewardedQuestions;

  @override
  void initState() {
    super.initState();
    _RewardedQuestions = getRewardedQuestions();
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
        future: _RewardedQuestions,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapShot) {
          if (snapShot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Rewarded Questions",
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.purple,
                  toolbarHeight: 80,
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
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 17)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomRadio(
                                              options: snapShot.data![1][i],
                                              statement: snapShot.data![0][i]
                                                  [0],
                                              quesUUid: snapShot.data![0][i][1],
                                              qualityRating: snapShot.data![0]
                                                  [i][2],
                                              difficultyRating:
                                                  snapShot.data![0][i][3],
                                              isRated: snapShot.data![0][i][4],
                                              createdBy: snapShot.data![0][i]
                                                  [5],
                                              explaination: snapShot.data![0][i]
                                                  [6],
                                            )),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(250, 20),
                                    primary: Colors.deepPurpleAccent,
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
