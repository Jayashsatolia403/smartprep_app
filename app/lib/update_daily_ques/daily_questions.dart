import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app/ad_state.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'quiz_template.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'models.dart';
import 'daily_ques_db.dart';

class DailyQuestions extends StatefulWidget {
  const DailyQuestions({Key? key}) : super(key: key);

  @override
  _DailyQuestionsState createState() => _DailyQuestionsState();
}

class _DailyQuestionsState extends State<DailyQuestions> {
  String exam = "";

  List<dynamic> questionStatements = <dynamic>[];

  bool loadingDone = false;

  Future<bool?> showPleaseWaitDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => const AlertDialog(title: Text("Please Wait...")));
  }

  Future<bool> getDailyQuestionsFromDatabase() async {
    final extraDetails = await DailyQuesDatabase.instance.readAllExtraDetails();

    if (extraDetails[0].date ==
        DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      final dbQuestions = await DailyQuesDatabase.instance.readAllQuestions();

      for (var i in dbQuestions) {
        setState(() {
          questionStatements.add([i.statement, i.uuid]);
        });
      }

      setState(() {
        loadingDone = true;
      });
    }

    return true;
  }

  Future<bool> getDailyQuestions() async {
    String url = await rootBundle.loadString('assets/text/url.txt');

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? examName = prefs.getString("exam_name");

    final allExamDetails =
        await DailyQuesDatabase.instance.readAllExtraDetails();

    if (allExamDetails.isNotEmpty) {
      final examDetails = allExamDetails[0];

      if (examDetails.date == DateFormat('yyyy-MM-dd').format(DateTime.now()) &&
          examDetails.exam == examName) {
        await getDailyQuestionsFromDatabase();

        return true;
      } else {
        await DailyQuesDatabase.instance.deleteEverything();
        await DailyQuesDatabase.instance.readAllExtraDetails();
      }
    }

    String firstQuesUuid = "";
    bool hasSetFirstQuesUuid = false;

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
      late String explaination;

      try {
        statement = (id['statement'] as String).replaceAll("\\n", "\n");
        explaination = (id['explaination'] as String).replaceAll("\\n", "\n");
      } catch (error) {
        statement = id['statement'];
        explaination = id['explaination'];
      }

      setState(() {
        questionStatements.add([
          statement,
          id['uuid'],
        ]);
      });

      if (!hasSetFirstQuesUuid) {
        firstQuesUuid = id['uuid'];
        hasSetFirstQuesUuid = true;
      }

      print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
      print(explaination);
      print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");

      Questions question = Questions(
          uuid: id['uuid'],
          statement: statement,
          isRated: id['isRated'],
          isBookmarked: false,
          explaination: explaination,
          difficultyRatings: id['ratings'].toString(),
          qualityRatings: id['difficulty'].toString());

      await DailyQuesDatabase.instance.createQuestion(question);

      for (var optn in id['options']) {
        Options option =
            Options(uuid: optn[2], content: optn[0], isCorrect: optn[1]);

        await DailyQuesDatabase.instance.createOption(option);

        QuestionOptions qOption =
            QuestionOptions(questionId: id['uuid'], optionId: optn[2]);

        await DailyQuesDatabase.instance.createQuestionOptions(qOption);
      }
    }

    Questions dbQuestion =
        await DailyQuesDatabase.instance.readQuestionsByUUid(firstQuesUuid);

    ExtraDetails extraDetails = ExtraDetails(
        date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        noOfQuestions: questionStatements.length,
        firstIdx: dbQuestion.id ?? 1,
        exam: examName ?? "Exam");

    await DailyQuesDatabase.instance.createExtraDetails(extraDetails);

    setState(() {
      loadingDone = true;
    });

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
    return WillPopScope(
        onWillPop: () async {
          if (!loadingDone) showPleaseWaitDialog(context);
          return loadingDone;
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Daily Questions",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.purple,
              toolbarHeight: 60,
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
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomRadio(
                                            statement: questionStatements[i][0],
                                            quesUUid: questionStatements[i][1],
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
                if (questionStatements.isEmpty)
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                if (banner == null)
                  const Text("Loading Ad")
                else
                  SizedBox(height: 150, child: AdWidget(ad: banner!))
              ],
            ))));
  }
}
