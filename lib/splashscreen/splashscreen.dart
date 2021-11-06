import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/home/home.dart';
import 'package:frontend/jee/jeeHomePage.dart';

import 'package:frontend/home/homepage.dart';

import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


// bool isAuthenticated = false;

Future<bool> checkAuth() async {

  final prefs = await SharedPreferences.getInstance();

  final counter = prefs.getString('token') ?? "isGood";

  final name = prefs.getString('name') ?? "Good";

  print("Showing Counter...");
  
  print(counter);
  print(name);

  if (counter != "isGood") {
    print("Working Fine!");
    return true;
  }

  return false;
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // COMPLETE: Check if user is Authenticated.
    
    Future<bool> _isAuth = checkAuth();

    return FutureBuilder<bool> (
      future: _isAuth,
      builder: (BuildContext context, AsyncSnapshot<bool> snapShot) {
        if (snapShot.hasData) {
          if (snapShot.data == true) return SplashScreen(
            seconds: 5,
            navigateAfterSeconds: new JeeHomePage(),
            image: new Image.asset('assets/images/logo12.png'),
            photoSize: 100.0,
            loaderColor: Colors.blue,
          );
          else return SplashScreen(
            seconds: 1,
            navigateAfterSeconds: new MyHomePage(),
            image: new Image.asset('assets/images/logo12.png'),
            photoSize: 100.0,
            loaderColor: Colors.blue,
          );
        }
        else {
          return Text("Going Good!");
        }
      }
    );
  }
}

