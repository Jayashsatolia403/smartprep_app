import 'dart:convert';

import 'package:app/exam_select/select_exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app/config.dart';

Future<List<String>> loginUser(String email, String password) async {
  String url = await rootBundle.loadString('assets/text/url.txt');

  final response = await http.post(
    Uri.parse('$url/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'username': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> json = jsonDecode(response.body);

    String token = json['token'];

    prefs.setString('token', token);

    final getName =
        await http.get(Uri.parse('$url/get_name'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token $token"
    });

    final name = jsonDecode(getName.body);

    prefs.setString('name', name[0]);
    prefs.setString('email', name[1]);

    return <String>[name[0], name[1]];
  } else if (response.statusCode == 400) {
    return <String>["Error"];
  } else {
    return <String>["Unknown"];
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password1 = "";

    return Scaffold(
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
                      return 'Email cannot be empty.';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    email = text;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
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
                    filled: true,
                    prefixIcon: const Icon(Icons.email, color: Colors.grey),
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
                      return 'Password cannot be empty.';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    password1 = text;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
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
                    filled: true,
                    prefixIcon: const Icon(Icons.password, color: Colors.grey),
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
                      List<String> response = await loginUser(email, password1);
                      if (response[0] == "Error") {
                        final snackBar = SnackBar(
                          content: const Text('Incorrect Email or Password!'),
                          action: SnackBarAction(
                            label: 'Try Again',
                            onPressed: () {},
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (response[0] == "Invalid") {
                        final snackBar = SnackBar(
                          content: const Text('Invalid Information!'),
                          action: SnackBarAction(
                            label: 'Try Again',
                            onPressed: () {},
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectExam(
                                    data: Config(
                                        username: response[0],
                                        examname: "Exam",
                                        email: response[1]),
                                  )),
                        );
                      }
                    }
                  },
                  child: const Text('Submit', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 50),
                      primary: Colors.black,
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
