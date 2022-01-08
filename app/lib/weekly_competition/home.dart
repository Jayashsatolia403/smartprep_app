import 'package:app/weekly_competition/quiz_models.dart';
import 'package:app/weekly_competition/quiz_template.dart';
import 'package:app/weekly_competition/result.dart';
import 'package:app/weekly_competition/view_answered_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../ad_state.dart';
import 'quiz_config.dart';
import 'dart:convert';
import 'quiz_db.dart';

import 'package:uuid/uuid.dart';

class WeeklyCompetitionHome extends StatefulWidget {
  const WeeklyCompetitionHome({Key? key}) : super(key: key);

  @override
  _WeeklyCompetitionHomeState createState() => _WeeklyCompetitionHomeState();
}

class _WeeklyCompetitionHomeState extends State<WeeklyCompetitionHome> {
  BannerAd? banner;
  List<Question> questions = [];
  bool done = false;
  String competitionUuid = "";
  bool na = false;
  String exam = "";
  int firstIdx = 0;
  bool changedFirstIndex = false;
  bool loadingDone = false;

  late RewardedAd rewardedAd;

  Future<bool?> showRatingsPage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                  "Competition Questions are Downloading. Please wait or else you have to redownload them next time you open up This Competition."),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      await QuizDatabase.instance.deleteEverything();
                      setState(() {
                        loadingDone = true;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Exit")),
                ElevatedButton(onPressed: () {}, child: const Text("Stay"))
              ],
            ));
  }

  void loadVideoAd() async {
    RewardedAd.load(
        adUnitId: "ca-app-pub-3347710342715984/3851662288",
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          loadVideoAd();
        }));
  }

  void showVideoAd() {
    rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem rpoint) {
      print("Reward Earned ${rpoint.amount}");
    });

    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdFailedToShowFullScreenContent: (ad, error) => print(error),
      onAdShowedFullScreenContent: (ad) => print("Working"),
    );
  }

  Map<String, int> totalQuestions = {
    "ias": 100,
    "iasHindi": 100,
    "neet": 180,
    "ras": 150,
    "rasHindi": 150,
    "ibpsPO": 100,
    "ibpsClerk": 100,
    "sscCGL": 100,
    "sscCGLHindi": 100,
    "sscCHSL": 100,
    "nda": 150,
    "cat": 90,
    "ntpc": 100,
    "reet1": 150,
    "reet2": 150,
    "reet2Science": 150,
    "patwari": 150,
    "grade2nd": 100,
    "grade2ndScience": 150,
    "grade2ndSS": 150,
    "sscGD": 100,
    "sscMTS": 100,
    "rajPoliceConst": 150,
    "rajLDC": 150,
    "rrbGD": 150,
    "sipaper1": 100,
    "sipaper2": 100
  };

  Future<bool> getQuesFromDatabase() async {
    DateTime now = DateTime.now();
    final dbDate = await QuizDatabase.instance.readAllDate();
    if (dbDate[0].date == DateTime(now.year, now.month, now.day)) {
      setState(() {
        competitionUuid = dbDate[0].competitionUuid;
      });

      final dbQuestions = await QuizDatabase.instance.readAllQuestions();

      bool changedFirstIdx = false;

      for (var i in dbQuestions) {
        Question configQuestion =
            Question(statement: i.statement, options: [], uuid: i.uuid);

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

        if (!changedFirstIdx) {
          setState(() {
            firstIdx = i.id!;
            changedFirstIdx = true;
          });
        }
      }

      setState(() {
        loadingDone = true;
      });
    } else {
      return false;
    }

    return true;
  }

  Future<bool> getQuestions() async {
    String url = await rootBundle.loadString('assets/text/url.txt');

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String examName = prefs.getString("exam_name") ?? "Exam";

    setState(() {
      exam = examName;
    });

    final dbDate = await QuizDatabase.instance.readAllDate();

    final now = DateTime.now();

    if (dbDate.isNotEmpty &&
        (dbDate[0].date != DateTime(now.year, now.month, now.day) ||
            dbDate[0].examName != examName)) {
      await QuizDatabase.instance.deleteEverything();
    } else if (dbDate.isNotEmpty && dbDate[0].examName == examName) {
      final res = await getQuesFromDatabase();
      if (res) {
        return true;
      }
    }

    final response = await http.get(
      Uri.parse('$url/get_todays_contest?exam=$examName'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    final resJson = jsonDecode(utf8.decode(response.bodyBytes));

    if (response.statusCode == 404) {
      setState(() {
        na = true;
      });

      return false;
    }

    setState(() {
      competitionUuid = resJson['uuid'];
    });

    for (var ques in resJson['questions']) {
      // Adding Question to quiz_config
      Question question = Question(
          statement: (ques['statement'] as String).replaceAll("\\n", "\n"),
          options: [],
          uuid: ques['uuid']);

      // Adding Question to Database
      Questions dbQuestion = Questions(
          uuid: ques['uuid'],
          statement: (ques['statement'] as String).replaceAll("\\n", "\n"),
          isAnswered: false);

      await QuizDatabase.instance.createQuestion(dbQuestion);

      for (var optn in ques['options']) {
        // Adding Option to Database
        Options dbOption = Options(
            uuid: optn[1],
            content: (optn[0] as String).replaceAll("\\n", "\n"),
            isSelected: false);
        await QuizDatabase.instance.createOption(dbOption);

        // Adding Options to Question of quiz_config
        question.options.add(optn[1]);

        // Adding QuestionOptions to Database
        QuestionOptions dbQuestionOptions = QuestionOptions(
            uuid: const Uuid().v4(),
            questionId: ques['uuid'],
            optionId: optn[1]);

        await QuizDatabase.instance.createQuestionOptions(dbQuestionOptions);
      }

      final returnedId =
          await QuizDatabase.instance.readQuestionsByUUid(dbQuestion.uuid);

      setState(() {
        questions.add(question);
      });

      if (!changedFirstIndex) {
        setState(() {
          firstIdx = returnedId.id!;
          changedFirstIndex = true;
        });
      }
    }

    final date = await QuizDatabase.instance.readAllDate();

    if (date.isNotEmpty) {
      await QuizDatabase.instance.updateDate(date[0]);
    } else {
      final now = DateTime.now();
      await QuizDatabase.instance.createDate(Date(
          date: DateTime(now.year, now.month, now.day),
          competitionUuid: competitionUuid,
          examName: examName));

      setState(() {
        loadingDone = true;
      });
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
    super.initState();
    getQuestions();
    loadVideoAd();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (!loadingDone) await showRatingsPage(context);
          return loadingDone;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Row(children: [
                const Text("Competitions",
                    style: TextStyle(color: Colors.white)),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAnsweredQuestions(
                                exam: exam,
                                firstIdx: firstIdx,
                              )),
                    );
                  },
                  icon: const ImageIcon(
                    AssetImage("assets/images/menu.png"),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        showVideoAd();
                        showVideoAd();
                      } catch (error) {
                        print(error);
                      }
                      String url =
                          await rootBundle.loadString('assets/text/url.txt');

                      final prefs = await SharedPreferences.getInstance();
                      String? token = prefs.getString("token");

                      List<List<String>> submitOptions = [];
                      int count = 0;
                      final dbQuestions =
                          await QuizDatabase.instance.readAllQuestions();

                      for (var dbQuestion in dbQuestions) {
                        final getDbQuestionOptions = await QuizDatabase.instance
                            .readQuestionOptionsFromQuestionId(dbQuestion.uuid);

                        submitOptions.add([]);

                        for (var j in getDbQuestionOptions) {
                          final getDbOption = await QuizDatabase.instance
                              .readOptions(j.optionId);

                          if (getDbOption.isSelected) {
                            submitOptions[count].add(getDbOption.uuid);
                          }
                        }

                        count += 1;

                        print(count);
                      }

                      var data = {
                        "uuid": competitionUuid,
                        "options": submitOptions
                      };

                      final response = await http.post(
                          Uri.parse('$url/submit_contest/'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                            'Authorization': "Token $token"
                          },
                          body: jsonEncode(
                              {"data": jsonEncode(data).toString()}));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Result(
                                correctOptions:
                                    jsonDecode(response.body)["correct_options"]
                                        .toString())),
                      );
                    },
                    child: const Text("Submit"))
              ]),
              backgroundColor: Colors.purple,
              toolbarHeight: 100,
            ),
            body: Column(children: [
              if (questions.isNotEmpty)
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var i = 0; i < questions.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 50, bottom: 20),
                          child: ElevatedButton(
                            child: Text(
                                '                          Q.${i + 1}\n\n${questions[i].statement}',
                                style: const TextStyle(color: Colors.white)),
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
                ),
              if (questions.isEmpty)
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              if (banner == null)
                const Text("yo")
              else
                SizedBox(height: 150, child: AdWidget(ad: banner!))
            ])));
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

//   for (var uuid in jsonDecode(utf8.decode(response.bodyBytes))) {
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

//   for (var uuid in jsonDecode(utf8.decode(response.bodyBytes))) {
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