import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

String token = "";
String name = "";

const MaterialColor white = MaterialColor(

  0xEAF7F1F8,
  <int, Color>{
    50: Color(0xEAF7F1F8),
    100: Color(0xEAF7F1F8),
    200: Color(0xEAF7F1F8),
    300: Color(0xEAF7F1F8),
    400: Color(0xEAF7F1F8),
    500: Color(0xEAF7F1F8),
    600: Color(0xEAF7F1F8),
    700: Color(0xEAF7F1F8),
    800: Color(0xEAF7F1F8),
    900: Color(0xEAF7F1F8),
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
                  body: SafeArea(child: SingleChildScrollView(
                    child: Column(
                      children: [Text('Welcome $name', textAlign: TextAlign.center, )],
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
            return const Text("");
          }
        }
    );
  }
}