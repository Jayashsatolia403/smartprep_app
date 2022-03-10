import 'dart:convert';
import 'package:app/feedback_complaint/thanks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GiveFeedback extends StatefulWidget {
  const GiveFeedback({Key? key}) : super(key: key);

  @override
  _GiveFeedbackState createState() => _GiveFeedbackState();
}

class _GiveFeedbackState extends State<GiveFeedback> {
  final _formKey = GlobalKey<FormState>();

  String subject = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Subject Field cannot be empty.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    subject = value;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    helperText: "Type Subject Here",
                    labelText: 'Subject',
                    hintText: "Type Subject Here",
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
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Text Field cannot be empty.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    text = value;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    helperText: "Type Statement Here",
                    labelText: 'Statement',
                    hintText: "Type Statement Here",
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 130),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var data = {"subject": subject, "text": "text"};

                      final prefs = await SharedPreferences.getInstance();

                      String token = prefs.getString('token') ?? "Error";

                      String url =
                          await rootBundle.loadString('assets/text/url.txt');

                      await http.post(
                        Uri.parse('$url/give_feedback/'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Authorization': "Token $token"
                        },
                        body: jsonEncode(data),
                      );

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Thanks(),
                          ));
                    }
                  },
                  child: const Text('Submit', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 50),
                      primary: Colors.deepPurple,
                      onPrimary: Colors.white,
                      alignment: Alignment.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
