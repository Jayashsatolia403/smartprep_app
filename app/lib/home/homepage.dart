import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:app/register_login/login.dart';
import 'package:app/register_login/register.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: <Widget>[
              Image.asset("assets/images/logo8.png"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text('SignIn', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(100, 50),
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    alignment: Alignment.center
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('SignUp', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 50),
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    alignment: Alignment.center
                ),
              ),
            ],
          )
      ),
      backgroundColor: Colors.white,
    );
  }
}

// Image.asset("assets/images/logo.png"