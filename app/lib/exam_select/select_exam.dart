import 'package:app/home/home.dart';
import 'package:app/weekly_competition/quiz_db.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/config.dart';

var examNames = {
  'ias': 'IAS',
  'jee': 'JEE',
  'jeeMains': 'JEE MAINS',
  'jeeAdv': 'JEE ADV',
  'neet': 'NEET',
  'ras': 'RAS',
  'ibpsPO': 'IBPS PO',
  'ibpsClerk': 'IBPS CLERK',
  'sscCHSL': 'SSC CHSL',
  'sscCGL': 'SSC CGL',
  'nda': 'NDA',
  'cds': 'CDS',
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

updateExamDetails(String examName) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString("exam_name", examName);
}

List<String> exam_names = [
  'ias',
  'jee',
  'jeeMains',
  'jeeAdv',
  'neet',
  'ras',
  'ibpsPO',
  'ibpsClerk',
  'sscCHSL',
  'sscCGL',
  'nda',
  'cds',
  'ntpc',
  'reet1',
  'reet2',
  'reet2Science',
  'patwari',
  'grade2nd',
  'grade2ndScience',
  'grade2ndSS',
  'sscGD',
  'sscMTS',
  'rajPoliceConst',
  'rajLDC',
  'rrbGD',
  'sipaper1',
  'sipaper2'
];

class SelectExam extends StatefulWidget {
  const SelectExam({Key? key, required this.data}) : super(key: key);
  final Config data;

  @override
  _SelectExamState createState() => _SelectExamState();
}

class _SelectExamState extends State<SelectExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
              child: Text(
                "👋",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              'Hello ${widget.data.username}!',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
              child: Text(
                "Welcome to Smartprep",
                style: TextStyle(color: Colors.grey, fontSize: 17),
              )),
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 30),
              child: Text(
                "Choose the exam you are preparing for",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          for (var i = 0; i < exam_names.length / 2; i++)
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: OutlinedButton(
                      onPressed: () {
                        updateExamDetails(exam_names[i * 2]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                    data: Config(
                                        username: widget.data.username,
                                        examname: exam_names[i * 2],
                                        email: widget.data.email))));
                      },
                      child: Text(
                        examNames[exam_names[i * 2]] ?? "Exam",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.lightBlueAccent),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          overlayColor: MaterialStateProperty.all(Colors.blue),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          fixedSize:
                              MaterialStateProperty.all(const Size(130, 80))),
                    )),
                if (i * 2 + 1 != exam_names.length)
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: OutlinedButton(
                        onPressed: () {
                          updateExamDetails(exam_names[i * 2 + 1]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home(
                                        data: Config(
                                            username: widget.data.username,
                                            examname: exam_names[i * 2 + 1],
                                            email: widget.data.email),
                                      )));
                        },
                        child: Text(
                          examNames[exam_names[i * 2 + 1]] ?? "Exam",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                                Colors.lightBlueAccent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            overlayColor:
                                MaterialStateProperty.all(Colors.blue),
                            shadowColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            fixedSize:
                                MaterialStateProperty.all(const Size(130, 80))),
                      ))
              ],
            )
        ],
      ),
    );
  }
}
