// ignore: import_of_legacy_library_into_null_safe
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
  static const List<String> values = [id, uuid, statement, isAnswered];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String statement = 'statement';
  static const String isAnswered = 'is_answered';
}

class DateField {
  static const List<String> values = [
    id,
    date,
    competitionUuid,
    examName,
    firstIdx,
    submissionTime
  ];

  static const String id = '_id';
  static const String date = 'date';
  static const String competitionUuid = 'competition_uuid';
  static const String examName = 'exam_name';
  static const String firstIdx = 'first_idx';
  static const String submissionTime = 'submission_time';
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
  bool isAnswered;

  Questions(
      {this.id,
      required this.uuid,
      required this.statement,
      required this.isAnswered});

  Questions copy(
          {int? id, String? uuid, String? statement, bool? isAnswered}) =>
      Questions(
          id: id ?? this.id,
          uuid: uuid ?? this.uuid,
          statement: statement ?? this.statement,
          isAnswered: isAnswered ?? this.isAnswered);

  static Questions fromJson(Map<String, Object?> json) => Questions(
      id: json[QuestionFields.id] as int?,
      uuid: json[QuestionFields.uuid] as String,
      statement: json[QuestionFields.statement] as String,
      isAnswered: json[QuestionFields.isAnswered] == 1);

  Map<String, Object?> toJson() => {
        QuestionFields.id: id,
        QuestionFields.uuid: uuid,
        QuestionFields.statement: statement,
        QuestionFields.isAnswered: isAnswered ? 1 : 0
      };
}

class Date {
  int? id;
  DateTime date;
  String competitionUuid;
  String examName;
  int firstIdx;
  DateTime submissionTime;

  Date(
      {this.id,
      required this.date,
      required this.competitionUuid,
      required this.examName,
      required this.firstIdx,
      required this.submissionTime});

  Date copy(
          {int? id,
          DateTime? date,
          String? competitionUuid,
          String? examName,
          int? firstIdx,
          DateTime? submissionTime}) =>
      Date(
          id: id ?? this.id,
          date: date ?? this.date,
          competitionUuid: competitionUuid ?? this.competitionUuid,
          examName: examName ?? this.examName,
          firstIdx: firstIdx ?? this.firstIdx,
          submissionTime: submissionTime ?? this.submissionTime);

  static Date fromJson(Map<String, Object?> json) => Date(
      id: json[DateField.id] as int?,
      date: DateFormat("yyyy-MM-dd").parse(json[DateField.date].toString()),
      competitionUuid: json[DateField.competitionUuid] as String,
      examName: json[DateField.examName] as String,
      firstIdx: json[DateField.firstIdx] as int,
      submissionTime: DateFormat("yyyy-MM-dd HH:mm")
          .parse(json[DateField.submissionTime].toString()));

  Map<String, Object?> toJson() => {
        DateField.id: id,
        DateField.date: date.toIso8601String(),
        DateField.competitionUuid: competitionUuid,
        DateField.examName: examName,
        DateField.firstIdx: firstIdx,
        DateField.submissionTime:
            DateFormat("yyyy-MM-dd HH:mm").format(submissionTime)
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
