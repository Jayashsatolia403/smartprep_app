import 'dart:convert';

class Question {
  String statement = "Question";
  List<String> options = [];
  Question({required this.statement, required this.options});

  Question.fromJson(Map<String, dynamic> json)
      : statement = json['statement'],
        options = json['options'];

  Map<String, dynamic> toJson() => {'statement': statement, 'options': options};
}
