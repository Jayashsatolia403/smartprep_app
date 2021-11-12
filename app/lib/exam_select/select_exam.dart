import 'package:app/home/home.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';


var examNames = {'IAS': 'ias',
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
  'NTPC': 'ntpc'};

Future<String> getName() async {
  final prefs = await SharedPreferences.getInstance();

  String name = prefs.getString("name") ?? "User";

  return name;
}


updateExamDetails(String examName) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString("exam_name", examNames[examName] ?? "Null");

  print(prefs.getString("exam_name"));
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
  'CAT',
  'NTPC'];

class SelectExam extends StatefulWidget {
  const SelectExam({Key? key}) : super(key: key);

  @override
  _SelectExamState createState() => _SelectExamState();
}

class _SelectExamState extends State<SelectExam> {
  String name = "Jayash Satolia";

  Future<String> _getName = getName();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String> (
      future: _getName,
      builder: (BuildContext context, AsyncSnapshot<String> snapShot) {
        return Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  snapShot.hasData ? "Hello $snapShot.val()!" : "Hello User!",
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
                  child: Text(
                    "Welcome to Smartprep",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17
                    ),
                  )
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 0, 30),
                  child: Text(
                    "Choose the exam you are preparing for",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  )
              ),
              for (var i=0; i < exam_names.length/2; i++)
                Row(
                  children: [Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: OutlinedButton(
                        onPressed: () {
                          updateExamDetails(exam_names[i*2]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Home())
                          );
                        },
                        child: Text(
                          exam_names[i*2],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            overlayColor: MaterialStateProperty.all(Colors.blue),
                            shadowColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            ),
                            fixedSize: MaterialStateProperty.all(const Size(130, 80))
                        ),
                      )
                  ), Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: OutlinedButton(
                        onPressed: () {
                          updateExamDetails(exam_names[i*2+1]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Home())
                          );
                        },
                        child: Text(
                          exam_names[i*2+1],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            overlayColor: MaterialStateProperty.all(Colors.blue),
                            shadowColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            ),
                            fixedSize: MaterialStateProperty.all(const Size(130, 80))
                        ),
                      )
                  )],
                )
            ],
          ),
        );
      }
    );

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              "Hello $name!",
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
            child: Text(
              "Welcome to Smartprep",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17
              ),
            )
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 30),
            child: Text(
              "Choose the exam you are preparing for",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            )
          ),
          for (var i=0; i < exam_names.length/2; i++)
            Row(
              children: [Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: OutlinedButton(
                    onPressed: () {
                      updateExamDetails(exam_names[i*2]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home())
                      );
                    },
                    child: Text(
                      exam_names[i*2],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        overlayColor: MaterialStateProperty.all(Colors.blue),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                        fixedSize: MaterialStateProperty.all(const Size(130, 80))
                    ),
                  )
              ), Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: OutlinedButton(
                    onPressed: () {
                      updateExamDetails(exam_names[i*2+1]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home())
                      );
                    },
                    child: Text(
                      exam_names[i*2+1],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        overlayColor: MaterialStateProperty.all(Colors.blue),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                        fixedSize: MaterialStateProperty.all(const Size(130, 80))
                    ),
                  )
              )],
            )
        ],
      ),
    );
  }
}
