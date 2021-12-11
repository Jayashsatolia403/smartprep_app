import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config.dart';

String subsType = "Free";

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.data}) : super(key: key);

  final Config data;

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text(
                widget.data.username,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text(
                widget.data.examname,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        toolbarHeight: 90,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Text(
              "Profile Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(widget.data.username),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: Text(widget.data.examname),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(widget.data.email),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: Text('Subscription: $subsType'),
          )
        ],
      ),
    );
  }
}
