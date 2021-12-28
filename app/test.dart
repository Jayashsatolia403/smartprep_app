import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  final response = await http.get(
    Uri.parse(
        'http://192.168.1.8:8000/get_todays_contest?exam=ias&page=1&page_size=10'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': "Token e99980a395335afe4ff8906b3d07d68adb749875"
    },
  );

  final resJson = await jsonDecode(response.body);

  for (var x in resJson['questions']) {
    print("\n");
    print(x);
  }
}
