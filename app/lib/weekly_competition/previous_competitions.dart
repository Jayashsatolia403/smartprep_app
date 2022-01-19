import 'dart:convert';

import 'package:app/weekly_competition/previous_competition_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../ad_state.dart';

class PreviousCompetitions extends StatefulWidget {
  const PreviousCompetitions({Key? key}) : super(key: key);

  @override
  _PreviousCompetitionsState createState() => _PreviousCompetitionsState();
}

class _PreviousCompetitionsState extends State<PreviousCompetitions> {
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

  List<dynamic> previousCompetitions = [];
  int currentPage = 1;
  // ignore: prefer_final_fields
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

    final resJson = jsonDecode(utf8.decode(response.bodyBytes));

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
    super.initState();
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
            onLoading: () async {
              final result = await getPreviousCompetitons();
              if (result) {
                _refreshController.loadComplete();
              } else {
                _refreshController.loadFailed();
              }
            },
            child: Column(children: [
              ListView.builder(
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
              ),
              const SizedBox(
                height: 20,
              ),
              if (banner == null)
                const Text("yo")
              else
                SizedBox(height: 150, child: AdWidget(ad: banner!))
            ])));
  }
}
