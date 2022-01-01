import 'dart:convert';

import 'package:app/weekly_competition/previous_competition_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PreviousCompetitions extends StatefulWidget {
  const PreviousCompetitions({Key? key}) : super(key: key);

  @override
  _PreviousCompetitionsState createState() => _PreviousCompetitionsState();
}

class _PreviousCompetitionsState extends State<PreviousCompetitions> {
  List<dynamic> previousCompetitions = [];
  int currentPage = 1;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getPreviousCompetitons() async {
    String url = await rootBundle.loadString('assets/text/url.txt');

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String examName = prefs.getString("exam_name") ?? "Exam";

    final response = await http.get(
      Uri.parse(
          '$url/get_previous_contests?exam=$examName&page=$currentPage&page_size=10'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    if (response.statusCode == 404) {
      _refreshController.loadNoData();
      return false;
    }

    final resJson = jsonDecode(response.body);

    for (var i in resJson) {
      setState(() {
        previousCompetitions.add(i);
      });
    }

    setState(() {
      currentPage++;
    });

    return true;
  }

  @override
  void initState() {
    getPreviousCompetitons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Previous Weekly Competitions"),
        ),
        body: SmartRefresher(
            controller: _refreshController,
            enablePullUp: true,
            onLoading: () async {
              final result = await getPreviousCompetitons();
              if (result) {
                _refreshController.loadComplete();
              } else {
                _refreshController.loadFailed();
              }
            },
            child: ListView.builder(
              itemCount: previousCompetitions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(previousCompetitions[index][0]),
                  subtitle: const Text("Tap to view"),
                  leading: const Icon(Icons.book),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreviousCompetitionView(
                            compUuid: previousCompetitions[index][1],
                            compName: previousCompetitions[index][0],
                          ),
                        ));
                  },
                );
              },
            )));
  }
}
