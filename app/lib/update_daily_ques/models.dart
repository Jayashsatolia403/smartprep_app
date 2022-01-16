import 'package:flutter/cupertino.dart';

const String tableOptions = 'options';
const String tableQuestions = 'questions';
const String tableQuestionOptions = 'question_options';
const String tableExtraDetails = 'exam_details';

class OptionFields {
  static const List<String> values = [id, uuid, content, isCorrect];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String content = 'content';
  static const String isCorrect = 'is_correct';
}

class QuestionFields {
  static const List<String> values = [
    id,
    uuid,
    statement,
    isRated,
    isBookmarked,
    explaintion,
    qualityRatings,
    difficultyRatings
  ];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String statement = 'statement';
  static const String isRated = 'is_rated';
  static const String isBookmarked = 'is_bookmarked';
  static const String explaintion = 'explaination';
  static const String qualityRatings = 'quality_ratings';
  static const String difficultyRatings = 'difficulty_ratings';
}

class QuestionOptionsFields {
  static const List<String> values = [id, questionId, optionId];

  static const String id = '_id';
  static const String questionId = 'question_id';
  static const String optionId = 'option_id';
}

class ExtraDetailsFields {
  static const List<String> values = [id, date, noOfQuestions, firstIdx, exam];

  static const String id = '_id';
  static const String date = 'date';
  static const String noOfQuestions = 'no_of_questions';
  static const String firstIdx = 'first_idx';
  static const String exam = 'exam';
}

class Options {
  int? id;
  String uuid;
  String content;
  bool isCorrect;

  Options(
      {this.id,
      required this.uuid,
      required this.content,
      required this.isCorrect});

  Options copy({int? id, String? uuid, String? content, bool? isCorrect}) =>
      Options(
          id: id ?? this.id,
          uuid: uuid ?? this.uuid,
          content: content ?? this.content,
          isCorrect: isCorrect ?? this.isCorrect);

  static Options fromJson(Map<String, Object?> json) => Options(
      id: json[OptionFields.id] as int?,
      uuid: json[OptionFields.uuid] as String,
      content: json[OptionFields.content] as String,
      isCorrect: json[OptionFields.isCorrect] == 1);

  Map<String, Object?> toJson() => {
        OptionFields.id: id,
        OptionFields.uuid: uuid,
        OptionFields.content: content,
        OptionFields.isCorrect: isCorrect ? 1 : 0
      };
}

class Questions {
  int? id;
  String uuid;
  String statement;
  bool isRated;
  bool isBookmarked;
  String explaination;
  String qualityRatings;
  String difficultyRatings;

  Questions(
      {this.id,
      required this.uuid,
      required this.statement,
      required this.isRated,
      required this.isBookmarked,
      required this.explaination,
      required this.qualityRatings,
      required this.difficultyRatings});

  Questions copy(
          {int? id,
          String? uuid,
          String? statement,
          String? date,
          bool? isRated,
          bool? isBookmarked,
          String? explaination,
          String? qualityRatings,
          String? difficultyRatings}) =>
      Questions(
          id: id ?? this.id,
          uuid: uuid ?? this.uuid,
          statement: statement ?? this.statement,
          isRated: isRated ?? this.isRated,
          isBookmarked: isBookmarked ?? this.isBookmarked,
          explaination: explaination ?? this.explaination,
          qualityRatings: qualityRatings ?? this.qualityRatings,
          difficultyRatings: difficultyRatings ?? this.difficultyRatings);

  static Questions fromJson(Map<String, Object?> json) => Questions(
      id: json[QuestionFields.id] as int?,
      uuid: json[QuestionFields.uuid] as String,
      statement: json[QuestionFields.statement] as String,
      isRated: json[QuestionFields.isRated] == 1,
      isBookmarked: json[QuestionFields.isBookmarked] == 1,
      explaination: json[QuestionFields.explaintion] as String,
      qualityRatings: json[QuestionFields.qualityRatings] as String,
      difficultyRatings: json[QuestionFields.difficultyRatings] as String);

  Map<String, Object?> toJson() => {
        QuestionFields.id: id,
        QuestionFields.uuid: uuid,
        QuestionFields.statement: statement,
        QuestionFields.isRated: isRated ? 1 : 0,
        QuestionFields.isBookmarked: isBookmarked ? 1 : 0,
        QuestionFields.explaintion: explaination,
        QuestionFields.qualityRatings: qualityRatings,
        QuestionFields.difficultyRatings: difficultyRatings
      };
}

class QuestionOptions {
  int? id;
  String questionId;
  String optionId;

  QuestionOptions({this.id, required this.questionId, required this.optionId});

  QuestionOptions copy(
          {int? id, String? uuid, String? questionId, String? optionId}) =>
      QuestionOptions(
          id: id ?? this.id,
          questionId: questionId ?? this.questionId,
          optionId: optionId ?? this.optionId);

  static QuestionOptions fromJson(Map<String, Object?> json) => QuestionOptions(
      id: json[QuestionOptionsFields.id] as int?,
      questionId: json[QuestionOptionsFields.questionId] as String,
      optionId: json[QuestionOptionsFields.optionId] as String);

  Map<String, Object?> toJson() => {
        QuestionOptionsFields.id: id,
        QuestionOptionsFields.questionId: questionId,
        QuestionOptionsFields.optionId: optionId
      };
}

class ExtraDetails {
  int? id;
  String date;
  int noOfQuestions;
  int firstIdx;
  String exam;

  ExtraDetails(
      {this.id,
      required this.date,
      required this.noOfQuestions,
      required this.firstIdx,
      required this.exam});

  ExtraDetails copy(
          {int? id,
          String? uuid,
          String? date,
          int? noOfQuestions,
          int? firstIdx,
          String? exam}) =>
      ExtraDetails(
          id: id ?? this.id,
          date: date ?? this.date,
          noOfQuestions: noOfQuestions ?? this.noOfQuestions,
          firstIdx: firstIdx ?? this.firstIdx,
          exam: exam ?? this.exam);

  static ExtraDetails fromJson(Map<String, Object?> json) => ExtraDetails(
      id: json[ExtraDetailsFields.id] as int?,
      date: json[ExtraDetailsFields.date] as String,
      noOfQuestions: json[ExtraDetailsFields.noOfQuestions] as int,
      firstIdx: json[ExtraDetailsFields.firstIdx] as int,
      exam: json[ExtraDetailsFields.exam] as String);

  Map<String, Object?> toJson() => {
        ExtraDetailsFields.id: id,
        ExtraDetailsFields.date: date,
        ExtraDetailsFields.noOfQuestions: noOfQuestions,
        ExtraDetailsFields.firstIdx: firstIdx,
        ExtraDetailsFields.exam: exam
      };
}
