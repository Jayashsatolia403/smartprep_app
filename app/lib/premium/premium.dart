import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String dropdownValue = 'jee';

Future<String> getExamName() async {
  final prefs = await SharedPreferences.getInstance();

  dropdownValue = prefs.getString("exam_name")!;

  return dropdownValue;
}

List<Widget> plans = const <Widget>[
  Text("Standard"),
  Text("Good"),
  Text("Ultimate")
];

List<bool> plansSelected = const <bool>[false, false, true];

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
  'NTPC'
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
  'NTPC': 'ntpc'
};

class Premium extends StatefulWidget {
  const Premium({Key? key}) : super(key: key);

  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  final List<bool> _selections = List.generate(3, (index) => false);
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
                style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 15),
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
                  _selections[index] = !_selections[index];
                })
              },
            ),
          )
        ],
      ),
    );
  }
}
