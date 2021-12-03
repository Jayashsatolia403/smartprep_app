import 'package:app/exam_select/select_exam.dart';
import 'package:app/jee/jee_tests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String username = "User";
String exam_name = "";

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

  final exam = prefs.getString("exam_name");

  exam_name = exam!;

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
              title: Image.asset("assets/images/logo14.png", height: 60),
              toolbarHeight: 80,
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                      child: DrawerHeader(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(children: [
                          Text(username,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Your Profile",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17)),
                            onTap: () {},
                          )
                        ]),
                      ),
                      height: 150),
                  ListTile(
                    title: Text(exam_name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectExam()));
                    },
                    tileColor: Colors.deepPurpleAccent,
                  ),
                  ListTile(
                    title: const Text('Explore Premium',
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectExam()));
                    },
                    tileColor: Colors.deepPurpleAccent,
                    // leading: const Icon(Icons.),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        child: Column(
                          children: [
                            if (snapShot.hasData)
                              Text('$greetMessage $username',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ))
                            else
                              Text('$greetMessage User',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  )),
                            ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const JeeTests())),
                              child: const Text("Go to JEE Section"),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black)),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
