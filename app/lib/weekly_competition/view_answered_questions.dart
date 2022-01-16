import 'package:app/weekly_competition/quiz_db.dart';
import 'package:app/weekly_competition/quiz_template.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'quiz_models.dart';

class ViewAnsweredQuestions extends StatefulWidget {
  const ViewAnsweredQuestions({Key? key}) : super(key: key);

  @override
  _ViewAnsweredQuestionsState createState() => _ViewAnsweredQuestionsState();
}

class _ViewAnsweredQuestionsState extends State<ViewAnsweredQuestions> {
  String exam = "";
  int firstIdx = 1;
  List<bool> result = [];

  String quesStatement = '';
  String quesUuid = '';

  _getQuestion(int idx) async {
    Questions q = await QuizDatabase.instance.readQuestionsById(idx);

    setState(() {
      quesStatement = q.statement;
      quesUuid = q.uuid;
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

  Future<bool> getAnsweredQuestions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? examName = prefs.getString("exam_name");

      setState(() {
        exam = examName ?? "None";
      });

      final allDates = await QuizDatabase.instance.readAllDate();
      final date = allDates[0];

      setState(() {
        firstIdx = date.firstIdx;
      });

      final questions = await QuizDatabase.instance.readAllQuestions();

      for (var i = 0; i < totalQuestions[examName]!; i++) {
        result.add(false);
      }

      int idx = 0;

      for (var ques in questions) {
        setState(() {
          result[idx] = ques.isAnswered;
        });

        idx++;
      }
    } catch (error) {
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    getAnsweredQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
            "Competition Questions",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text(
                    "Answered : ",
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(''),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        shape: MaterialStateProperty.all(const CircleBorder(
                            side: BorderSide(color: Colors.green))),
                        fixedSize:
                            MaterialStateProperty.all(const Size(30, 30))),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  const Text(
                    "Not Answered : ",
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(''),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all(const CircleBorder(
                            side: BorderSide(color: Colors.red))),
                        fixedSize:
                            MaterialStateProperty.all(const Size(30, 30))),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          for (var index = 0; index < (totalQuestions[exam]! / 5); index++)
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var i = 0; i < 5; i++)
                    if ((index * 5 + 1 + i) <= totalQuestions[exam]!)
                      Column(children: [
                        ElevatedButton(
                          onPressed: () async {
                            await _getQuestion(firstIdx + index * 5 + i);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomRadio(
                                        quesUuid: quesUuid,
                                        statement: quesStatement,
                                      )),
                            );
                          },
                          child: Text(
                            '${index * 5 + i + 1}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              backgroundColor: result[index * 5 + i]
                                  ? MaterialStateProperty.all(Colors.green)
                                  : MaterialStateProperty.all(Colors.red),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(CircleBorder(
                                  side: BorderSide(
                                      color: result[index * 5 + i]
                                          ? Colors.green
                                          : Colors.red))),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(60, 60))),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ]),
                ],
              ),
              const SizedBox(
                height: 6,
              )
            ])
        ]));
  }
}




// if ((index * 5 + 2) <= totalQuestions[widget.exam]!)
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text(
//                         '${index * 5 + 2}',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       style: ButtonStyle(
//                           foregroundColor:
//                               MaterialStateProperty.all(Colors.white),
//                           backgroundColor: result[index * 5 + 1]
//                               ? MaterialStateProperty.all(Colors.green)
//                               : MaterialStateProperty.all(Colors.red),
//                           overlayColor: MaterialStateProperty.all(Colors.white),
//                           shape: MaterialStateProperty.all(CircleBorder(
//                               side: BorderSide(
//                                   color: result[index * 5 + 1]
//                                       ? Colors.green
//                                       : Colors.red))),
//                           fixedSize:
//                               MaterialStateProperty.all(const Size(60, 60))),
//                     ),
//                   if ((index * 5 + 2) <= totalQuestions[widget.exam]!)
//                     const SizedBox(
//                       width: 6,
//                     ),
//                   if ((index * 5 + 3) <= totalQuestions[widget.exam]!)
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text(
//                         '${index * 5 + 3}',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       style: ButtonStyle(
//                           foregroundColor:
//                               MaterialStateProperty.all(Colors.white),
//                           backgroundColor: result[index * 5 + 2]
//                               ? MaterialStateProperty.all(Colors.green)
//                               : MaterialStateProperty.all(Colors.red),
//                           overlayColor: MaterialStateProperty.all(Colors.white),
//                           shape: MaterialStateProperty.all(CircleBorder(
//                               side: BorderSide(
//                                   color: result[index * 5 + 2]
//                                       ? Colors.green
//                                       : Colors.red))),
//                           fixedSize:
//                               MaterialStateProperty.all(const Size(60, 60))),
//                     ),
//                   if ((index * 5 + 3) <= totalQuestions[widget.exam]!)
//                     const SizedBox(
//                       width: 6,
//                     ),
//                   if ((index * 5 + 4) <= totalQuestions[widget.exam]!)
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text(
//                         '${index * 5 + 4}',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       style: ButtonStyle(
//                           foregroundColor:
//                               MaterialStateProperty.all(Colors.white),
//                           backgroundColor: result[index * 5 + 3]
//                               ? MaterialStateProperty.all(Colors.green)
//                               : MaterialStateProperty.all(Colors.red),
//                           overlayColor: MaterialStateProperty.all(Colors.white),
//                           shape: MaterialStateProperty.all(CircleBorder(
//                               side: BorderSide(
//                                   color: result[index * 5 + 3]
//                                       ? Colors.green
//                                       : Colors.red))),
//                           fixedSize:
//                               MaterialStateProperty.all(const Size(60, 60))),
//                     ),
//                   if ((index * 5 + 4) <= totalQuestions[widget.exam]!)
//                     const SizedBox(
//                       width: 6,
//                     ),
//                   if ((index * 5 + 5) <= totalQuestions[widget.exam]!)
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text(
//                         '${index * 5 + 5}',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       style: ButtonStyle(
//                           foregroundColor:
//                               MaterialStateProperty.all(Colors.white),
//                           backgroundColor: result[index * 5 + 4]
//                               ? MaterialStateProperty.all(Colors.green)
//                               : MaterialStateProperty.all(Colors.red),
//                           overlayColor: MaterialStateProperty.all(Colors.white),
//                           shape: MaterialStateProperty.all(CircleBorder(
//                               side: BorderSide(
//                                   color: result[index * 5 + 4]
//                                       ? Colors.green
//                                       : Colors.red))),
//                           fixedSize:
//                               MaterialStateProperty.all(const Size(60, 60))),
//                     ),
//                   if ((index * 5 + 5) <= totalQuestions[widget.exam]!)
//                     const SizedBox(
//                       width: 6,
//                     ),