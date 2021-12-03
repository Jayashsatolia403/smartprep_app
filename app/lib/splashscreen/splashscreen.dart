import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/home/home.dart';

import 'package:app/home/homepage.dart';

import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// bool isAuthenticated = false;

Future<bool> checkAuth() async {
  final prefs = await SharedPreferences.getInstance();

  final counter = prefs.getString('token') ?? "isGood";

  // final name = prefs.getString('name') ?? "Good";

  if (counter != "isGood") {
    return true;
  }

  return false;
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // COMPLETE: Check if user is Authenticated.

    Future<bool> _isAuth = checkAuth();

    return FutureBuilder<bool>(
        future: _isAuth,
        builder: (BuildContext context, AsyncSnapshot<bool> snapShot) {
          if (snapShot.hasData) {
            if (snapShot.data == true) {
              return SplashScreen(
                seconds: 5,
                navigateAfterSeconds: const Home(),
                image: Image.asset('assets/images/logo6.png'),
                photoSize: 100.0,
                loaderColor: Colors.blue,
              );
            } else {
              return SplashScreen(
                seconds: 1,
                navigateAfterSeconds: MyHomePage(),
                image: Image.asset('assets/images/logo8.png'),
                photoSize: 100.0,
                loaderColor: Colors.blue,
              );
            }
          } else {
            return const Text("Going Good!");
          }
        });
  }
}
