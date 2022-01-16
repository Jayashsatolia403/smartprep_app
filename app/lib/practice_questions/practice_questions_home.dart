import 'dart:convert';

import 'package:app/tests/quiz_template.dart';
import 'package:flutter/material.dart';
import 'package:app/ad_state.dart';

import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/services.dart' show rootBundle;

class PracticeQuestions extends StatefulWidget {
  const PracticeQuestions({Key? key}) : super(key: key);

  @override
  _PracticeQuestionsState createState() => _PracticeQuestionsState();
}

class _PracticeQuestionsState extends State<PracticeQuestions> {
  int currentPage = 1;
  // ignore: prefer_final_fields
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List<dynamic> allOptions = <dynamic>[];
  List<dynamic> questionStatements = <dynamic>[];

  Future<bool> getPracticeQuestions() async {
    String url = await rootBundle.loadString('assets/text/url.txt');

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? examName = prefs.getString("exam_name");

    final response = await http.get(
      Uri.parse('$url/get_practice_questions?exam=$examName&page=$currentPage'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    final resJson = jsonDecode(utf8.decode(response.bodyBytes));

    for (var id in resJson) {
      final String statement =
          (id['statement'] as String).replaceAll("\\n", "\n");
      final String createdBy =
          (id['createdBy'] as String).replaceAll("\\n", "\n");
      final String explaination =
          (id['explaination'] as String).replaceAll("\\n", "\n");

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

    setState(() {
      currentPage++;
    });

    return false;
  }

  @override
  void initState() {
    super.initState();
    getPracticeQuestions();
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
          title: const Text("Practice Questions",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.purple,
          toolbarHeight: 80,
        ),
        body: Scaffold(
            body: Column(
          children: [
            if (questionStatements.isNotEmpty)
              Expanded(
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullUp: true,
                  onLoading: () async {
                    final result = await getPracticeQuestions();
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
                              left: 20, top: 30, bottom: 20),
                          child: ElevatedButton(
                            child: Text(questionStatements[i][0],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomRadio(
                                          options: allOptions[i],
                                          statement: questionStatements[i][0],
                                          quesUUid: questionStatements[i][1],
                                          qualityRating: questionStatements[i]
                                              [2],
                                          difficultyRating:
                                              questionStatements[i][3],
                                          isRated: questionStatements[i][4],
                                          createdBy: questionStatements[i][5],
                                          explaination: questionStatements[i]
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
        )));
  }
}
