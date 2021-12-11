import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'package:app/config.dart';

String dropdownValue = 'default';

final List<bool> _selections = List.generate(3, (index) => false);

Future<String> getExamName() async {
  final prefs = await SharedPreferences.getInstance();

  dropdownValue = prefs.getString("exam_name")!;

  return dropdownValue;
}

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

List<String> examNames = <String>[
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
  'NTPC',
  'DEFAULT'
];

var examNameValues = {
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
  'NTPC': 'ntpc',
  'DEFAULT': 'default'
};

class Premium extends StatefulWidget {
  const Premium({Key? key, required this.data}) : super(key: key);

  final Config data;

  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
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
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: DropdownButton(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
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
                      value: examNameValues[value],
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(130, 0, 110, 0),
                          child: Text(value)));
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
              String url = await rootBundle.loadString('assets/text/url.txt');
              final prefs = await SharedPreferences.getInstance();
              String? token = prefs.getString("token");
              print(dropdownValue);
              final response = await http.get(
                Uri.parse(
                    '$url/payments/checkout?amount=30&exam=$dropdownValue'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization': "Token $token"
                },
              );

              final checkoutUrl = jsonDecode(response.body);

              if (await canLaunch(url)) {
                await launch(checkoutUrl);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: const Text('Pay', style: TextStyle(fontSize: 20)),
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
