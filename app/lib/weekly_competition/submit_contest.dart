// () async {
//                             try {
//                               showVideoAd();
//                             } catch (error) {
//                               print(error);
//                             }
//                             String url = await rootBundle
//                                 .loadString('assets/text/url.txt');

//                             final prefs = await SharedPreferences.getInstance();
//                             String? token = prefs.getString("token");
//                             String examName =
//                                 prefs.getString("exam_name") ?? "Exam";

//                             List<List<String>> submitOptions = [];

//                             for (var i = 0;
//                                 i < (totalPages[examName] ?? 100) * 10;
//                                 i++) {
//                               submitOptions.add([]);
//                             }
//                             int count = 0;
//                             final dbQuestions =
//                                 await QuizDatabase.instance.readAllQuestions();

//                             for (var dbQuestion in dbQuestions) {
//                               final getDbQuestionOptions = await QuizDatabase
//                                   .instance
//                                   .readQuestionOptionsFromQuestionId(
//                                       dbQuestion.uuid);

//                               for (var j in getDbQuestionOptions) {
//                                 final getDbOption = await QuizDatabase.instance
//                                     .readOptions(j.optionId);

//                                 if (getDbOption.isSelected) {
//                                   submitOptions[count].add(getDbOption.uuid);
//                                 }
//                               }

//                               count += 1;
//                             }

//                             var data = {
//                               "uuid": competitionUuid,
//                               "options": submitOptions
//                             };

//                             final response = await http.post(
//                                 Uri.parse('$url/submit_contest/'),
//                                 headers: <String, String>{
//                                   'Content-Type':
//                                       'application/json; charset=UTF-8',
//                                   'Authorization': "Token $token"
//                                 },
//                                 body: jsonEncode(
//                                     {"data": jsonEncode(data).toString()}));

//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Result(
//                                       correctOptions: jsonDecode(
//                                               response.body)["correct_options"]
//                                           .toString())),
//                             );
//                           },