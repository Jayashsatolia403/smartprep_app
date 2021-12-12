import 'package:flutter/material.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bookmarks",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        foregroundColor: Colors.deepPurpleAccent,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(children: [
        
      ],),
    );
  }
}
