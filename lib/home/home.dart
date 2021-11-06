import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:backdrop/backdrop.dart';

String token = "";
String name = "";

const MaterialColor white = const MaterialColor(

  0xEAF7F1F8,
  const <int, Color>{
    50: const Color(0xEAF7F1F8),
    100: const Color(0xEAF7F1F8),
    200: const Color(0xEAF7F1F8),
    300: const Color(0xEAF7F1F8),
    400: const Color(0xEAF7F1F8),
    500: const Color(0xEAF7F1F8),
    600: const Color(0xEAF7F1F8),
    700: const Color(0xEAF7F1F8),
    800: const Color(0xEAF7F1F8),
    900: const Color(0xEAF7F1F8),
  },
);


Future<String> getName() async {
  final prefs = await SharedPreferences.getInstance();

  token = prefs.getString('token') as String;
  name = prefs.getString('name') as String;

  return name;
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Future<String> _name = getName();
    return FutureBuilder<String> (
      future: _name,
      builder: (BuildContext context, AsyncSnapshot<String> snapShot) {
        if (snapShot.hasData) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: white,
                title: Image.asset('assets/images/logo9.png', height: 190),
              ),
              body: SafeArea(child: Container(
                child: new SingleChildScrollView(
                  child: Column(
                    children: [Text('Welcome $name', textAlign: TextAlign.center, )],
                  ),
                ),
              ),),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Text('SmartPrep'),
                    ),
                    ListTile(
                      title: const Text('Item 1'),
                      onTap: () {},
                    ),
                    ListTile(
                      title: const Text('Item 2'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            )
          );
        }
        else {
          return Text("");
        }
      }
    );
  }
}