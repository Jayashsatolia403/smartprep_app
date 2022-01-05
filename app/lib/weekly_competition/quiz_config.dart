import 'dart:convert';

class Question {
  String statement = "Question";
  String uuid = "uuid";
  List<String> options = [];
  Question(
      {required this.statement, required this.options, required this.uuid});

  Question.fromJson(Map<String, dynamic> json)
      : statement = json['statement'],
        options = json['options'],
        uuid = json['uuid'];

  Map<String, dynamic> toJson() =>
      {'statement': statement, 'options': options, 'uuid': uuid};
}
