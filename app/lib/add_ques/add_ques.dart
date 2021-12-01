import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

Future<bool> addQuestion(String statement, List<String> options, String subject,
    List<String> correctOptions) async {
  String content = "";

  String url = await rootBundle.loadString('assets/text/url.txt');

  for (String s in options) {
    content += ">>\$\$\$";
    content += s;
    content += "\$\$\$<< ";
  }

  for (String s in correctOptions) {
    content += s;
  }

  print(content);

  final response = await http.post(
    Uri.parse('$url/addQues/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token 0f3cce84ab32c90afbdf467297608ff9afee3847"
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

class AddQuestions extends StatefulWidget {
  const AddQuestions({Key? key}) : super(key: key);

  @override
  _AddQuestionsState createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  String statement = "";
  List<String> options = <String>[];
  List<bool> correctOptions = <bool>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Question")),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Statement cannot be empty.';
                }
                return null;
              },
              onChanged: (text) {
                statement = text;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                helperText: "Question Statement",
                labelText: 'Question Statement',
                hintText: "Type Question Statement Here",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(width: 1, color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
                fillColor: Colors.white,
                // filled: true,
                // prefixIcon: Icon(Icons.add_circle, color: Colors.grey),
                hoverColor: Colors.grey,
              ),
              autofocus: true,
              cursorColor: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Statement cannot be empty.';
                }
                return null;
              },
              onChanged: (text) {
                statement = text;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                helperText: "Question Statement",
                labelText: 'Question Statement',
                hintText: "Type Question Statement Here",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(width: 1, color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
                fillColor: Colors.white,
                // filled: true,
                // prefixIcon: Icon(Icons.add_circle, color: Colors.grey),
                hoverColor: Colors.grey,
              ),
              autofocus: true,
              cursorColor: Colors.black,
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //
          //   },
          // )
        ],
      ),
    );
  }
}
