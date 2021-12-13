import 'dart:convert';

import 'package:app/tests/quiz_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../ad_state.dart';
import '../config.dart';

Future<List<dynamic>> getBookmarks() async {
  String url = await rootBundle.loadString('assets/text/url.txt');
  print(url);
  List<dynamic> allOptions = <dynamic>[];
  List<dynamic> questionStatements = <dynamic>[];
  List<dynamic> result = <dynamic>[];

  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  final response = await http.get(
    Uri.parse('$url/get_bookmarked_questions'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token $token"
    },
  );

  questionStatements = <dynamic>[];
  allOptions = <dynamic>[];

  for (var id in jsonDecode(response.body)) {
    final ques = await http.get(
      Uri.parse('$url/getQuesByID?quesID=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    questionStatements.add(jsonDecode(ques.body)['statement']);
    allOptions.add(jsonDecode(ques.body)['options']);
  }

  result.add(questionStatements);
  result.add(allOptions);

  print(result);

  return result;
}

class Bookmarks extends StatefulWidget {
  Bookmarks({Key? key, required this.data}) : super(key: key);

  Config data;

  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
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

    Future<List<dynamic>> _bookmarks = getBookmarks();

    return FutureBuilder<List<dynamic>>(
        future: _bookmarks,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapShot) {
          if (snapShot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Bookmarked Questions",
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.purple,
                  toolbarHeight: 100,
                ),
                body: Scaffold(
                    body: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var i = 0; i < snapShot.data![0].length; i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 50, bottom: 20),
                              child: ElevatedButton(
                                child: Text(snapShot.data![0][i],
                                    style:
                                        const TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomRadio(
                                              options: snapShot.data![1][i],
                                              statement: snapShot.data![0][i],
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
                    if (banner == null)
                      const Text("yo")
                    else
                      SizedBox(height: 150, child: AdWidget(ad: banner!))
                  ],
                )));
          } else {
            return const Text("Problems");
          }
        });
  }
}
