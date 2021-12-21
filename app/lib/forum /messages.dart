import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatMessage {
  String messageContent;
  String side;
  String time;
  String sender;

  ChatMessage(
      {required this.messageContent,
      required this.side,
      required this.time,
      required this.sender});
}

Future<List<ChatMessage>> getMessages(String forumName) async {
  List<ChatMessage> messages = [];

  String url = await rootBundle.loadString('assets/text/url.txt');

  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString("token") ?? "NA";

  final response = await http.get(
    Uri.parse('$url/getAllForumMessages?forum=$forumName'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token $token"
    },
  );

  List<dynamic> json = jsonDecode(response.body);

  for (var i in json) {
    ChatMessage cm = ChatMessage(
        messageContent: i['text'],
        side: i['side'],
        time: i['time'],
        sender: i['sender']);

    messages.add(cm);
  }

  return messages;
}

void sendMessage(String message, String forum) async {
  String url = await rootBundle.loadString('assets/text/url.txt');

  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString("token") ?? "NA";

  await http.post(
    Uri.parse('$url/sendForumMessage/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token $token"
    },
    body: jsonEncode(<String, String>{
      'text': message,
      'forum': forum,
    }),
  );
}

class Messages extends StatefulWidget {
  const Messages({Key? key, required this.forumname}) : super(key: key);

  final String forumname;

  @override
  MessagesState createState() => MessagesState();
}

class MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    final Future<List<ChatMessage>> _getMessages =
        getMessages(widget.forumname);

    String message = "";

    final ScrollController _scrollController =
        ScrollController(initialScrollOffset: 9999999);

    return FutureBuilder<List<ChatMessage>>(
        future: _getMessages,
        builder:
            (BuildContext context, AsyncSnapshot<List<ChatMessage>> snapShot) {
          if (snapShot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Center(child: Text(widget.forumname)),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: snapShot.data!.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: snapShot.data![index].side == "right"
                                ? const EdgeInsets.only(
                                    left: 45, right: 14, top: 6, bottom: 6)
                                : const EdgeInsets.only(
                                    left: 14, right: 45, top: 6, bottom: 6),
                            child: Align(
                              alignment: (snapShot.data![index].side == "left"
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (snapShot.data![index].side == "left"
                                      ? Colors.grey.shade200
                                      : Colors.blue[200]),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  snapShot.data![index].messageContent,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 10, top: 10),
                            height: 60,
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextField(
                                    onChanged: (text) {
                                      message = text;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Write message...",
                                        hintStyle:
                                            TextStyle(color: Colors.black54),
                                        border: InputBorder.none),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    sendMessage(message, widget.forumname);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Messages(
                                                forumname: widget.forumname)));
                                  },
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  backgroundColor: Colors.blue,
                                  elevation: 0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ));
          } else {
            return const Center(
                child: Text(
              "Problems",
              style: TextStyle(fontSize: 25),
            ));
          }
        });
  }
}
