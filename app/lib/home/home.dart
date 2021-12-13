import 'package:app/add_ques/add_ques.dart';
import 'package:app/bookmarks/bookmarks.dart';
import 'package:app/exam_select/select_exam.dart';
import 'package:app/test_page/tests.dart';
import 'package:app/premium/premium.dart';
import 'package:app/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/config.dart';

List<String> alphabets = <String>[
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

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

class Home extends StatefulWidget {
  const Home({Key? key, required this.data}) : super(key: key);
  final Config data;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String greetMessage = greet();

  @override
  Widget build(BuildContext context) {
    List<RadioModel> optionsData = <RadioModel>[];

    for (var i = 0; i < 26; i++) {
      optionsData.add(RadioModel(false, alphabets[i], ""));
    }

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
            // ignore: sized_box_for_whitespace
            Container(
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(children: [
                    Text(widget.data.username,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text("Your Profile",
                          style: TextStyle(color: Colors.black, fontSize: 17)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                      data: widget.data,
                                    )));
                      },
                    )
                  ]),
                ),
                height: 150),
            ListTile(
              title: Text(widget.data.examname,
                  style: const TextStyle(color: Colors.white, fontSize: 17)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectExam(
                              data: widget.data,
                            )));
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
                        builder: (context) => Premium(
                              data: widget.data,
                            )));
              },
              tileColor: Colors.deepPurpleAccent,
              // leading: const Icon(Icons.),
            ),
            ListTile(
              title: const Text('Add Question',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddQuestions(
                              data: widget.data,
                              val: 2,
                              quesStatement: "",
                              optionsData: optionsData,
                            )));
              },
              tileColor: Colors.deepPurpleAccent,
              // leading: const Icon(Icons.),
            ),
            ListTile(
              title: const Text('Bookmarks',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Bookmarks(
                              data: widget.data,
                            )));
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    children: [
                      Text('$greetMessage ${widget.data.username}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          )),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tests(
                                      data: widget.data,
                                    ))),
                        child: Text("Go to ${widget.data.examname} Section"),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black)),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
