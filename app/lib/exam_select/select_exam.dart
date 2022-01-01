import 'package:app/home/home.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/config.dart';

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
  'NTPC': 'ntpc',
  "REET LEVEL 1": "reet1",
  "REET LEVEL 2": "reet2",
  "PATWARI": "patwari",
  "2nd Grade Paper 1": "grade2nd",
  "2nd Grade Science": "grade2ndScience",
  "2nd Grade Social Science ": "grade2ndSS",
  "SSC GD": "sscGD",
  "SSC MTS": "sscMTS",
  "Rajasthan Police Constable": "rajPoliceConst",
  "Rajasthan LDC": "rajLDC",
  "RRB GD": "rrbGD",
  "SI Paper 1": "sipaper1",
  "SI Paper 2": "sipaper2"
};

updateExamDetails(String examName) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString("exam_name", examNames[examName] ?? "Null");
}

List<String> exam_names = <String>[
  'IAS',
  'JEE',
  'JEE MAINS',
  'JEE ADV',
  'NEET',
  'RAS',
  'IBPS PO',
  'IBPS CLERK',
  'SSC CHSL',
  'SSC CGL',
  'NDA',
  'CDS',
  'NTPC',
  "REET LEVEL 1",
  "REET LEVEL 2",
  "PATWARI",
  "2nd Grade Paper 1",
  "2nd Grade Science",
  "2nd Grade Social Science",
  "SSC GD",
  "SSC MTS",
  "Rajasthan Police Constable",
  "Rajasthan LDC",
  "RRB GD",
  "SI Paper 1",
  "SI Paper 2"
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
                        exam_names[i * 2],
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
                        exam_names[i * 2 + 1],
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
                    ))
              ],
            )
        ],
      ),
    );
  }
}
