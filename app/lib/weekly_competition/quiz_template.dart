// import 'dart:convert';

import 'package:app/weekly_competition/quiz_models.dart';
import 'package:app/weekly_competition/view_answered_questions.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:katex_flutter/katex_flutter.dart';

import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app/ad_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'quiz_db.dart';
import 'quiz_models.dart';

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;
  final String uuid;

  RadioModel(this.isSelected, this.buttonText, this.text, this.uuid);
}

// ignore: must_be_immutable
class CustomRadio extends StatefulWidget {
  CustomRadio(
      {Key? key,
      required this.statement,
      required this.quesUuid,
      required this.isLoadingDone})
      : super(key: key);

  String statement;
  String quesUuid;
  bool isLoadingDone;

  @override
  createState() {
    return CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  bool showExplaination = false;
  late Questions question;
  List<bool> correctOptions = [];
  List<String> nextQuesDetails = [];
  List<String> lastQuesDetails = [];
  bool isNextQuesAvailable = false;
  bool isLastQuesAvailable = false;
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

  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);

    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
            adUnitId: adState.bannerAdUnitId,
            size: AdSize.largeBanner,
            request: const AdRequest(),
            listener: adState.listener)
          ..load();
      });
    });
  }

  Map<String, int> totalQuestions = {
    "ias": 100,
    "iasHindi": 100,
    "neet": 180,
    "ras": 150,
    "rasHindi": 150,
    "ibpsPO": 100,
    "ibpsClerk": 100,
    "sscCGL": 100,
    "sscCGLHindi": 100,
    "sscCHSL": 100,
    "nda": 150,
    "cat": 90,
    "ntpc": 100,
    "reet1": 150,
    "reet2": 150,
    "reet2Science": 150,
    "patwari": 150,
    "grade2nd": 100,
    "grade2ndScience": 150,
    "grade2ndSS": 150,
    "sscGD": 100,
    "sscMTS": 100,
    "rajPoliceConst": 150,
    "rajLDC": 150,
    "rrbGD": 150,
    "sipaper1": 100,
    "sipaper2": 100
  };

  List<RadioModel> sampleData = [];

  Future<bool?> loadingQuestionsAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text(
                  "Competition Questions are Downloading. Please wait...."),
            ));
  }

  _initializeData() async {
    sampleData = [];
    Questions dbQuestion =
        await QuizDatabase.instance.readQuestionsByUUid(widget.quesUuid);

    setState(() {
      question = dbQuestion;
    });

    List<QuestionOptions> qOptions = await QuizDatabase.instance
        .readQuestionOptionsFromQuestionId(widget.quesUuid);

    int idx = 0;

    for (var qOption in qOptions) {
      Options option =
          await QuizDatabase.instance.readOptions(qOption.optionId);

      setState(() {
        sampleData.add(RadioModel(
            option.isSelected, alphabets[idx++], option.content, option.uuid));
      });
    }
  }

  _loadNextQuesData() async {
    Questions dbQuestion =
        await QuizDatabase.instance.readQuestionsByUUid(widget.quesUuid);

    final prefs = await SharedPreferences.getInstance();

    String? examName = prefs.getString("exam_name");

    final allDates = await QuizDatabase.instance.readAllDate();

    final date = allDates[0];

    if (totalQuestions[examName]! + date.firstIdx - 1 > dbQuestion.id!) {
      Questions nextQues =
          await QuizDatabase.instance.readQuestionsById(dbQuestion.id! + 1);

      setState(() {
        nextQuesDetails = [];
        nextQuesDetails.add(nextQues.statement);
        nextQuesDetails.add(nextQues.uuid);
        isNextQuesAvailable = true;
      });
    }
  }

  _loadPrevQuesData() async {
    Questions dbQuestion =
        await QuizDatabase.instance.readQuestionsByUUid(widget.quesUuid);

    final allDates = await QuizDatabase.instance.readAllDate();

    final date = allDates[0];

    if (dbQuestion.id! > date.firstIdx) {
      Questions nextQues =
          await QuizDatabase.instance.readQuestionsById(dbQuestion.id! - 1);

      setState(() {
        lastQuesDetails = [];
        lastQuesDetails.add(nextQues.statement);
        lastQuesDetails.add(nextQues.uuid);
        isLastQuesAvailable = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _initializeData();
    _loadNextQuesData();
    _loadPrevQuesData();
  }

  void updateOption(String uuid, String quesUuid) async {
    for (var i in sampleData) {
      Options option = await QuizDatabase.instance.readOptions(i.uuid);
      option.isSelected = false;
      await QuizDatabase.instance.updateOption(option);
    }
    Options option = await QuizDatabase.instance.readOptions(uuid);

    Questions ques =
        await QuizDatabase.instance.readQuestionsByUUid(widget.quesUuid);

    ques.isAnswered = true;

    await QuizDatabase.instance.updateQuestion(ques);

    option.isSelected = true;
    await QuizDatabase.instance.updateOption(option);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.deepPurpleAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                iconSize: 40,
                onPressed: () {
                  if (!widget.isLoadingDone) {
                    loadingQuestionsAlert(context);
                  } else {
                    setState(() {
                      widget.statement = lastQuesDetails[0];
                      widget.quesUuid = lastQuesDetails[1];
                    });

                    _initializeData();
                    _loadNextQuesData();
                    _loadPrevQuesData();
                  }
                },
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                )),
            const SizedBox(
              width: 13,
            ),
            IconButton(
              onPressed: () {
                if (widget.isLoadingDone) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAnsweredQuestions(
                              isLoadingDone: widget.isLoadingDone,
                            )),
                  );
                } else {
                  loadingQuestionsAlert(context);
                }
              },
              icon: const ImageIcon(
                AssetImage("assets/images/menu.png"),
              ),
            ),
            const SizedBox(
              width: 13,
            ),
            IconButton(
                iconSize: 40,
                onPressed: () {
                  if (!widget.isLoadingDone) {
                    loadingQuestionsAlert(context);
                  } else {
                    setState(() {
                      widget.statement = nextQuesDetails[0];
                      widget.quesUuid = nextQuesDetails[1];
                    });

                    _initializeData();
                    _loadNextQuesData();
                    _loadPrevQuesData();
                  }
                },
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                )),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
          itemCount: sampleData.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 20, right: 15, bottom: 30),
                    child: Text(
                      widget.statement,
                      style: const TextStyle(fontSize: 19),
                    )),
                InkWell(
                  highlightColor: Colors.red,
                  splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      for (var element in sampleData) {
                        element.isSelected = false;
                      }
                      sampleData[index].isSelected = true;
                      updateOption(sampleData[index].uuid, widget.quesUuid);
                    });
                  },
                  child: RadioItem(sampleData[index]),
                )
              ]);
            }
            return InkWell(
              highlightColor: Colors.red,
              splashColor: Colors.blueAccent,
              onTap: () {
                setState(() {
                  for (var element in sampleData) {
                    element.isSelected = false;
                  }
                  sampleData[index].isSelected = true;
                  updateOption(sampleData[index].uuid, widget.quesUuid);
                });
              },
              child: RadioItem(sampleData[index]),
            );
          },
        )),
        if (banner == null)
          const Text("yo")
        else
          SizedBox(height: 100, child: AdWidget(ad: banner!))
      ]),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  // ignore: use_key_in_widget_constructors
  const RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Row(
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 50.0,
            width: 50.0,
            child: Center(
              child: Text(_item.buttonText,
                  style: TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      fontSize: 18.0)),
            ),
            decoration: BoxDecoration(
              color: (() {
                if (_item.isSelected) {
                  return Colors.lightBlueAccent;
                } else {
                  return Colors.transparent;
                }
              }()),
              border: Border.all(
                width: 1.0,
                color: (() {
                  if (_item.isSelected) {
                    return Colors.lightBlueAccent;
                  } else {
                    return Colors.black;
                  }
                }()),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(2.0)),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
              child: Text(_item.text, style: const TextStyle(fontSize: 15)))
        ],
      ),
    );
  }
}
