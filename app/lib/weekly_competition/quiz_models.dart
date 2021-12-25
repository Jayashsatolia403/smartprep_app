import 'package:intl/intl.dart';

const String tableOptions = 'options';
const String tableQuestions = 'questions';
const String tableDate = 'date';
const String tableQuestionOptions = 'question_options';

class OptionFields {
  static const List<String> values = [id, uuid, content];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String content = 'content';
}

class QuestionFields {
  static const List<String> values = [id, uuid, statement];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String statement = 'statement';
}

class DateField {
  static const List<String> values = [id, date];

  static const String id = '_id';
  static const String date = 'date';
}

class QuestionOptionsFields {
  static const List<String> values = [id, questionId, optionId];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String questionId = 'question_id';
  static const String optionId = 'option_id';
}

class Options {
  int? id;
  String uuid;
  String content;

  Options({this.id, required this.uuid, required this.content});

  Options copy({int? id, String? uuid, String? content}) => Options(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      content: content ?? this.content);

  static Options fromJson(Map<String, Object?> json) => Options(
      id: json[OptionFields.id] as int?,
      uuid: json[OptionFields.uuid] as String,
      content: json[OptionFields.content] as String);

  Map<String, Object?> toJson() => {
        OptionFields.id: id,
        OptionFields.uuid: uuid,
        OptionFields.content: content
      };
}

class Questions {
  int? id;
  String uuid;
  String statement;

  Questions({this.id, required this.uuid, required this.statement});

  Questions copy({int? id, String? uuid, String? statement}) => Questions(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      statement: statement ?? this.statement);

  static Questions fromJson(Map<String, Object?> json) => Questions(
      id: json[QuestionFields.id] as int?,
      uuid: json[QuestionFields.uuid] as String,
      statement: json[QuestionFields.statement] as String);

  Map<String, Object?> toJson() => {
        QuestionFields.id: id,
        QuestionFields.uuid: uuid,
        QuestionFields.statement: statement
      };
}

class Date {
  int? id;
  DateTime date;

  Date({this.id, required this.date});

  Date copy({int? id, DateTime? date}) =>
      Date(id: id ?? this.id, date: date ?? this.date);

  static Date fromJson(Map<String, Object?> json) => Date(
      id: json[DateField.id] as int?,
      date: DateFormat("yyyy-MM-dd").parse(json['date'].toString()));

  Map<String, Object?> toJson() =>
      {DateField.id: id, DateField.date: date.toIso8601String()};
}

class QuestionOptions {
  int? id;
  String uuid;
  String questionId;
  String optionId;

  QuestionOptions(
      {this.id,
      required this.uuid,
      required this.questionId,
      required this.optionId});

  QuestionOptions copy(
          {int? id, String? uuid, String? questionId, String? optionId}) =>
      QuestionOptions(
          id: id ?? this.id,
          uuid: uuid ?? this.uuid,
          questionId: questionId ?? this.questionId,
          optionId: optionId ?? this.optionId);

  static QuestionOptions fromJson(Map<String, Object?> json) => QuestionOptions(
      id: json[QuestionOptionsFields.id] as int?,
      uuid: json[QuestionOptionsFields.uuid] as String,
      questionId: json[QuestionOptionsFields.questionId] as String,
      optionId: json[QuestionOptionsFields.optionId] as String);

  Map<String, Object?> toJson() => {
        QuestionOptionsFields.id: id,
        QuestionOptionsFields.uuid: uuid,
        QuestionOptionsFields.questionId: questionId,
        QuestionOptionsFields.optionId: optionId
      };
}