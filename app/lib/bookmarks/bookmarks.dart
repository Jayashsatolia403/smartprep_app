import 'dart:convert';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'quiz_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../ad_state.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  int currentPage = 1;
  // ignore: prefer_final_fields
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  late Future<bool> myFuture;

  List<dynamic> allOptions = <dynamic>[];
  List<dynamic> questionStatements = <dynamic>[];
  bool loadingDone = false;

  String exam = "Exam";

  Future<bool> getBookmarks() async {
    String url = await rootBundle.loadString('assets/text/url.txt');

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String examName = prefs.getString("exam_name") ?? "Exam";

    setState(() {
      exam = examName;
    });

    final response = await http.get(
      Uri.parse('$url/get_bookmarked_questions?page=$currentPage&page_size=10'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    final resJson = jsonDecode(utf8.decode(response.bodyBytes));

    if (resJson == "Done") {
      setState(() {
        loadingDone = true;
      });
      _refreshController.loadNoData();
      return false;
    }

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
          id['ratings'],
          id['difficulty'],
          explaination
        ]);
        allOptions.add(id['options']);
      });
    }

    setState(() {
      currentPage++;
    });

    return true;
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
  void initState() {
    super.initState();
    myFuture = getBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Bookmarked Questions",
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
                    final result = await getBookmarks();
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
                                          explaination: questionStatements[i]
                                              [4],
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
            if (loadingDone && questionStatements.isEmpty)
              const Text(
                "No Questions Available",
                style: TextStyle(fontSize: 25, color: Colors.red),
              ),
            if (banner == null)
              const Text("yo")
            else
              SizedBox(height: 150, child: AdWidget(ad: banner!))
          ],
        )));
  }
}
