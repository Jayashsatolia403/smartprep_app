import 'package:intl/intl.dart';

const String tableOptions = 'options';
const String tableQuestions = 'questions';
const String tableDate = 'date';
const String tableQuestionOptions = 'question_options';

class OptionFields {
  static const List<String> values = [id, uuid, content, isSelected];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String content = 'content';
  static const String isSelected = 'isSelected';
}

class QuestionFields {
  static const List<String> values = [id, uuid, statement];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String statement = 'statement';
}

class DateField {
  static const List<String> values = [id, date, pages, competitionUuid];

  static const String id = '_id';
  static const String date = 'date';
  static const String pages = 'pages';
  static const String competitionUuid = 'competition_uuid';
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
  bool isSelected;

  Options(
      {this.id,
      required this.uuid,
      required this.content,
      required this.isSelected});

  Options copy({int? id, String? uuid, String? content, bool? isSelected}) =>
      Options(
          id: id ?? this.id,
          uuid: uuid ?? this.uuid,
          content: content ?? this.content,
          isSelected: isSelected ?? this.isSelected);

  static Options fromJson(Map<String, Object?> json) => Options(
      id: json[OptionFields.id] as int?,
      uuid: json[OptionFields.uuid] as String,
      content: json[OptionFields.content] as String,
      isSelected: json[OptionFields.isSelected] == 1);

  Map<String, Object?> toJson() => {
        OptionFields.id: id,
        OptionFields.uuid: uuid,
        OptionFields.content: content,
        OptionFields.isSelected: isSelected ? 1 : 0
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
  int pages;
  String competitionUuid;

  Date(
      {this.id,
      required this.date,
      required this.pages,
      required this.competitionUuid});

  Date copy({int? id, DateTime? date, int? pages, String? competitionUuid}) =>
      Date(
          id: id ?? this.id,
          date: date ?? this.date,
          pages: pages ?? this.pages,
          competitionUuid: competitionUuid ?? this.competitionUuid);

  static Date fromJson(Map<String, Object?> json) => Date(
      id: json[DateField.id] as int?,
      date: DateFormat("yyyy-MM-dd").parse(json[DateField.date].toString()),
      pages: json[DateField.pages] as int,
      competitionUuid: json[DateField.competitionUuid] as String);

  Map<String, Object?> toJson() => {
        DateField.id: id,
        DateField.date: date.toIso8601String(),
        DateField.pages: pages,
        DateField.competitionUuid: competitionUuid
      };
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
