import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class ChatMessage {
  String messageContent;
  bool isMine;

  ChatMessage({required this.messageContent, required this.isMine});
}

Future<List<ChatMessage>> getMessages(String forumName) async {
  List<ChatMessage> messages;

  final response = await http.post(
    Uri.parse('$url/addQues/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token $token"
    },
    body: jsonEncode(<String, String>{
      'statement': statement,
      'subject': subject,
      'content': content
    }),
  );
  return messages;
}

class Messages extends StatefulWidget {
  const Messages({Key? key, required this.forumname}) : super(key: key);

  final String forumname;

  @override
  MessagesState createState() => MessagesState();
}

class MessagesState extends State<Messages> {
  List<String> list = ["a", "b", "c"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.forumname)),
        ),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Text(list[index]);
            }));
  }
}
