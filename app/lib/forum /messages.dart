import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var examNameValues = {
  'ias': 'IAS',
  'iasHindi': 'IAS Hindi Medium',
  'jee': 'JEE',
  'jeeMains': 'JEE MAINS',
  'jeeAdv': 'JEE ADV',
  'neet': 'NEET',
  'ras': 'RAS',
  'rasHindi': 'RAS Hindi Medium',
  'ibpsPO': 'IBPS PO',
  'ibpsClerk': 'IBPS CLERK',
  'sscCHSL': 'SSC CHSL',
  'sscCGL': 'SSC CGL',
  'sscCGLHindi': 'SSC CGL Hindi Medium',
  'ntpc': 'NTPC',
  'reet1': 'REET LEVEL 1',
  'reet2': 'REET LEVEL 2 Social Science',
  'reet2Science': 'REET LEVEL 2 Science',
  'patwari': 'PATWARI',
  'grade2nd': '2nd Grade Paper 1',
  'grade2ndScience': '2nd Grade Science',
  'grade2ndSS': '2nd Grade Social Science ',
  'sscGD': 'SSC GD',
  'sscMTS': 'SSC MTS',
  'rajPoliceConst': 'Rajasthan Police Constable',
  'rajLDC': 'Rajasthan LDC',
  'rrbGD': 'RRB GD',
  'sipaper1': 'SI Paper 1',
  'sipaper2': 'SI Paper 2'
};

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
  List<ChatMessage> messages = [];
  int currentPage = 1;
  String myName = "";

  final ScrollController _scrollController = ScrollController();
  final _textController = TextEditingController();

  bool loading = false, allLoaded = false;

  Future<bool> getMessages(String forumName) async {
    try {
      setState(() {
        loading = true;
      });
      String url = await rootBundle.loadString('assets/text/url.txt');

      final prefs = await SharedPreferences.getInstance();

      String token = prefs.getString("token") ?? "NA";

      String name = prefs.getString("name") ?? "NA";

      setState(() {
        myName = name;
      });

      final response = await http.get(
        Uri.parse(
            '$url/getAllForumMessages?forum=$forumName&page=$currentPage&page_size=10'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Token $token"
        },
      );

      final json = jsonDecode(utf8.decode(response.bodyBytes));

      if (json == "Done") {
        setState(() {
          allLoaded = true;
          loading = false;
        });

        return false;
      }

      List<ChatMessage> newMessages = [];

      for (var i in json) {
        ChatMessage cm = ChatMessage(
            messageContent: i['text'],
            side: i['side'],
            time: i['time'],
            sender: i['sender']);

        newMessages.add(cm);
      }

      for (var i in messages) {
        newMessages.add(i);
      }

      setState(() {
        messages = newMessages;
        currentPage++;
        loading = false;
      });

      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getMessages(widget.forumname);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels <=
              _scrollController.position.minScrollExtent &&
          !loading) {
        getMessages(widget.forumname);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String message = "";

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Center(
              child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${examNameValues[widget.forumname]} Forum',
              style: const TextStyle(color: Colors.white),
            ),
          )),
        ),
        body: Column(
          children: [
            if (messages.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: messages[index].side == "right"
                          ? const EdgeInsets.only(
                              left: 45, right: 14, top: 6, bottom: 6)
                          : const EdgeInsets.only(
                              left: 14, right: 45, top: 6, bottom: 6),
                      child: Align(
                        alignment: (messages[index].side == "left"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].side == "left"
                                ? Colors.grey.shade200
                                : Colors.blue[200]),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (messages.isEmpty)
              const Center(
                child: CircularProgressIndicator(),
              ),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
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
                            controller: _textController,
                            onChanged: (text) {
                              message = text;
                            },
                            decoration: const InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            _textController.clear();
                            sendMessage(message, widget.forumname);
                            setState(() {
                              messages.add(ChatMessage(
                                  messageContent: message,
                                  side: "right",
                                  time: DateFormat().format(DateTime.now()),
                                  sender: myName));
                              message = "";
                            });
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
  }
}
