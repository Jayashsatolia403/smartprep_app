import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/ad_state.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  List<dynamic> allOptions = <dynamic>[];
  List<dynamic> questionStatements = <dynamic>[];

  Future<bool> getDailyQuestions() async {
    String url = await rootBundle.loadString('assets/text/url.txt');

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

      setState(() {
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
      });
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    getDailyQuestions();
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
            if (questionStatements.isNotEmpty)
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var i = 0; i < questionStatements.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 50, bottom: 20),
                        child: ElevatedButton(
                          child: Text(questionStatements[i][0],
                              style: const TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomRadio(
                                        options: allOptions[i],
                                        statement: questionStatements[i][0],
                                        quesUUid: questionStatements[i][1],
                                        qualityRating: questionStatements[i][2],
                                        difficultyRating: questionStatements[i]
                                            [3],
                                        isRated: questionStatements[i][4],
                                        createdBy: questionStatements[i][5],
                                        explaination: questionStatements[i][6],
                                      )),
                            );
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
            if (questionStatements.isEmpty)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (banner == null)
              const Text("Loading Ad")
            else
              SizedBox(height: 150, child: AdWidget(ad: banner!))
          ],
        )));
  }
}
