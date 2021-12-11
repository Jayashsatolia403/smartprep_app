import 'package:app/exam_select/select_exam.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/home/home.dart';

import 'package:app/home/homepage.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

Future<List<String>> checkAuth() async {
  final prefs = await SharedPreferences.getInstance();

  String name = prefs.getString('name') ?? "User";
  String exam = prefs.getString('exam_name') ?? "Exam";
  String email = prefs.getString('email') ?? "email@email.com";

  return <String>[name, exam, email];
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // COMPLETE: Check if user is Authenticated.

    Future<List<String>> _isAuth = checkAuth();

    return FutureBuilder<List<String>>(
        future: _isAuth,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapShot) {
          if (snapShot.hasData) {
            if (snapShot.data?[0] != "User" && snapShot.data?[1] != "Exam") {
              return SplashScreen(
                seconds: 5,
                navigateAfterSeconds: Home(
                  data: Config(
                      username: snapShot.data![0],
                      examname: snapShot.data![1],
                      email: snapShot.data![2]),
                ),
                image: Image.asset('assets/images/logo6.png'),
                photoSize: 100.0,
                loaderColor: Colors.blue,
              );
            } else if (snapShot.data?[0] != "User") {
              return SplashScreen(
                seconds: 5,
                navigateAfterSeconds: SelectExam(
                    data: Config(
                        username: snapShot.data![0],
                        examname: snapShot.data![1],
                        email: snapShot.data![2])),
                image: Image.asset('assets/images/logo6.png'),
                photoSize: 100.0,
                loaderColor: Colors.blue,
              );
            } else {
              return SplashScreen(
                seconds: 5,
                navigateAfterSeconds: const MyHomePage(),
                image: Image.asset('assets/images/logo6.png'),
                photoSize: 100.0,
                loaderColor: Colors.blue,
              );
            }
          } else {
            return SplashScreen(
              seconds: 5,
              navigateAfterSeconds: const MyHomePage(),
              image: Image.asset('assets/images/logo6.png'),
              photoSize: 100.0,
              loaderColor: Colors.blue,
            );
          }
        });
  }
}
