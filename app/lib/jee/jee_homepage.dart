import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


String greet() {
  var now = DateTime.now();

  if (now.hour < 12) {
    return 'Good Morning';
  } else if (now.hour < 17) {
    return 'Good Afternoon';
  } else if (now.hour < 20) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}

Future<String> getName() async {
  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString('token') ?? "NotAuthorised";
  final name = prefs.getString('name') ?? "User";

  return name;
}



class JeeHomePage extends StatefulWidget {
  const JeeHomePage({Key? key}) : super(key: key);

  @override
  _JeeHomePageState createState() => _JeeHomePageState();
}

class _JeeHomePageState extends State<JeeHomePage> {
  String greetMessage = greet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.deepPurpleAccent,
                    title: Image.asset("assets/images/logo14.png", height:60),
                    toolbarHeight: 80,
                  ),
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
                  body: SafeArea(child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                            child: Text(
                                '$greetMessage User',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),),
                )
            )
        )
    );
  }
}
