import 'package:app/weekly_competition/quiz_models.dart';
import 'package:app/weekly_competition/quiz_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../ad_state.dart';
import 'quiz_config.dart';
import 'dart:convert';
import 'quiz_db.dart';
import 'quiz_config.dart';

import 'package:uuid/uuid.dart';

Future<WeeklyCompetitionQuiz> getCompetitionQuestions() async {
  String url = await rootBundle.loadString('assets/text/url.txt');

  WeeklyCompetitionQuiz weeklyCompetitionQuiz =
      WeeklyCompetitionQuiz(questions: [], selectedOptions: []);

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  String? examName = prefs.getString("exam_name");

  final response = await http.get(
    Uri.parse('$url/get_todays_contest?exam=$examName'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token $token"
    },
  );

  for (var uuid in jsonDecode(response.body)) {
    final ques = await http.get(
      Uri.parse('$url/getQuesByID?quesID=$uuid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    final jsonResponse = jsonDecode(ques.body);

    // Adding Question to quiz_config
    Question question =
        Question(statement: jsonResponse['statement'], options: []);

    // Adding Question to Database
    Questions dbQuestion =
        Questions(uuid: uuid, statement: jsonResponse['statement']);

    await QuizDatabase.instance.createQuestion(dbQuestion);

    for (var optn in jsonResponse['options']) {
      // Adding Option to Database
      Options dbOption = Options(uuid: optn[2], content: optn[0]);
      await QuizDatabase.instance.createOption(dbOption);

      // Adding Options to Question of quiz_config
      question.options.add([optn[0], optn[2]]);

      // Adding QuestionOptions to Database
      QuestionOptions dbQuestionOptions = QuestionOptions(
          uuid: const Uuid().v4(),
          questionId: jsonResponse['uuid'],
          optionId: optn[2]);

      await QuizDatabase.instance.createQuestionOptions(dbQuestionOptions);
    }

    weeklyCompetitionQuiz.questions.add(question);
  }

  Date date = Date(date: DateTime.now());

  await QuizDatabase.instance.createDate(date);

  return weeklyCompetitionQuiz;
}

class WeeklyCompetitionHome extends StatefulWidget {
  const WeeklyCompetitionHome({Key? key}) : super(key: key);

  @override
  _WeeklyCompetitionHomeState createState() => _WeeklyCompetitionHomeState();
}

class _WeeklyCompetitionHomeState extends State<WeeklyCompetitionHome> {
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
    Future<WeeklyCompetitionQuiz> _competitionQuestions =
        getCompetitionQuestions();

    return FutureBuilder<WeeklyCompetitionQuiz>(
        future: _competitionQuestions,
        builder: (BuildContext context,
            AsyncSnapshot<WeeklyCompetitionQuiz> snapShot) {
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
                          for (var i = 0;
                              i < snapShot.data!.questions.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 50, bottom: 20),
                              child: ElevatedButton(
                                child: Text(
                                    snapShot.data!.questions[i].statement,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomRadio(
                                              question:
                                                  snapShot.data!.questions[i],
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
                    if (banner == null)
                      const Text("yo")
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
