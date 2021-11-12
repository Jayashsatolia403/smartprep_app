import 'package:app/exam_select/select_exam.dart';
import 'package:app/jee/jee_tests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app/jee/jee_tests.dart';

String username = "";

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

  final name = prefs.getString('name') ?? "User";

  username = name;

  return name;
}



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String greetMessage = greet();

  @override
  Widget build(BuildContext context) {
    Future<String> name = getName();


    return FutureBuilder<String>(
      future: name,
      builder: (BuildContext context, AsyncSnapshot<String> snapShot) {
        return Scaffold(
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
                  title: const Text('Choose Exam'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SelectExam())
                    );
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          body: SafeArea(child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    child: Column(
                      children: [
                        if (snapShot.hasData) Text(
                            '$greetMessage $username',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            )
                        )
                        else Text(
                            '$greetMessage User',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            )
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const JeeTests())
                          ),
                          child: const Text("Go to JEE Section"),
                          style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                        )
                      ],
                    )
                )
              ],
            ),
          ),),
        );
      }
    );

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
                            child: Column(
                              children: [
                                Text(
                                  '$greetMessage User',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  )
                              ),
                                ElevatedButton(
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const JeeTests())
                                    ),
                                    child: const Text("Go to JEE Section"),
                                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                                )
                              ],
                            )
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
