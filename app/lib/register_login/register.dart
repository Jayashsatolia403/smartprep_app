import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app/home/home.dart';


Future<String> registerUser(String name, String email, String password, String password2) async {
  String ip = await rootBundle.loadString('assets/text/ip.txt');

  // print(name);
  // print(email);
  // print(password);
  // print(password2);

  final response = await http.post(
    Uri.parse('http://$ip:8000/register/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
      'password2': password2
    }),
  );


  if (response.statusCode == 200) {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> json = jsonDecode(response.body);

    print(json);

    prefs.setString('token', json['token']);
    prefs.setString('name', json['name']);

    return json['name'];
  }
  else if (response.statusCode == 400) {
    return "Error";
  }
  else {
    return "Error";
  }
}



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    String name = "";
    String email = "";
    String password1 = "";
    String password2 = "";

    return Scaffold(
      body: SingleChildScrollView(
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
                      return 'Name cannot be empty.';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    name = text;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Name',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(width: 1, color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hoverColor: Colors.grey,
                    prefixIcon: const Icon(Icons.person, color: Colors.grey),
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
                      borderSide: const BorderSide(width: 1, color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
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
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                      borderSide: const BorderSide(width: 1, color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
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
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm Password cannot be empty.';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    password2 = text;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(width: 1, color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
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
                      String response = await registerUser(name, email, password1, password2);
                      if (response == "Error") {
                        final snackBar = SnackBar(
                          content: const Text('Invalid Information!'),
                          action: SnackBarAction(
                            label: 'Try Again',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Home()),
                        );
                      }
                    }
                  },
                  child: const Text('Register', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 50),
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
    );
  }
}