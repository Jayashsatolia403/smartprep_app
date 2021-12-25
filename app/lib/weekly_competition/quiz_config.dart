import 'dart:convert';

class Question {
  String statement = "Question";
  List<List<String>> options = [];
  Question({required this.statement, required this.options});

  Question.fromJson(Map<String, dynamic> json)
      : statement = json['statement'],
        options = json['options'];

  Map<String, dynamic> toJson() => {'statement': statement, 'options': options};
}

List<Question> getQuestions(Map<String, dynamic> json) {
  List<Question> jsonQuestions = [];

  for (var jsonQuestion in json['questions']) {
    jsonQuestions.add(Question.fromJson(jsonQuestion));
  }

  return jsonQuestions;
}

class WeeklyCompetitionQuiz {
  List<Question> questions = [];
  List<Set<String>> selectedOptions = [];
  WeeklyCompetitionQuiz(
      {required this.questions, required this.selectedOptions});

  WeeklyCompetitionQuiz.fromJson(Map<String, dynamic> json)
      : questions = getQuestions(json),
        selectedOptions = json['selectedOptions'];

  Map<String, dynamic> toJson() {
    List<dynamic> jsonQuestions = [];

    for (var question in questions) {
      jsonQuestions.add(question.toJson());
    }

    return {'questions': jsonQuestions, 'selectedOptions': selectedOptions};
  }
}
