import 'dart:convert';

import 'package:app/add_ques/add_ques.dart';
import 'package:app/article/articles_home.dart';
import 'package:app/bookmarks/bookmarks.dart';
import 'package:app/error_page/error_page.dart';
import 'package:app/exam_select/select_exam.dart';
import 'package:app/feedback_complaint/complaint.dart';
import 'package:app/feedback_complaint/feedback.dart';
import 'package:app/forum%20/messages.dart';
import 'package:app/home/slider.dart';
import 'package:app/rewarded_ad_ques/rewarded_ques.dart';
import 'package:app/test_page/tests.dart';
import 'package:app/premium/premium.dart';
import 'package:app/profile/profile_page.dart';
import 'package:app/tests/quiz_template.dart';
import 'package:app/weekly_competition/previous_competitions.dart';
import 'package:flutter/material.dart';
import 'package:app/config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:google_mobile_ads/google_mobile_ads.dart';

List<String> alphabets = <String>[
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

var examNames = {
  'IAS': 'ias',
  'JEE': 'jee',
  'JEE MAINS': 'jeeMains',
  'JEE ADV': 'jeeAdv',
  'NEET': 'neet',
  'RAS': 'ras',
  'IBPS PO': 'ibpsPO',
  'IBPS CLERK': 'ibpsClerk',
  'SSC CHSL': 'sscCHSL',
  'SSC CGL': 'sscCGL',
  'NDA': 'nda',
  'CDS': 'cds',
  'CAT': 'cat',
  'NTPC': 'ntpc'
};

String greet() {
  var now = DateTime.now();

  if (now.hour < 12) {
    return 'Good Morning';
  } else if (now.hour < 17) {
    return 'Good Afternoon';
  } else if (now.hour < 20) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.data}) : super(key: key);
  final Config data;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String greetMessage = greet();
  late Future<bool> _isAddedQuestion;

  late RewardedAd rewardedAd;

  void loadVideoAd() async {
    RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback:
            RewardedAdLoadCallback(onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
        }, onAdFailedToLoad: (LoadAdError error) {
          loadVideoAd();
        }));
  }

  void showVideoAd() {
    loadVideoAd();
    rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem rpoint) {
      print("Reward Earned ${rpoint.amount}");
    });

    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdFailedToShowFullScreenContent: (ad, error) => print(error),
      onAdShowedFullScreenContent: (ad) => print("Working"),
    );
  }

  Future<bool> isAddedQuestion() async {
    String url = await rootBundle.loadString('assets/text/url.txt');
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token") ?? "NA";

    final response = await http.get(
      Uri.parse('$url/has_user_added_question_today'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Token $token"
      },
    );

    return jsonDecode(response.body);
  }

  @override
  void initState() {
    _isAddedQuestion = isAddedQuestion();
  }

  @override
  Widget build(BuildContext context) {
    List<AddQuesModel> optionsData = <AddQuesModel>[];

    for (var i = 0; i < 26; i++) {
      optionsData.add(AddQuesModel(false, alphabets[i], ""));
    }

    return FutureBuilder<bool>(
        future: _isAddedQuestion,
        builder: (BuildContext context, AsyncSnapshot<bool> snapShot) {
          if (snapShot.hasData) {
            if (snapShot.data == true) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.deepPurpleAccent,
                  title: Image.asset("assets/images/logo14.png", height: 60),
                  toolbarHeight: 80,
                ),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      // ignore: sized_box_for_whitespace
                      Container(
                          child: DrawerHeader(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Column(children: [
                              Text(widget.data.username,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left),
                              ListTile(
                                leading: const Icon(Icons.person),
                                title: const Text("Your Profile",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile(
                                                data: widget.data,
                                              )));
                                },
                              )
                            ]),
                          ),
                          height: 150),
                      ListTile(
                        title: Text(widget.data.examname,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 17)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectExam(
                                        data: widget.data,
                                      )));
                        },
                        tileColor: Colors.deepPurpleAccent,
                      ),
                      ListTile(
                        title: const Text('Explore Premium',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Premium(
                                        data: widget.data,
                                      )));
                        },
                        tileColor: Colors.deepPurpleAccent,
                        // leading: const Icon(Icons.),
                      ),
                      ListTile(
                        title: const Text('Add Question',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddQuestions(
                                        data: widget.data,
                                        val: 2,
                                        quesStatement: "",
                                        optionsData: optionsData,
                                      )));
                        },
                        tileColor: Colors.deepPurpleAccent,
                        // leading: const Icon(Icons.),
                      ),
                      ListTile(
                        title: const Text('Bookmarks',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bookmarks(
                                        data: widget.data,
                                      )));
                        },
                        tileColor: Colors.deepPurpleAccent,
                        // leading: const Icon(Icons.),
                      ),
                      ListTile(
                        title: const Text('Forum',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Messages(
                                      forumname:
                                          examNames[widget.data.examname] ??
                                              "ias")));
                        },
                        tileColor: Colors.deepPurpleAccent,
                        // leading: const Icon(Icons.),
                      ),
                      ListTile(
                        title: const Text('Previous Competition',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PreviousCompetitions()));
                        },
                        tileColor: Colors.deepPurpleAccent,
                        // leading: const Icon(Icons.),
                      ),
                      ListTile(
                        title: const Text('Feedback',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GiveFeedback()));
                        },
                        tileColor: Colors.deepPurpleAccent,
                        // leading: const Icon(Icons.),
                      ),
                      ListTile(
                        title: const Text('Complaint',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MakeComplaint()));
                        },
                        tileColor: Colors.deepPurpleAccent,
                        // leading: const Icon(Icons.),
                      ),
                    ],
                  ),
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        '$greetMessage ${widget.data.username}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                        )),
                                    const SizedBox(width: 40),
                                    Image.asset(
                                      'assets/images/brain_bulb.jpg',
                                      width: 40,
                                      height: 45,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 60, 10),
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        const Text(
                                          "Featured Articles",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ArticlesHome()));
                                            },
                                            icon: const Icon(
                                              Icons.arrow_right,
                                              size: 35,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                const HomeSlider(),
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 25, 0, 5),
                                    child: ListTile(
                                      title: const Text(
                                        "Activities for you",
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      tileColor: Colors.grey[200],
                                    )),
                                const ListTile(
                                  title: Text(
                                    "Quote of the Day",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                      "Intelligence is Ability to Adapt Change."),
                                ),
                                ListTile(
                                  title: const Text(
                                    "Question of the day",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  tileColor: Colors.blue[100],
                                  onTap: () async {
                                    String url = await rootBundle
                                        .loadString('assets/text/url.txt');

                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    String? token = prefs.getString("token");

                                    final response = await http.get(
                                      Uri.parse(
                                          '$url/getQuesOfDay?exam=${widget.data.examname}'),
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                        'Authorization': "Token $token"
                                      },
                                    );

                                    final resJson = jsonDecode(response.body);

                                    if (response.statusCode == 400 ||
                                        resJson == "Error") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ErrorPage()));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CustomRadio(
                                                  options: resJson['options'],
                                                  statement:
                                                      resJson['statement'],
                                                  quesUUid: resJson['uuid'],
                                                  qualityRating:
                                                      resJson['ratings'],
                                                  difficultyRating:
                                                      resJson['difficulty'],
                                                  isRated: resJson['isRated'],
                                                  createdBy:
                                                      resJson['createdBy'])));
                                    }
                                  },
                                ),
                                ListTile(
                                  title: const Text("Go to Practice Section"),
                                  leading: const Icon(Icons.book),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Tests(
                                                  data: widget.data,
                                                )));
                                  },
                                  tileColor: Colors.cyan[100],
                                ),
                                ListTile(
                                  title: const Text("Rewarded Questions"),
                                  leading: const Icon(Icons.book),
                                  onTap: () {
                                    showVideoAd();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RewardedQuestions()));
                                  },
                                  tileColor: Colors.blue[100],
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return AddQuestions(
                data: widget.data,
                val: 2,
                quesStatement: "",
                optionsData: optionsData,
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
