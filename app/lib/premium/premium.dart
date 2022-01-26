import 'dart:convert';

import 'package:app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'package:app/config.dart';

String dropdownValue = 'default';

final List<bool> _selections = List.generate(3, (index) => false);

List<Widget> plans = <Widget>[
  Container(
    child: Center(
      child: Column(
        children: const [
          SizedBox(
            height: 15,
          ),
          Text(
            "Standard",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "30 Rs",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
    // color: _selections[0] ? Colors.deepPurple[100] : Colors.white,
    height: 100,
    width: 170,
  ),
  Container(
    child: Center(
      child: Column(
        children: const [
          SizedBox(
            height: 15,
          ),
          Text(
            "Premium",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "50 Rs",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
    // color: _selections[1] ? Colors.deepPurple[100] : Colors.white,
    height: 100,
    width: 170,
  ),
  Container(
    child: Center(
      child: Column(
        children: const [
          SizedBox(
            height: 15,
          ),
          Text(
            "Ultimate",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "100 Rs",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
    // color: _selections[2] ? Colors.deepPurple[100] : Colors.white,
    height: 100,
    width: 170,
  )
];

List<String> examNames = [
  'ias',
  'iasHindi',
  'neet',
  'ras',
  'rasHindi',
  'ibpsPO',
  'ibpsClerk',
  'sscCHSL',
  'sscCGL',
  'sscCGLHindi',
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

class Premium extends StatefulWidget {
  const Premium({Key? key, required this.data}) : super(key: key);

  final Config data;

  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  int amount = 0;

  Future<bool?> showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text("Please Choose an Exam First"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Column(
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 85, 5),
              child: Text(
                "Our Premium Study Packs",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(26, 5, 60, 5),
              child: Text(
                "Preparing for another exam? Edit your \nprofile to view other study packs.",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
        toolbarHeight: 90,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              "Choose Subject: ",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: DropdownButton(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple, fontSize: 18),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: examNames.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Center(
                              child: Text(examNameValues[value] ?? "Exam"))));
                }).toList(),
              )),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ToggleButtons(
              children: plans,
              isSelected: _selections,
              onPressed: (int index) => {
                setState(() {
                  for (var i = 0; i < _selections.length; i++) {
                    _selections[i] = false;
                  }

                  if (index == 0) {
                    amount = 30;
                  } else if (index == 1) {
                    amount = 50;
                  } else if (index == 2) {
                    amount = 100;
                  }

                  _selections[index] = !_selections[index];
                })
              },
              color: Colors.black,
              borderColor: Colors.black,
              selectedColor: Colors.deepPurple,
              selectedBorderColor: Colors.deepPurple,
              fillColor: Colors.deepPurple[100],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (_selections[0] == true)
            SingleChildScrollView(
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Solve High Quality Practice Questions and Gauge Your Exam Readiness with Regular All India Mock Tests",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.book),
                      title: Text(
                        "30 High Quality Daily Questions",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          "Get Access of 30 Questions Daily and All Past Seen Questions for Lifetime"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.book_outlined),
                      title: Text("All India Mock Test"),
                      subtitle:
                          Text("Weekly Full Syllabus All India Mock Tests"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.people),
                      title: Text("Community & Public Forum"),
                      subtitle: Text(
                          "Connect with Other Aspirants, Ask Questions and Clear Doubts with some Funny Memes"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.article),
                      title: Text("High Quality Articles & Tips"),
                      subtitle: Text(
                          "Get Access to High Quality Articles, Tips to Boost your Preparation"),
                    ),
                  ),
                ],
              ),
            )
          else if (_selections[1] == true)
            SingleChildScrollView(
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Solve High Quality Practice Questions and Gauge Your Exam Readiness with Regular All India Mock Tests",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.book),
                      title: Text(
                        "60 High Quality Daily Questions",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Get Access of 60 Questions Daily and All Past Seen Questions for Lifetime",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.book_outlined),
                      title: Text("All India Mock Test"),
                      subtitle:
                          Text("Weekly Full Syllabus All India Mock Tests"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.people),
                      title: Text("Community & Public Forum"),
                      subtitle: Text(
                          "Connect with Other Aspirants, Ask Questions and Clear Doubts with some Funny Memes"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.article),
                      title: Text("High Quality Articles & Tips"),
                      subtitle: Text(
                          "Get Access to High Quality Articles, Tips to Boost your Preparation"),
                    ),
                  ),
                ],
              ),
            )
          else if (_selections[2] == true)
            SingleChildScrollView(
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Solve High Quality Practice Questions and Gauge Your Exam Readiness with Regular All India Mock Tests",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.book),
                      title: Text(
                        "150 High Quality Daily Questions",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Get Access of 150 Questions Daily and All Past Seen Questions for Lifetime",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.book_outlined),
                      title: Text("All India Mock Test"),
                      subtitle:
                          Text("Weekly Full Syllabus All India Mock Tests"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.people),
                      title: Text("Community & Public Forum"),
                      subtitle: Text(
                          "Connect with Other Aspirants, Ask Questions and Clear Doubts with some Funny Memes"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: ListTile(
                      leading: Icon(Icons.article),
                      title: Text("High Quality Articles & Tips"),
                      subtitle: Text(
                          "Get Access to High Quality Articles, Tips to Boost your Preparation"),
                    ),
                  ),
                ],
              ),
            ),
          ElevatedButton(
            onPressed: () async {
              if (dropdownValue == "default") {
                await showAlertDialog(context);
              } else {
                String url = StaticDetails().url;

                if (await canLaunch(url)) {
                  await launch('$url/payments');
                } else {
                  throw 'Could not launch $url';
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              data: widget.data,
                            )));
              }
            },
            child: const Text('SUbscribe', style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 50),
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                alignment: Alignment.center),
          ),
        ],
      ),
    );
  }
}
