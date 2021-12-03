// import 'package:app/exam_select/select_exam.dart';
// import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// String username = "";

// Future<String> getName() async {
//   final prefs = await SharedPreferences.getInstance();

//   final name = prefs.getString('name') ?? "User";

//   username = name;

//   return name;
// }

// class SlideScreen extends StatefulWidget {
//   const SlideScreen({Key? key}) : super(key: key);

//   @override
//   _SlideScreenState createState() => _SlideScreenState();
// }

// class _SlideScreenState extends State<SlideScreen> {
//   final Future<String> _getName = getName();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         FutureBuilder<String>(
//             future: _getName,
//             builder: (BuildContext context, AsyncSnapshot<String> snapShot) {})
//       ],
//     ));
//   }
// }
