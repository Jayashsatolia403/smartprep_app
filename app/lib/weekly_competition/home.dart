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
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:uuid/uuid.dart';

class WeeklyCompetitionHome extends StatefulWidget {
  const WeeklyCompetitionHome({Key? key}) : super(key: key);

  @override
  _WeeklyCompetitionHomeState createState() => _WeeklyCompetitionHomeState();
}

class _WeeklyCompetitionHomeState extends State<WeeklyCompetitionHome> {
  BannerAd? banner;
  List<Question> questions = [];
  int currentPage = 1;
  bool done = false;
  late Future<bool> myFuture;
  int totalPages = 10;

  Future<bool> getQuesFromDatabase() async {
    try {
      print("Started Fetching from Database...");
      DateTime now = DateTime.now();
      final dbDate = await QuizDatabase.instance.readAllDate();
      if (dbDate[0].date == DateTime(now.year, now.month, now.day)) {
        print(currentPage);
        for (var j = (currentPage - 1) * 10 + 1;
            j < (currentPage) * 10 + 1;
            j++) {
          print(j);
          final i = await QuizDatabase.instance.readQuestionsById(j);

          Question configQuestion =
              Question(statement: i.statement, options: []);

          final getDbQuestionOptions = await QuizDatabase.instance
              .readQuestionOptionsFromQuestionId(i.uuid);

          for (var j in getDbQuestionOptions) {
            final getDbOption =
                await QuizDatabase.instance.readOptions(j.optionId);

            configQuestion.options.add(getDbOption.uuid);
          }
          setState(() {
            questions.add(configQuestion);
          });
          print("Working!");
        }

        currentPage++;

        print(
            "Fetched Questions from Database! Range = ${(currentPage - 2) * 10} : ${(currentPage - 1) * 10}");
      } else {
        return false;
      }

      return true;
    } catch (error) {
      print("ERROR!");
      print(error);
      return false;
    }
  }

  Future<bool> getQuestions(bool isRefresh) async {
    if (isRefresh) {
      currentPage = 1;
      questions = [];
    } else if (currentPage >= totalPages) {
      _refreshController.loadNoData();
      return false;
    }

    final dbDate = await QuizDatabase.instance.readAllDate();
    if (dbDate.isNotEmpty && dbDate[0].pages >= currentPage) {
      print("Trying to Fetch Data from Database...");
      final res = await getQuesFromDatabase();
      if (res) {
        return true;
      }
    }

    String url = await rootBundle.loadString('assets/text/url.txt');

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? examName = prefs.getString("exam_name");

    final response = await http.get(
      Uri.parse(
          '$url/get_todays_contest?exam=$examName&page=$currentPage&page_size=10'),
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
        Options dbOption =
            Options(uuid: optn[2], content: optn[0], isSelected: false);
        await QuizDatabase.instance.createOption(dbOption);

        // Adding Options to Question of quiz_config
        question.options.add(optn[2]);

        // Adding QuestionOptions to Database
        QuestionOptions dbQuestionOptions = QuestionOptions(
            uuid: const Uuid().v4(),
            questionId: jsonResponse['uuid'],
            optionId: optn[2]);

        await QuizDatabase.instance.createQuestionOptions(dbQuestionOptions);
      }

      setState(() {
        questions.add(question);
      });
    }

    currentPage++;

    final date = await QuizDatabase.instance.readAllDate();

    if (date.isNotEmpty) {
      date[0].pages = date[0].pages + 1;
      await QuizDatabase.instance.updateDate(date[0]);
    } else {
      final now = DateTime.now();
      await QuizDatabase.instance.createDate(Date(
          date: DateTime(now.year, now.month, now.day), pages: currentPage));
    }

    return true;
  }

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
  void initState() {
    myFuture = getQuestions(false);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot<bool> snapShot) {
          if (snapShot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Weekly Competitions",
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.purple,
                  toolbarHeight: 100,
                ),
                body: Scaffold(
                    body: Column(
                  children: [
                    Expanded(
                        child: SmartRefresher(
                      controller: _refreshController,
                      enablePullUp: true,
                      onRefresh: () async {
                        final result = await getQuestions(true);
                        if (result) {
                          _refreshController.refreshCompleted();
                        } else {
                          _refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result = await getQuestions(false);
                        if (result) {
                          _refreshController.loadComplete();
                        } else {
                          _refreshController.loadFailed();
                        }
                      },
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var i = 0; i < questions.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 50, bottom: 20),
                              child: ElevatedButton(
                                child: Text(
                                    'Q.${i + 1}  ${questions[i].statement}',
                                    style:
                                        const TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomRadio(
                                              question: questions[i],
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
                    )),
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





















































// addToDatabase() async {
//   String url = await rootBundle.loadString('assets/text/url.txt');

//   final prefs = await SharedPreferences.getInstance();
//   String? token = prefs.getString("token");
//   String? examName = prefs.getString("exam_name");

//   final response = await http.get(
//     Uri.parse('$url/get_todays_contest?exam=$examName&page=1,page_size=1000'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': "Token $token"
//     },
//   );

//   for (var uuid in jsonDecode(response.body)) {
//     final ques = await http.get(
//       Uri.parse('$url/getQuesByID?quesID=$uuid'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': "Token $token"
//       },
//     );

//     final jsonResponse = jsonDecode(ques.body);

//     // Adding Question to Database
//     Questions dbQuestion =
//         Questions(uuid: uuid, statement: jsonResponse['statement']);

//     await QuizDatabase.instance.createQuestion(dbQuestion);

//     for (var optn in jsonResponse['options']) {
//       // Adding Option to Database
//       Options dbOption =
//           Options(uuid: optn[2], content: optn[0], isSelected: false);
//       await QuizDatabase.instance.createOption(dbOption);

//       // Adding QuestionOptions to Database
//       QuestionOptions dbQuestionOptions = QuestionOptions(
//           uuid: const Uuid().v4(),
//           questionId: jsonResponse['uuid'],
//           optionId: optn[2]);

//       await QuizDatabase.instance.createQuestionOptions(dbQuestionOptions);
//     }
//   }

//   Date date = Date(date: DateTime.now());

//   await QuizDatabase.instance.createDate(date);
// }

// Future<List<Question>> getCompetitionQuestions(int page) async {
//   List<Question> weeklyQuiz = [];

//   final dbDate = await QuizDatabase.instance.readAllDate();
//   if (dbDate.isNotEmpty) {
//     return await getQuesFromDatabase(page);
//   }

//   String url = await rootBundle.loadString('assets/text/url.txt');

//   final prefs = await SharedPreferences.getInstance();
//   String? token = prefs.getString("token");
//   String? examName = prefs.getString("exam_name");

//   final response = await http.get(
//     Uri.parse('$url/get_todays_contest?exam=$examName'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': "Token $token"
//     },
//   );

//   for (var uuid in jsonDecode(response.body)) {
//     final ques = await http.get(
//       Uri.parse('$url/getQuesByID?quesID=$uuid'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': "Token $token"
//       },
//     );

//     final jsonResponse = jsonDecode(ques.body);

//     // Adding Question to quiz_config
//     Question question =
//         Question(statement: jsonResponse['statement'], options: []);

//     // Adding Question to Database
//     Questions dbQuestion =
//         Questions(uuid: uuid, statement: jsonResponse['statement']);

//     await QuizDatabase.instance.createQuestion(dbQuestion);

//     for (var optn in jsonResponse['options']) {
//       // Adding Option to Database
//       Options dbOption =
//           Options(uuid: optn[2], content: optn[0], isSelected: false);
//       await QuizDatabase.instance.createOption(dbOption);

//       // Adding Options to Question of quiz_config
//       question.options.add([optn[0], false, optn[2]]);

//       // Adding QuestionOptions to Database
//       QuestionOptions dbQuestionOptions = QuestionOptions(
//           uuid: const Uuid().v4(),
//           questionId: jsonResponse['uuid'],
//           optionId: optn[2]);

//       await QuizDatabase.instance.createQuestionOptions(dbQuestionOptions);
//     }

//     weeklyQuiz.add(question);
//   }

// final date = await QuizDatabase.instance.readAllDate();

// if (date.isNotEmpty) {
//   date[0].pages = date[0].pages + 1;
//   await QuizDatabase.instance.updateDate(date[0]);
// } else {
//   final now = DateTime.now();
//   await QuizDatabase.instance.createDate(
//       Date(date: DateTime(now.year, now.month, now.day), pages: 1));
// }

//   return weeklyQuiz;
// }