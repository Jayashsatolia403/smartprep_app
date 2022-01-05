import 'package:app/tests/jee_adv_quiz_template.dart';
import 'package:app/tests/quiz_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../ad_state.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PreviousCompetitionView extends StatefulWidget {
  const PreviousCompetitionView(
      {Key? key, required this.compUuid, required this.compName})
      : super(key: key);

  final String compUuid;
  final String compName;

  @override
  _PreviousCompetitionViewState createState() =>
      _PreviousCompetitionViewState();
}

class _PreviousCompetitionViewState extends State<PreviousCompetitionView> {
  BannerAd? banner;
  int currentPage = 1;
  List<dynamic> allOptions = <dynamic>[];
  List<dynamic> questionStatements = <dynamic>[];
  String exam = "";
  Map<String, int> totalPages = {
    "ias": 10,
    "iasHindi": 10,
    "jee": 6,
    "jeeMains": 9,
    "jeeAdv": 6,
    "neet": 18,
    "ras": 15,
    "rasHindi": 15,
    "ibpsPO": 10,
    "ibpsClerk": 10,
    "sscCGL": 10,
    "sscCGLHindi": 10,
    "sscCHSL": 10,
    "nda": 15,
    "cat": 9,
    "ntpc": 10,
    "reet1": 15,
    "reet2": 15,
    "reet2Science": 15,
    "patwari": 15,
    "grade2nd": 10,
    "grade2ndScience": 15,
    "grade2ndSS": 15,
    "sscGD": 10,
    "sscMTS": 10,
    "rajPoliceConst": 15,
    "rajLDC": 15,
    "rrbGD": 15,
    "sipaper1": 10,
    "sipaper2": 10
  };

  Future<bool> getQuestions(String competitionUuid) async {
    String url = await rootBundle.loadString('assets/text/url.txt');

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String examName = prefs.getString("exam_name") ?? "Exam";

    setState(() {
      exam = examName;
    });

    if (currentPage > (totalPages[examName] as int)) {
      _refreshController.loadNoData();
      return false;
    }

    final response = await http.get(
      Uri.parse(
          '$url/get_competition_by_uuid?uuid=$competitionUuid&page=$currentPage&page_size=10'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    final resJson = jsonDecode(utf8.decode(response.bodyBytes));

    for (var id in resJson['questions']) {
      setState(() {
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
      });
    }

    currentPage++;

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
    getQuestions(widget.compUuid);
  }

  // ignore: prefer_final_fields
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.compName, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.purple,
          toolbarHeight: 100,
        ),
        body: Column(
          children: [
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                onLoading: () async {
                  final result = await getQuestions(widget.compUuid);
                  if (result) {
                    _refreshController.loadComplete();
                  } else {
                    _refreshController.loadFailed();
                  }
                },
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
            ),
            if (banner == null)
              const Text("yo")
            else
              SizedBox(height: 150, child: AdWidget(ad: banner!))
          ],
        ));
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