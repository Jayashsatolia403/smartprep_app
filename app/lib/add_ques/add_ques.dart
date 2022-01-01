import 'dart:convert';
import 'package:app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class AddQuesModel {
  bool isSelected;
  String buttonText;
  String text;

  AddQuesModel(this.isSelected, this.buttonText, this.text);
}

List<String> iasSubjects = [
  "currentAffairsWorldHard",
  "currentAffairsIndiaEasy",
  "currentAffairsIndiaHard",
  "geographyIndEasy",
  "geographyIndHard",
  "geographyWorld",
  "polityIndEasy",
  "polityIndHard",
  "economyIndGen",
  "economyIndBudgetAndSchemes",
  "environmentAndEcologyHard",
  "environmentAndEcologyEasy",
  "historyIndEasy",
  "historyIndHard",
  "historyWorld",
  "InternationalRelationAndSecurity",
  "sciAndTechHard",
  "artAndCultureInd",
  "constitutionAndGovernance",
  "decisionMaking",
  "iasMisc"
];

List<String> jeeSubjects = [
  "physicsAdv",
  "mathsAdv",
  "chemAdv",
  "physicsMains",
  "mathsMains",
  "chemMains",
  "jeeMisc"
];
List<String> jeeAdvSubjects = [
  "physicsAdv",
  "mathsAdv",
  "chemAdv",
  "jeeAdvMisc"
];
List<String> jeeMainsSubjects = [
  "physicsMains",
  "mathsMains",
  "chemMains",
  "jeeMainsMisc"
];

List<String> neetSubjects = ["physicsMains", "bio", "chemMains", "neetMisc"];

List<String> rasSubjects = [
  "currentAffairsIndiaEasy",
  "currentAffairsIndiaHard",
  "currentAffairsWorldEasy",
  "geographyIndEasy",
  "geographyWorld",
  "polityIndEasy",
  "geographyIndHard",
  "polityIndHard",
  "economyIndGen",
  "economyIndBudgetAndSchemes",
  "environmentAndEcologyHard",
  "environmentAndEcologyEasy",
  "historyIndEasy",
  "historyIndHard",
  "sciAndTechEasy",
  "sciAndTechHard",
  "artAndCultureInd",
  "constitutionAndGovernance",
  "geographyRajEasy",
  "geographyRajHard",
  "historyRajHard",
  "historyRajEasy",
  "artAndCultureRaj",
  "polityRajEasy",
  "polityRajHard",
  "currentAffairsRajHard",
  "currentAffairsRajEasy",
  "artAndCultureInd",
  "economyRajHard",
  "economyRajEasy",
  "reasoningHard",
  "reasoningEasy",
  "rasMisc"
];

List<String> ndaSubjects = [
  "ndaPhysics",
  "ndaHistory",
  "ndaChemistry",
  "ndaMaths",
  "currentEvents",
  "ndaMisc"
];

List<String> cdsSubjects = [
  "reasoningEasy",
  "reasoningHard",
  "currentAffairsIndiaEasy",
  "englishLangAndComprehensionHard",
  "englishLangAndComprehensionEasy",
  "geographyIndEasy",
  "polityIndEasy",
  "historyIndEasy",
  "sciAndTechEasy",
  "cdsMaths",
  "environmentAndEcologyEasy",
  "cdsMisc"
];

List<String> ibpsPOSubjects = [
  "englishLangAndComprehensionHard",
  "quantAptHard",
  "reasoningHard",
  "reasoningEasy",
  "economyAndBanking",
  "dataAnalysisAndInterpretation",
  "financialAwareness",
  "basicComputer",
  "financeAndAccounts",
  "ibpsPOMisc"
];

List<String> ibpsClerkSubjects = [
  "englishLangAndComprehensionEasy",
  "englishLangAndComprehensionHard",
  "quantAptEasy",
  "quantAptHard",
  "reasoningEasy",
  "financialAwareness",
  "basicComputer",
  "financeAndAccounts",
  "ibpsClerkMisc"
];

List<String> sscCGLSubjects = [
  "reasoningHard",
  "reasoningEasy",
  "historyIndEasy",
  "currentAffairsIndiaEasy",
  "geographyIndEasy",
  "polityIndEasy",
  "quantAptEasy",
  "englishLangAndComprehensionHard",
  "englishLangAndComprehensionEasy",
  "financeAndAccounts",
  "statistics",
  "sscCGLMisc"
];

List<String> sscCHSLSubjects = [
  "reasoningHard",
  "reasoningEasy",
  "historyIndEasy",
  "currentAffairsIndiaEasy",
  "geographyIndEasy",
  "polityIndEasy",
  "quantAptEasy",
  "englishLangAndComprehensionEasy",
  "englishLangAndComprehensionHard",
  "sscCHSLMisc"
];

List<String> ntpcSubjects = [
  "reasoningHard",
  "reasoningEasy",
  "historyIndEasy",
  "currentAffairsIndiaEasy",
  "geographyIndEasy",
  "polityIndEasy",
  "quantAptEasy",
  "englishLangAndComprehensionEasy",
  "ntpcMisc"
];

List<String> reet1Subjects = ["reet1Misc"];
List<String> reet2Subjects = ["reet2Misc"];

List<String> sipaper1Subjects = ["hindi"];

List<String> sipaper2Subjects = [
  "reasoningEasy",
  "reasoningHard",
  "quantAptEasy",
  "currentAffairsIndiaEasy",
  "currentAffairsRajHard",
  "currentAffairsRajEasy",
  "currentAffairsWorldEasy",
  "geographyIndEasy",
  "polityIndEasy",
  "economyIndGen"
      "economyIndBudgetAndSchemes"
      "historyIndEasy",
  "generalScience",
  "geographyRajEasy",
  "geographyRajHard",
  "historyRajEasy",
  "historyRajHard",
  "artAndCultureRaj",
  "economyRajHard",
  "economyRajEasy",
  "sipaper2Misc"
];

List<String> patwariSubjects = [
  "hindi",
  "reasoningEasy",
  "reasoningHard",
  "quantAptEasy",
  "currentAffairsIndiaEasy",
  "currentAffairsRajHard",
  "currentAffairsRajEasy",
  "currentAffairsWorldEasy",
  "englishLangAndComprehensionEasy",
  "basicComputer",
  "geographyIndEasy",
  "polityIndEasy",
  "economyIndGen"
      "economyIndBudgetAndSchemes"
      "historyIndEasy",
  "generalScience",
  "geographyRajEasy",
  "geographyRajHard",
  "historyRajEasy",
  "historyRajHard",
  "artAndCultureRaj",
  "economyRajHard",
  "economyRajEasy",
  "patwariMisc"
];

List<String> grade2ndSubjects = [
  "teachingApt",
  "currentAffairsIndiaEasy",
  "currentAffairsRajHard",
  "currentAffairsRajEasy",
  "currentAffairsWorldEasy",
  "geographyIndEasy",
  "polityIndEasy",
  "economyIndGen"
      "economyIndBudgetAndSchemes"
      "historyIndEasy",
  "generalScience",
  "geographyRajEasy",
  "geographyRajHard",
  "historyRajEasy",
  "historyRajHard",
  "artAndCultureRaj",
  "economyRajHard",
  "economyRajEasy",
  "grade2ndMisc"
];

List<String> grade2ndScienceSubjects = [
  "bio",
  "physicsMains",
  "chemMains",
  "grade2ndScienceMisc"
];

List<String> grade2ndSSSubjects = [
  "staticGK"
      "geographyIndEasy",
  "geographyWorld",
  "polityIndEasy",
  "geographyIndHard",
  "polityIndHard",
  "economyIndGen",
  "historyIndEasy",
  "historyIndHard",
  "artAndCultureInd",
  "constitutionAndGovernance",
  "geographyRajHard",
  "historyRajHard",
  "artAndCultureRaj",
  "polityRajHard",
  "currentAffairsRajHard",
  "artAndCultureInd",
  "grade2ndSSMisc"
];

List<String> sscGDSubjects = [
  "rpcGKInd",
  "hindi",
  "rpcReasoning",
  "gdQuantApt",
  "sscGDMisc"
];

List<String> sscMTSSubjects = [
  "gdQuantApt",
  "rpcGKInd",
  "rpcReasoning",
  "englishLangAndComprehensionEasy",
  "sscMTSMisc"
];

List<String> rajPoliceConstSubjects = [
  "rpcGKInd",
  "rpcReasoning",
  "rpcGKRaj",
  "basicComputer",
  "rajPoliceConstMisc"
];

List<String> rajLDCSubjects = [
  "hindi",
  "reasoningEasy",
  "reasoningHard",
  "quantAptEasy",
  "currentAffairsIndiaEasy",
  "currentAffairsRajHard",
  "currentAffairsRajEasy",
  "currentAffairsWorldEasy",
  "englishLangAndComprehensionEasy",
  "basicComputer",
  "geographyIndEasy",
  "polityIndEasy",
  "economyIndGen"
      "economyIndBudgetAndSchemes"
      "historyIndEasy",
  "generalScience",
  "geographyRajEasy",
  "geographyRajHard",
  "historyRajEasy",
  "historyRajHard",
  "artAndCultureRaj",
  "economyRajHard",
  "economyRajEasy",
  "rajLDCMisc"
];

List<String> rrbGDSubjects = [
  "gdQuantApt",
  "rpcGKInd",
  "rpcReasoning",
  "rrbGDMisc"
];

List<String> subjectsSubjects = <String>[
  'Physics Hard',
  'Maths Hard',
  'Chemistry Hard',
  'Physics Medium',
  'Maths Medium',
  'Chemistry Medium',
  'Bio',
  'Reasoning Hard',
  'Reasoning Easy',
  'Current Affairs World',
  'Current Affairs India Easy',
  'Current Affairs India Hard',
  'Quantitive Aptitude Hard',
  'Quantitive Aptitude Easy',
  'English Language And Comprehension',
  'Basic Computer',
  'Economy And Banking',
  'geographyIndHard',
  'Geography India Easy',
  'Geography World',
  'Polity India Easy',
  'Polity India Hard',
  'Economy India General',
  'Economy India Budget And Schemes',
  'Environment And Ecology Easy',
  'Environment And Ecology Hard',
  'History India Easy',
  'History India Hard',
  'History World',
  'International Relation And Security',
  'Science And Technology Easy',
  'Science And Technology Hard',
  'General Science',
  'Geography Rajasthan Easy',
  'Geography Rajasthan Hard',
  'History Rajasthan Easy',
  'History Rajasthan Hard',
  'Art And Culture Rajasthan',
  'Polity Rajasthan Hard',
  'Polity Rajasthan Easy',
  'Current Affairs Rajasthan Hard',
  'Current Affairs Rajasthan Easy',
  'Art And Culture India',
  'Economy Rajasthan Hard',
  'Economy Rajasthan Easy',
  'Constitution And Governance',
  'Decision Making',
  'NDA Physics',
  'NDA History',
  'NDA Chemistry',
  'NDA Maths',
  'CDSMaths',
  'Current Events',
  'Data Analysis And Interpretation',
  'Financial Awareness',
  'Finance And Accounts',
  'Statistics',
  'None'
];

var examSubjectsRelation = {
  "ias": iasSubjects,
  "jee": jeeSubjects,
  "jeeMains": jeeMainsSubjects,
  "jeeAdv": jeeAdvSubjects,
  "neet": neetSubjects,
  "ras": rasSubjects,
  "nda": ndaSubjects,
  "cds": cdsSubjects,
  "ibpsPO": ibpsPOSubjects,
  "ibpsClerk": ibpsClerkSubjects,
  "sscCGL": sscCGLSubjects,
  "sscCHSL": sscCHSLSubjects,
  "ntpc": ntpcSubjects,
  "reet1": reet1Subjects,
  "reet2": reet2Subjects,
  "patwari": patwariSubjects,
  "grade2nd": grade2ndSubjects,
  "grade2ndScience": grade2ndScienceSubjects,
  "grade2ndSS": grade2ndSSSubjects,
  "sscGD": sscGDSubjects,
  "sscMTS": sscMTSSubjects,
  "rajPoliceConst": rajPoliceConstSubjects,
  "rajLDC": rajLDCSubjects,
  "rrbGD": rrbGDSubjects,
  "sipaper1": sipaper1Subjects,
  "sipaper2": sipaper2Subjects
};

var examValues = {
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

var dropDownValues = {
  "ias": "iasMisc",
  "jee": "jeeMisc",
  "jeeMains": "jeeMainsMisc",
  "jeeAdv": "jeeAdvMisc",
  "neet": "neetMisc",
  "ras": "rasMisc",
  "ibpsPO": "ibpsPOMisc",
  "ibpsClerk": "ibpsClerkMisc",
  "sscCHSL": "sscCHSLMisc",
  "sscCGL": "sscCGLMisc",
  "nda": "ndaMisc",
  "cds": "cdsMisc",
  "ntpc": "ntpcMisc",
  "reet1": "reet1Misc",
  "reet2": "reet2Misc",
  "patwati": "patwatiMisc",
  "grade2nd": "grade2ndMisc",
  "grade2ndScience": "grade2ndScienceMisc",
  "grade2ndSS": "grade2ndSSMisc",
  "sscGD": "sscGDMisc",
  "sscMTS": "sscMTSMisc",
  "rajPoliceConst": "rajPoliceConstMisc",
  "rajLDC": "rajLDCMisc",
  "rrbGD": "rrbGDMisc",
  "sipaper1": "sipaper1Misc",
  "sipaper2": "sipaper2Misc",
};

Future<bool> addQuestion(String statement, List<String> options, String subject,
    List<String> correctOptions) async {
  String content = "";

  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token') ?? "Error";

  if (token == "Error") return false;

  String url = await rootBundle.loadString('assets/text/url.txt');

  for (String s in options) {
    content += ">>\$\$\$";
    content += s;
    content += "\$\$\$<< ";
  }

  print(' >> $content');

  for (String s in correctOptions) {
    content += s;
    content += " ";
  }

  print(content);

  final response = await http.post(
    Uri.parse('$url/addQues/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token $token"
    },
    body: jsonEncode(<String, String>{
      'statement': statement,
      'subject': subject,
      'content': content
    }),
  );

  String json = jsonDecode(response.body);

  if (json == "Success!") return true;

  return false;
}

String dropdownValue = "";

// ignore: must_be_immutable
class AddQuestions extends StatefulWidget {
  AddQuestions(
      {Key? key,
      required this.data,
      required this.val,
      required this.quesStatement,
      required this.optionsData})
      : super(key: key);

  Config data;
  int val;
  String quesStatement;
  List<AddQuesModel> optionsData;

  @override
  _AddQuestionsState createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  List<AddQuesModel> sampleData = <AddQuesModel>[];

  @override
  void initState() {
    super.initState();

    dropdownValue = dropDownValues[examValues[widget.data.examname]] ?? "";

    for (var i = 0; i < widget.val; i++) {
      sampleData.add(AddQuesModel(widget.optionsData[i].isSelected,
          widget.optionsData[i].buttonText, widget.optionsData[i].text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Question",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                borderRadius: BorderRadius.circular(10),
                items: examSubjectsRelation[examValues[widget.data.examname]]
                    ?.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Center(
                            child: Text(value),
                          )));
                }).toList(),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Question cannot be empty.';
                }
                return null;
              },
              onChanged: (text) {
                widget.quesStatement = text;
              },
              initialValue: widget.quesStatement,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                helperText: "Question",
                labelText: 'Question',
                hintText: "Type your Question Here",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(width: 1, color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                fillColor: Colors.white,
                // filled: true,
                prefixIcon:
                    const Icon(Icons.add_box_outlined, color: Colors.grey),
                hoverColor: Colors.grey,
              ),
              autofocus: true,
              cursorColor: Colors.black,
            ),
          ),
          for (var i = 0; i < widget.val; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              child: SingleChildScrollView(
                  child: Row(
                children: [
                  InkWell(
                    highlightColor: Colors.red,
                    splashColor: Colors.blueAccent,
                    onTap: () {
                      setState(() {
                        sampleData[i].isSelected = !sampleData[i].isSelected;
                        widget.optionsData[i].isSelected =
                            sampleData[i].isSelected;
                      });
                    },
                    child: RadioItem(sampleData[i]),
                  ),
                  Flexible(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Option Field cannot be empty.';
                        }
                        return null;
                      },
                      initialValue: widget.optionsData[i].text,
                      onChanged: (text) {
                        widget.optionsData[i].text = text;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        helperText:
                            "Option ${widget.optionsData[i].buttonText} Statement",
                        labelText:
                            'Option ${widget.optionsData[i].buttonText} Statement',
                        hintText:
                            "Type Option ${widget.optionsData[i].buttonText} Here",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        hoverColor: Colors.grey,
                      ),
                      autofocus: true,
                      cursorColor: Colors.black,
                    ),
                  )
                ],
              )),
            ),
          Row(
            children: [
              const Text("Add more Options"),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddQuestions(
                                  data: widget.data,
                                  val: widget.val + 1,
                                  optionsData: widget.optionsData,
                                  quesStatement: widget.quesStatement,
                                )));
                  },
                  icon: const Icon(Icons.add)),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              List<String> correctOptions = <String>[];
              List<String> options = <String>[];

              for (var j = 0; j < widget.val; j++) {
                correctOptions
                    .add(widget.optionsData[j].isSelected ? 'T' : 'F');
              }

              for (var j = 0; j < widget.val; j++) {
                options.add(widget.optionsData[j].text);
              }

              bool isAdded = await addQuestion(
                  widget.quesStatement, options, dropdownValue, correctOptions);

              if (isAdded) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              data: widget.data,
                            )));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddQuestions(
                              data: widget.data,
                              val: widget.val + 1,
                              optionsData: widget.optionsData,
                              quesStatement: widget.quesStatement,
                            )));
              }
            },
            child: const Text('Submit', style: TextStyle(fontSize: 20)),
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

class RadioItem extends StatelessWidget {
  final AddQuesModel _item;
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
                      //fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}

















// var subjectValues = {
//   'Physics Hard': 'physicsAdv',
//   'Maths Hard': 'mathsAdv',
//   'Chemistry Hard': 'chemAdv',
//   'Physics Medium': 'physicsMains',
//   'Maths Medium': 'mathsMains',
//   'Chemistry Medium': 'chemMains',
//   'Bio': 'bio',
//   'Reasoning Hard': 'reasoningHard',
//   'Reasoning Easy': 'reasoningEasy',
//   'Current Affairs World Easy': 'currentAffairsWorldEasy',
//   'Current Affairs World Hard': 'currentAffairsWorldHard',
//   'Current Affairs India Easy': 'currentAffairsIndiaEasy',
//   'Current Affairs India Hard': 'currentAffairsIndiaHard',
//   'Quantitive Aptitude Hard': 'quantAptHard',
//   'Quantitive Aptitude Easy': 'quantAptEasy',
//   'English Language And Comprehension Easy': 'englishLangAndComprehensionEasy',
//   'English Language And Comprehension Hard': 'englishLangAndComprehensionHard',
//   'Basic Computer': 'basicComputer',
//   'Economy And Banking': 'economyAndBanking',
//   'geographyIndHard': 'geographyIndHard',
//   'Geography India Easy': 'geographyIndEasy',
//   'Geography World': 'geographyWorld',
//   'Polity India Easy': 'polityIndEasy',
//   'Polity India Hard': 'polityIndHard',
//   'Economy India General': 'economyIndGen',
//   'Economy India Budget And Schemes': 'economyIndBudgetAndSchemes',
//   'Environment And Ecology Easy': 'environmentAndEcologyEasy',
//   'Environment And Ecology Hard': 'environmentAndEcologyHard',
//   'History India Easy': 'historyIndEasy',
//   'History India Hard': 'historyIndHard',
//   'History World': 'historyWorld',
//   'International Relation And Security': 'InternationalRelationAndSecurity',
//   'Science And Technology Easy': 'sciAndTechEasy',
//   'Science And Technology Hard': 'sciAndTechHard',
//   'General Science': 'generalScience',
//   'Geography Rajasthan Easy': 'geographyRajEasy',
//   'Geography Rajasthan Hard': 'geographyRajHard',
//   'History Rajasthan Easy': 'historyRajEasy',
//   'History Rajasthan Hard': 'historyRajHard',
//   'Art And Culture Rajasthan': 'artAndCultureRaj',
//   'Polity Rajasthan Hard': 'polityRajHard',
//   'Polity Rajasthan Easy': 'polityRajEasy',
//   'Current Affairs Rajasthan Hard': 'currentAffairsRajHard',
//   'Current Affairs Rajasthan Easy': 'currentAffairsRajEasy',
//   'Art And Culture India': 'artAndCultureInd',
//   'Economy Rajasthan Hard': 'economyRajHard',
//   'Economy Rajasthan Easy': 'economyRajEasy',
//   'Constitution And Governance': 'constitutionAndGovernance',
//   'Decision Making': 'decisionMaking',
//   'NDA Physics': 'ndaPhysics',
//   'NDA History': 'ndaHistory',
//   'NDA Chemistry': 'ndaChemistry',
//   'NDA Maths': 'ndaMaths',
//   'CDSMaths': 'cdsMaths',
//   'Current Events': 'currentEvents',
//   'Data Analysis And Interpretation': 'dataAnalysisAndInterpretation',
//   'Financial Awareness': 'financialAwareness',
//   'Finance And Accounts': 'financeAndAccounts',
//   'Statistics': 'statistics',
//   'None': 'none'
// };