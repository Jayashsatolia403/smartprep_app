import 'package:app/bookmarks/bookmarks.dart';
import 'package:app/practice_questions/practice_questions_home.dart';
import 'package:app/tests/daily_questions.dart';
import 'package:app/weekly_competition/home.dart';
import 'package:app/weekly_competition/previous_competitions.dart';
import 'package:flutter/material.dart';

import 'package:app/ad_state.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../config.dart';

var examNameValues = {
  'ias': 'IAS',
  'iasHindi': 'IAS Hindi Medium',
  'neet': 'NEET',
  'ras': 'RAS',
  'rasHindi': 'RAS Hindi Medium',
  'ibpsPO': 'IBPS PO',
  'ibpsClerk': 'IBPS CLERK',
  'sscCHSL': 'SSC CHSL',
  'sscCGL': 'SSC CGL',
  'sscCGLHindi': 'SSC CGL Hindi Medium',
  'ntpc': 'NTPC',
  'reet1': 'REET LEVEL 1',
  'reet2': 'REET LEVEL 2 Social Science',
  'reet2Science': 'REET LEVEL 2 Science',
  'patwari': 'PATWARI',
  'grade2nd': '2nd Grade Paper 1',
  'grade2ndScience': '2nd Grade Science',
  'grade2ndSS': '2nd Grade Social Science ',
  'sscGD': 'SSC GD',
  'sscMTS': 'SSC MTS',
  'rajPoliceConst': 'Rajasthan Police Constable',
  'rajLDC': 'Rajasthan LDC',
  'rrbGD': 'RRB GD',
  'sipaper1': 'SI Paper 1',
  'sipaper2': 'SI Paper 2'
};

class Tests extends StatefulWidget {
  const Tests({Key? key, required this.data}) : super(key: key);

  final Config data;

  @override
  _TestsState createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);

    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
            adUnitId: adState.bannerAdUnitId,
            size: const AdSize(height: 300, width: 360),
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
        title: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Tests",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  examNameValues[widget.data.examname] ??
                      "High Quality Questions",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                )),
          ],
        ),
        backgroundColor: Colors.purple,
        toolbarHeight: 120,
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WeeklyCompetitionHome()),
                          );
                        },
                        icon: Image.asset("assets/images/wc.png"),
                        iconSize: 200)),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DailyQuestions()),
                          );
                        },
                        icon: Image.asset("assets/images/dq.png"),
                        iconSize: 200)),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Bookmarks()),
                          );
                        },
                        icon: Image.asset("assets/images/Bookmarks.png"),
                        iconSize: 200)),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PracticeQuestions()),
                          );
                        },
                        icon: Image.asset("assets/images/pq.png"),
                        iconSize: 200)),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PreviousCompetitions()),
                          );
                        },
                        icon: Image.asset("assets/images/pwq.png"),
                        iconSize: 200)),
              ],
            ),
            scrollDirection: Axis.horizontal,
          ),
          if (banner == null)
            const Text("yo")
          else
            SizedBox(height: 200, child: AdWidget(ad: banner!))
        ],
      ),
    );
  }
}
