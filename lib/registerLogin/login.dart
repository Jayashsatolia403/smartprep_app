import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:frontend/home/home.dart';



Future<String> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.5:8000/login/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': email,
      'password': password
    }),
  );


  if (response.statusCode == 200) {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> json = jsonDecode(response.body);

    prefs.setString('token', json['token']);
    prefs.setString('name', json['name']);

    return json['name'];
  }
  else if (response.statusCode == 400) {
    return "Error";
  }
  else {
    return "Unknown";
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
      body: Container(
        child: new SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(width: 1, color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.email, color: Colors.grey),
                      hoverColor: Colors.grey,
                    ),
                    autofocus: true,
                    cursorColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(width: 1, color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.password, color: Colors.grey),
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
                        String response = await loginUser(email, password1);
                        if (response == "Error") {
                          final snackBar = SnackBar(
                            content: const Text('Incorrect Email or Password!'),
                            action: SnackBarAction(
                              label: 'Try Again',
                              onPressed: () {},
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else if (response == "Invalid") {
                          final snackBar = SnackBar(
                            content: const Text('Invalid Information!'),
                            action: SnackBarAction(
                              label: 'Try Again',
                              onPressed: () {},
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      }
                    },
                    child: const Text('Submit', style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(100, 50),
                        primary: Colors.black,
                        onPrimary: Colors.white,
                        alignment: Alignment.center
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}