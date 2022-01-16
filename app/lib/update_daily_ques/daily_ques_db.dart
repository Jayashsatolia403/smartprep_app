import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models.dart';

String databaseFilePath = "";

class DailyQuesDatabase {
  static final DailyQuesDatabase instance = DailyQuesDatabase._init();

  Database? _database;

  DailyQuesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('dailyQuesDb.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    databaseFilePath = path;

    print(databaseFilePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    // ignore: unused_local_variable
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
  CREATE TABLE $tableOptions (
    ${OptionFields.id} $idType,
    ${OptionFields.uuid} $textType,
    ${OptionFields.content} $textType,
    ${OptionFields.isCorrect} $boolType
    )
''');

    await db.execute('''
  CREATE TABLE $tableQuestions (
    ${QuestionFields.id} $idType,
    ${QuestionFields.uuid} $textType,
    ${QuestionFields.statement} $textType,
    ${QuestionFields.isRated} $boolType,
    ${QuestionFields.isBookmarked} $boolType,
    ${QuestionFields.explaintion} $textType,
    ${QuestionFields.qualityRatings} $textType,
    ${QuestionFields.difficultyRatings} $textType
    )
''');

    await db.execute('''
  CREATE TABLE $tableQuestionOptions ( 
    ${QuestionOptionsFields.id} $idType, 
    ${QuestionOptionsFields.questionId} $textType,
    ${QuestionOptionsFields.optionId} $textType
    )
''');

    await db.execute('''
  CREATE TABLE $tableExtraDetails ( 
    ${ExtraDetailsFields.id} $idType, 
    ${ExtraDetailsFields.date} $textType,
    ${ExtraDetailsFields.noOfQuestions} $intType,
    ${ExtraDetailsFields.firstIdx} $intType,
    ${ExtraDetailsFields.exam} $textType
    )
''');
  }

  Future<Options> createOption(Options option) async {
    final db = await instance.database;

    final id = await db.insert(tableOptions, option.toJson());
    return option.copy(id: id);
  }

  Future<Questions> createQuestion(Questions question) async {
    final db = await instance.database;

    print(question.toJson());

    final id = await db.insert(tableQuestions, question.toJson());
    return question.copy(id: id);
  }

  Future<QuestionOptions> createQuestionOptions(QuestionOptions qoption) async {
    final db = await instance.database;

    final id = await db.insert(tableQuestionOptions, qoption.toJson());
    return qoption.copy(id: id);
  }

  Future<ExtraDetails> createExtraDetails(ExtraDetails extraDetails) async {
    final db = await instance.database;

    final id = await db.insert(tableExtraDetails, extraDetails.toJson());
    return extraDetails.copy(id: id);
  }

  Future<Options> readOptions(String uuid) async {
    final db = await instance.database;

    final maps = await db.query(
      tableOptions,
      columns: OptionFields.values,
      where: '${OptionFields.uuid} = ?',
      whereArgs: [uuid],
    );

    if (maps.isNotEmpty) {
      return Options.fromJson(maps.first);
    } else {
      return Options(
          content: 'Invalid', uuid: "Invalid", id: 0, isCorrect: false);
    }
  }

  Future<Questions> readQuestionsByUUid(String uuid) async {
    final db = await instance.database;

    final maps = await db.query(
      tableQuestions,
      columns: QuestionFields.values,
      where: '${QuestionFields.uuid} = ?',
      whereArgs: [uuid],
    );

    if (maps.isNotEmpty) {
      return Questions.fromJson(maps.first);
    } else {
      return Questions(
          statement: 'Invalid',
          uuid: "Invalid",
          id: 0,
          isRated: true,
          isBookmarked: false,
          explaination: '',
          difficultyRatings: '',
          qualityRatings: '');
    }
  }

  Future<Questions> readQuestionsById(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableQuestions,
      columns: QuestionFields.values,
      where: '${QuestionFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Questions.fromJson(maps.first);
    } else {
      return Questions(
          statement: 'Invalid',
          uuid: "Invalid",
          id: 0,
          isRated: true,
          isBookmarked: false,
          explaination: '',
          difficultyRatings: '',
          qualityRatings: '');
    }
  }

  Future<QuestionOptions> readQuestionOptions(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableQuestionOptions,
      columns: QuestionOptionsFields.values,
      where: '${QuestionOptionsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return QuestionOptions.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<ExtraDetails> readExtraDetails(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableExtraDetails,
      columns: ExtraDetailsFields.values,
      where: '${ExtraDetailsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ExtraDetails.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<QuestionOptions>> readQuestionOptionsFromQuestionId(
      String questionId) async {
    final db = await instance.database;

    final maps = await db.query(
      tableQuestionOptions,
      columns: QuestionOptionsFields.values,
      where: '${QuestionOptionsFields.questionId} = ?',
      whereArgs: [questionId],
    );

    if (maps.isNotEmpty) {
      return maps.map((json) => QuestionOptions.fromJson(json)).toList();
    } else {
      throw Exception('ID $questionId not found');
    }
  }

  Future<List<Options>> readAllOptions() async {
    final db = await instance.database;

    final result = await db.query(tableOptions);

    return result.map((json) => Options.fromJson(json)).toList();
  }

  Future<List<Questions>> readAllQuestions() async {
    final db = await instance.database;

    final result = await db.query(tableQuestions);

    return result.map((json) => Questions.fromJson(json)).toList();
  }

  Future<List<QuestionOptions>> readAllQuestionOptions() async {
    final db = await instance.database;

    final result = await db.query(tableQuestionOptions);

    return result.map((json) => QuestionOptions.fromJson(json)).toList();
  }

  Future<List<ExtraDetails>> readAllExtraDetails() async {
    final db = await instance.database;

    final result = await db.query(tableExtraDetails);

    return result.map((json) => ExtraDetails.fromJson(json)).toList();
  }

  Future<int> updateOption(Options option) async {
    final db = await instance.database;

    return db.update(
      tableOptions,
      option.toJson(),
      where: '${OptionFields.id} = ?',
      whereArgs: [option.id],
    );
  }

  Future<int> updateQuestion(Questions question) async {
    final db = await instance.database;

    return db.update(
      tableQuestions,
      question.toJson(),
      where: '${QuestionFields.id} = ?',
      whereArgs: [question.id],
    );
  }

  Future<int> updateQuestionOptions(QuestionOptions qoption) async {
    final db = await instance.database;

    return db.update(
      tableQuestionOptions,
      qoption.toJson(),
      where: '${QuestionOptionsFields.id} = ?',
      whereArgs: [qoption.id],
    );
  }

  Future<int> updateExtraDetails(ExtraDetails extraDetails) async {
    final db = await instance.database;

    return db.update(
      tableExtraDetails,
      extraDetails.toJson(),
      where: '${ExtraDetailsFields.id} = ?',
      whereArgs: [extraDetails.id],
    );
  }

  Future<int> deleteOption(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableOptions,
      where: '${OptionFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteQuestion(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableQuestions,
      where: '${QuestionFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteQuestionOptions(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableQuestionOptions,
      where: '${QuestionOptionsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteExtraDetails(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableExtraDetails,
      where: '${ExtraDetailsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllOptions() async {
    final db = await instance.database;

    return await db.delete(
      tableOptions,
    );
  }

  Future<int> deleteAllQuestions() async {
    final db = await instance.database;

    return await db.delete(
      tableQuestions,
    );
  }

  Future<int> deleteAllQuestionOptions() async {
    final db = await instance.database;

    return await db.delete(
      tableQuestionOptions,
    );
  }

  Future<int> deleteAllExtraDetails() async {
    final db = await instance.database;

    return await db.delete(
      tableExtraDetails,
    );
  }

  Future<bool> deleteEverything() async {
    try {
      await deleteAllOptions();
      await deleteAllQuestions();
      await deleteAllQuestionOptions();
      await deleteAllExtraDetails();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<void> deleteDatabase() =>
      databaseFactory.deleteDatabase(databaseFilePath);
}
