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

void main() {
  Map<String, dynamic> json = {
    "questions": [
      {
        "statement": "Ques 1",
        "options": ['A1', 'B2', 'C', 'D']
      },
      {
        'statement': 'Ques 2',
        'options': ['A', 'B', 'C', 'D']
      }
    ],
    'selectedOptions': [
      {'A', 'B'},
      {'C', 'A'}
    ]
  };

  WeeklyCompetitionQuiz quiz = WeeklyCompetitionQuiz.fromJson(json);

  print(quiz.questions[0].statement);
  print(quiz.questions[0].options);
  print(quiz.selectedOptions);
}