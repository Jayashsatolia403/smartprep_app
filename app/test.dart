import 'package:http/http.dart' as http;

import 'dart:convert';

Future<bool> sendMessage(String message, String forum) async {
  String url = "http://127.0.0.1:8000/sendForumMessage/";

  String token = "28eb736ff593553acbe21c3ea5cc8a6b21a46a93";

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token $token"
    },
    body: jsonEncode(<String, String>{
      'text': "ggjgldflgjhfdfg",
      'forum': "ias",
    }),
  );

  print(jsonDecode(response.body));
  return true;
}

void main() {
  sendMessage("Hello Guys!", "ias");
}
