import 'package:app/tests/daily_questions.dart';
import 'package:app/weekly_competition/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/ad_state.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../config.dart';

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
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Tests",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "High Quality Questions for ${widget.data.examname}",
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                )),
          ],
        ),
        backgroundColor: Colors.purple,
        toolbarHeight: 120,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Align(
              child: Text(widget.data.examname,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              alignment: Alignment.topLeft,
            ),
          ),
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
                        icon: Image.asset(
                            "assets/images/all_india_mock_test.png"),
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
                        icon: Image.asset("assets/images/daily_questions.png"),
                        iconSize: 200)),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {
                          print("HEY!");
                        },
                        icon: Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200)),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {
                          print("HEY!");
                        },
                        icon: Image.asset("assets/images/allindiatest.png"),
                        iconSize: 200)),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: IconButton(
                        onPressed: () {
                          print("HEY!");
                        },
                        icon: Image.asset("assets/images/allindiatest.png"),
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
