from rest_framework.decorators import api_view
from rest_framework import status

from rest_framework.response import Response


@api_view(['GET', ])
def has_user_added_question_today(request):
    try:
        from datetime import date

        user = request.user
        date = date.today()

        if user.addedQuestionDate == date:
            return Response(True)
        else:
            return Response(False)


    except:
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)

























































# # Get Daily Question : Working

# @api_view(['GET', ])
# def getDailyQuestions(request):
#     try:
#         result = []
#         user = request.user
#         examTitle = request.GET['exam']
#         exam = Exams.objects.get(name = examTitle)

#         # Check if user is premium or not

#         if user.membershipOf30 and examTitle in user.premiumExams:
#             if examTitle == "jeeAdv":
#                 limit = 25
#             else:
#                 limit = 30
        
#         elif user.membershipOf50 and examTitle in user.premiumExams:
#             if examTitle == "jeeAdv":
#                 limit = 50
#             else:
#                 limit = 60
        
#         elif user.membershipOf100 and examTitle in user.premiumExams:
#             if examTitle == "jeeAdv":
#                 limit = 100
#             else:
#                 limit = 120
        
#         else:
#             if examTitle == "jeeAdv":
#                 limit = 3
#             elif examTitle == "jeeMains":
#                 limit = 7
#             else:
#                 limit = 10

#         date = datetime.today().strftime('%Y-%m-%d')


#         # COMPLETED: Check If Daily Questions are already assigned for particular User

#         availableDailyQuestions = DailyQuestions.objects.filter(user=user, date=date, exam=exam)

#         if len(availableDailyQuestions) != 0:
#             questions = availableDailyQuestions[0].questions.all()
            
#             for question in questions:
#                 result.append({"uuid": question.uuid, "statement": question.statement, 
#                         "ratings": question.ratings, "difficulty" : question.difficulty, 
#                         "options": [(z.content, z.isCorrect, z.uuid) for z in question.options.all()], 
#                         "percentCorrect": question.percentCorrect, "subject": question.subject, "isRated": request.user in question.ratedBy.all(),
#                         "createdBy": "Smartprep Team" if question.isExpert else question.createdBy.name, "explaination": question.explaination})


#             update_database_file()

#             return Response(result[:limit])
        
        


#         subjects = list(exam.subjects.all()) # Access all subject related to exam

#         addDailyQuestion = DailyQuestions(uuid = uuid.uuid4(), user = request.user, date = date, exam = exam) # Add new entry in Daily Questions Table
#         addDailyQuestion.save()

#         perSubjectLimit = limit//len(subjects) # Define Each Subject Limit to Serve Questions



#         random.shuffle(subjects) # Shuffle Subjects to avoid repeatetions
#         count = 1

#         break_limit = 0

#         while count <= limit:

#             if break_limit > 10000:
#                 break

#             for subject in subjects:
#                 try:
#                     questions = subject.questions.exclude(seenBy__id = user.id)[:perSubjectLimit if perSubjectLimit != 0 else 1]
#                 except:
#                     continue

#                 for question in questions:

#                     if count > limit: # Limit Questions
#                         break

#                     question.seenBy.add(request.user) # Marking as seen in Questions DB Table

#                     addDailyQuestion.questions.add(question)

#                     result.append({"uuid": question.uuid, "statement": question.statement, 
#                             "ratings": question.ratings, "difficulty" : question.difficulty, 
#                             "options": [(z.content, z.isCorrect, z.uuid) for z in question.options.all()], 
#                             "percentCorrect": question.percentCorrect, "subject": question.subject, "isRated": request.user in question.ratedBy.all(),
#                             "createdBy": "Smartprep Team" if question.isExpert else question.createdBy.name, "explaination": question.explaination}) 
                    
#                     count += 1

            
#         update_database_file()

#         return Response(result[:limit])

#     except Exception as e:
#         print(e)
#         return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)




# # Add Question : Working

# @api_view(['POST', ])
# def addQuestion(request):

#     try:
#         optionSerializer = AddOptionsSerializer(data=request.data)

#         if optionSerializer.is_valid():
#             options = optionSerializer.save()
#             questionSerializer = AddQuestionSerializer(data=request.data)
            
#             if questionSerializer.is_valid():
#                 question = questionSerializer.save()

#                 for i in options:
#                     question.options.add(i)
                
#                 question.createdBy = request.user

#                 question.subject = request.data['subject']

#                 subject = Subjects.objects.get(name=request.data['subject'])

#                 subject.questions.add(question)
#                 subject.save()
                
#                 question.save()

#                 from datetime import date
#                 user = request.user
#                 user.addedQuestionDate = date.today()
#                 user.save()

#         else:
#             print(optionSerializer.errors)

#         update_database_file()

#         return Response("Success!")
    
#     except Exception as e:
#         print(e)
#         return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



# # Get Question of The Day : Working

# @api_view(['GET', ])
# def getQuestionOfTheDay(request):
#     try:
#         exam_name = request.GET['exam']

#         dateToday = datetime.today().strftime('%Y-%m-%d')
        

#         exam = Exams.objects.get(name=exam_name)

#         try:
#             quesOfDay = QuestionsOfTheDays.objects.get(date = dateToday, exam=exam)
#             ques = quesOfDay.question

#             update_database_file()


#             return Response({"uuid": ques.uuid, "statement": ques.statement, 
#                         "options": [(z.content, z.isCorrect) for z in ques.options.all()], 
#                         "ratings": ques.ratings, "difficulty" : ques.difficulty, 
#                         "percentCorrect": ques.percentCorrect, "subject": ques.subject, "isRated": request.user in ques.ratedBy.all(),
#                         "createdBy": "Smartprep Team" if ques.isExpert else ques.createdBy.name, "explaination": ques.explaination})
#         except:
#             subjects = list(exam.subjects.all())

#             random.shuffle(subjects)

#             for subject in subjects:

#                 if not subject.questions.all():
#                     continue

#                 done = False

#                 for i in subject.questions.all():
#                     if (i.ratings > 4.7 and i.difficulty > 4.7) or i.isExpert:
#                         if not QuestionsOfTheDays.objects.filter(question=i):

#                             import uuid
                            
#                             quesOfDay = QuestionsOfTheDays(date = dateToday, uuid = str(uuid.uuid4()), exam=exam)
#                             quesOfDay.save()
#                             quesOfDay.question = i
#                             quesOfDay.save()

#                             done = True

#                             break

#                 if done:
#                     break

            
            
#             quesOfDay = QuestionsOfTheDays.objects.get(date = dateToday, exam=exam)

#             ques = quesOfDay.question

#             update_database_file()


#             return Response({"uuid": ques.uuid, "statement": ques.statement, 
#                         "options": [(z.content, z.isCorrect) for z in ques.options.all()], 
#                         "ratings": ques.ratings, "difficulty" : ques.difficulty, 
#                         "percentCorrect": ques.percentCorrect, "subject": subject.name, "isRated": request.user in ques.ratedBy.all(),
#                         "createdBy": "Smartprep Team" if ques.isExpert else ques.createdBy.name, "explaination": ques.explaination})
  
#     except Exception as e:
#         print(e)
#         return Response("Error", status=status.HTTP_400_BAD_REQUEST)



# # Rate Question on Basis of Quality and Difficulty : Working

# @api_view(['GET', ])
# def rateQuestion(request):
#     try:
#         questionId = request.GET['id']
#         difficulty = request.GET['difficulty']
#         ratings = request.GET['ratings']

#         question = Questions.objects.get(uuid = questionId)
#         question.ratedBy.add(request.user)
#         question.ratings = (question.ratings + float(ratings))/ (len(question.ratedBy.all())+1)
#         question.difficulty = (question.difficulty + float(difficulty))/ (len(question.ratedBy.all())+1)
#         question.save()

#         update_database_file()

#         return Response("Success!")
    
#     except Exception as e:
#         print(e)
#         return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



# # Get Questions by uuid

# @api_view(['GET', ])
# def getQuestionByID(request):

#     try:
#         quesID = request.GET['quesID']

#         ques = Questions.objects.get(uuid = quesID)

#         return Response({"uuid": ques.uuid, "statement": ques.statement, 
#                         "ratings": ques.ratings, "difficulty" : ques.difficulty, 
#                         "options": [(z.content, z.isCorrect, z.uuid) for z in ques.options.all()], 
#                         "percentCorrect": ques.percentCorrect, "subject": ques.subject, "explaination": ques.explaination})
    
#     except Exception as e:
#         print(e)
#         return Response("Invalid UUID", status=status.HTTP_400_BAD_REQUEST)



# @api_view(['GET', ])
# def bookmark_question(request):
#     try:
#         user = request.user
#         ques_id = request.GET['uuid']

#         question = Questions.objects.get(uuid=ques_id)

#         print(question)

#         question_bookmark = QuestionBookmarks.objects.filter(user=user)

#         if not question_bookmark:
#             question_bookmark = QuestionBookmarks(
#                 user=user
#             )

#             question_bookmark.save()
#         else:
#             question_bookmark = question_bookmark[0]

#         question_bookmark.questions.add(question)

#         question_bookmark.save()

#         update_database_file()

#         return Response("Success")


#     except Exception as e:
#         print(e)
#         return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)


# @api_view(['GET', ])
# def get_bookmarked_questions(request):
#     try:
#         user = request.user
#         page = request.GET['page']
#         page_size = request.GET['page_size']

#         bookmarked_questions = QuestionBookmarks.objects.filter(user=user)

#         if not bookmarked_questions:
#             bookmarked_questions = QuestionBookmarks(user = request.user)
#             bookmarked_questions.save()
#         else:
#             bookmarked_questions = bookmarked_questions[0]
        
#         bookmarked_questions = bookmarked_questions.questions.all().order_by('-id')

#         paginator = Paginator(bookmarked_questions, page_size)

#         update_database_file()

#         try:
#             result = paginator.page(page)
#         except InvalidPage:
#             return Response("Done", status=status.HTTP_404_NOT_FOUND)


#         return Response([{"uuid": question.uuid, "statement": question.statement, 
#                         "ratings": question.ratings, "difficulty" : question.difficulty, 
#                         "options": [(z.content, z.isCorrect) for z in question.options.all()], 
#                         "percentCorrect": question.percentCorrect, "subject": question.subject, 
#                         "isRated": request.user in question.ratedBy.all(), "explaination": question.explaination} for question in result])

#     except Exception as e:
#         print(e)
#         return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)




# # Adding Threaded function for hosting weekly competition for All Exams at the same time
# def hostWeeklyCompetition():

#     exam_questions = {
#         "ias": 100,
#         "iasHindi": 100,
#         "jee": 60,
#         "jeeMains": 90,
#         "jeeAdv": 54,
#         "neet": 180,
#         "ras": 150,
#         "rasHindi": 150,
#         "ibpsPO": 100,
#         "ibpsClerk": 100,
#         "sscCGL": 100,
#         "sscCGLHindi": 100,
#         "sscCHSL": 100,
#         "cat": 90,
#         "ntpc": 100,
#         "reet1": 150,
#         "reet2": 150,
#         "reet2Science": 150,
#         "patwari": 150,
#         "grade2nd": 100,
#         "grade2ndScience": 150,
#         "grade2ndSS": 150,
#         "sscGD": 100,
#         "sscMTS": 100,
#         "rajPoliceConst": 150,
#         "rajLDC": 150,
#         "rrbGD": 150,
#         "sipaper1": 100,
#         "sipaper2": 100
#     }

    
#     exams = Exams.objects.all()

#     for exam in exams:
#         import uuid

#         if exam.name not in exam_questions:
#             continue

#         round = WeeklyCompetitions.objects.filter(exam=exam)
#         if len(round) == 0:
#             round = 0
#         else:
#             round = round[len(round)-1]
#             round = int(round.round)


#         competition = WeeklyCompetitions(
#             uuid=str(uuid.uuid4()),
#             name="Smartprep {} Round #{}".format(str(exam.name), str(round+1)),
#             round=round+1,
#             exam=exam,
#         )

#         competition.save()


#         subjects = list(exam.subjects.all())


#         limit = exam_questions[exam.name] // len(subjects)

#         idx = 0
#         i = 0
#         limit = 0
#         x = 0

#         while i < exam_questions[exam.name]:

#             if x == len(subjects):
#                 x = 0

#             if len(subjects) == 0:
#                 break

#             if limit > 10000:
#                 print("Breaking due to limit exceeed at index :", i)
#                 break
#             else:
#                 limit += 1


#             if i >= len(subjects)*(idx+1):
#                 idx += 1


#             subject = subjects[x]

#             try:
#                 subject_questions = list(subject.questions.all())
#                 random.shuffle(subject_questions)
#                 question = subject_questions[idx]

#                 if question in competition.questions.all():
#                     continue
#             except:
#                 if (len(subjects) != 0):
#                     del subjects[x]
#                 else:
#                     break
#                 continue

            
#             competition.questions.add(question)

#             competition.save()

#             i += 1
#             x += 1
        
#         update_database_file()



# @api_view(['GET',])
# def host_weekly_competition(request):
#     try:
#         user = request.user

#         if not user or not user.is_superuser:
#             return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)

#         import threading

#         t = threading.Thread(target=hostWeeklyCompetition)
#         t.daemon = True
#         t.start()

#         return Response("Success")
    
#     except Exception as err:
#         print(err)
#         return Response('Invalid Request', status=status.HTTP_400_BAD_REQUEST)


# @api_view(['GET'])
# def host_weekly_competition_by_exam(request):
#     exam_questions = {
#         "ias": 100,
#         "iasHindi": 100,
#         "jee": 60,
#         "jeeMains": 90,
#         "jeeAdv": 54,
#         "neet": 180,
#         "ras": 150,
#         "rasHindi": 150,
#         "ibpsPO": 100,
#         "ibpsClerk": 100,
#         "sscCGL": 100,
#         "sscCGLHindi": 100,
#         "sscCHSL": 100,
#         "cat": 90,
#         "ntpc": 100,
#         "reet1": 150,
#         "reet2": 150,
#         "reet2Science": 150,
#         "patwari": 150,
#         "grade2nd": 100,
#         "grade2ndScience": 150,
#         "grade2ndSS": 150,
#         "sscGD": 100,
#         "sscMTS": 100,
#         "rajPoliceConst": 150,
#         "rajLDC": 150,
#         "rrbGD": 150,
#         "sipaper1": 100,
#         "sipaper2": 100
#     }


#     examname = request.GET['exam']

#     if examname not in exam_questions:
#         return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)

    
#     exam = Exams.objects.get(name=examname)

#     round = WeeklyCompetitions.objects.filter(exam=exam)

#     if len(round) == 0:
#         round = 0
#     else:
#         round = round[len(round)-1]
#         round = int(round.round)


#     competition = WeeklyCompetitions(
#         uuid=str(uuid.uuid4()),
#         name="Smartprep {} Round #{}".format(str(exam.name), str(round+1)),
#         round=round+1,
#         exam=exam,
#     )

#     competition.save()


#     subjects = list(exam.subjects.all())


#     limit = exam_questions[exam.name] // len(subjects)

#     idx = 0
#     i = 0
#     limit = 0
#     x = 0

#     while i < exam_questions[exam.name]:

#         if x == len(subjects):
#             x = 0

#         if len(subjects) == 0:
#             break

#         if limit > 10000:
#             print("Breaking due to limit exceeed at index :", i)
#             break
#         else:
#             limit += 1


#         if i >= len(subjects)*(idx+1):
#             idx += 1


#         subject = subjects[x]

#         try:
#             subject_questions = list(subject.questions.all())
#             random.shuffle(subject_questions)
#             question = subject_questions[idx]

#             if question in competition.questions.all():
#                 continue
#         except:
#             if (len(subjects) != 0):
#                 del subjects[x]
#             else:
#                 break
#             continue

        
#         competition.questions.add(question)

#         competition.save()

#         i += 1
#         x += 1
    
#     update_database_file()



    

# @api_view(['GET',])
# def get_todays_contest(request):
#     try:
#         from datetime import datetime

#         exam_name = request.GET['exam']

#         try:
#             exam = Exams.objects.get(name=exam_name)
#         except:
#             return Response("Wrong Exam Name!", status=status.HTTP_400_BAD_REQUEST)


#         date = datetime.today()

#         contest = WeeklyCompetitions.objects.filter(exam=exam, date=date)

#         if len(contest) == 0:
#             return Response(
#                 "NA", 
#                 status=status.HTTP_404_NOT_FOUND
#             )

#         contest = contest[0]

#         contest_questions = []
        
#         try:
#             contest_questions = contest.questions.all()
#         except InvalidPage:
#             return Response("Done")

#         questions = []


#         for question in contest_questions:
#             questions.append({"uuid": question.uuid, "statement": question.statement, 
#                         "ratings": question.ratings, "difficulty" : question.difficulty, 
#                         "options": [(z.content, z.uuid) for z in question.options.all()], 
#                         "percentCorrect": question.percentCorrect, "subject": question.subject})

        
#         competition = {"uuid": contest.uuid, "questions" : questions}

#         update_database_file()


#         return Response(competition)
    
#     except Exception as e:
#         print(e)
#         return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



# @api_view(['GET', ])
# def get_practice_questions(request):
#     try:
#         user = request.user

#         examName = request.GET['exam']
#         page = int(request.GET['page'])

#         exam = Exams.objects.get(name=examName)


#         if user.isFree:
#             try:
#                 practice_questions = DailyQuestions.objects.filter(exam=exam, user=user).order_by('-id')[page-1]
#             except Exception as e:
#                 print(e)
#                 return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)


#             return Response([{"uuid": question.uuid, "statement": question.statement, 
#                             "ratings": question.ratings, "difficulty" : question.difficulty, 
#                             "options": [(z.content, z.isCorrect) for z in question.options.all()], 
#                             "percentCorrect": question.percentCorrect, "subject": question.subject, "isRated": request.user in question.ratedBy.all(),
#                             "createdBy": "Smartprep Team" if question.isExpert else question.createdBy.name, "explaination": question.explaination} for question in practice_questions.questions.all()])

#     except Exception as e:
#         print(e)
#         return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



# @api_view(['GET', ])
# def get_previous_contests(request):
#     exam = request.GET['exam']
#     page = request.GET['page']
#     page_size = request.GET['page_size']

#     competitions = WeeklyCompetitions.objects.filter(exam=Exams.objects.get(name=exam)).order_by('id')

#     paginator = Paginator(competitions, page_size)

#     competitions_list = []

#     try:
#         competitions_list = paginator.page(page)
#     except InvalidPage:
#         return Response("Done", status=status.HTTP_404_NOT_FOUND)

#     return Response([[competition.name, competition.uuid] for competition in competitions_list])


# @api_view(['GET', ])
# def get_competition_by_uuid(request):
#     uuid = request.GET['uuid']
#     page = request.GET['page']
#     page_size = request.GET['page_size']

#     try:
#         competition = WeeklyCompetitions.objects.get(uuid=uuid)
#     except Exception as e:
#         print(e)
#         return Response("Bad Request", status=status.HTTP_400_BAD_REQUEST)

#     paginator = Paginator(competition.questions.all().order_by('id'), page_size)

#     try:
#         corrects = WeeklyCompetitionResult.objects.get(competition=competition, user=request.user)
#     except:
#         corrects = 0
    
#     contest_questions = []
        
#     try:
#         contest_questions = paginator.page(page)
#     except InvalidPage:
#         return Response("Done")


#     questions = []


#     for question in contest_questions:
#         try:
#             selected_options = Submissions.objects.get(question=question).selected_options.all()
#         except:
#             selected_options = []

            
#         questions.append({"uuid": question.uuid, "statement": question.statement, 
#                         "ratings": question.ratings, "difficulty" : question.difficulty, 
#                         "options": [(z.content, z.isCorrect, z in selected_options) for z in question.options.all()], 
#                         "percentCorrect": question.percentCorrect, "subject": question.subject, "isRated": request.user in question.ratedBy.all(), 
#                         "explaination": question.explaination})

    
#     competition = {"uuid": uuid, "questions" : questions, "corrects": corrects.correct_options if corrects != 0 else corrects}


#     return Response(competition)


# @api_view(['POST', ])
# def submit_contest(request):
#     try:
#         serializer = SubmitContestSerializer(data=request.data, context={'request': request, "useful_data": request.data})

#         if serializer.is_valid():
#             serializer.save()
#         else:
#             print(serializer.errors)

#         update_database_file()

#         return Response("Success")
    
#     except Exception as e:
#         print(e)
#         return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



# @api_view(['GET', ])
# def get_questions_by_ad(request):
#     try:
#         user = request.user

#         result = []

#         exam_name = request.GET['exam']
#         exam = Exams.objects.get(name=exam_name)

#         subjects = list(exam.subjects.all()) # Access all subject related to exam

#         random.shuffle(subjects) # Shuffle Subjects to avoid repeatetions
#         count = 1

#         while count < 3:
#             for subject in subjects:
#                 if (count == 3):
#                     break


#                 try:
#                     question = subject.questions.exclude(seenBy__id = user.id)[1]
#                 except:
#                     continue

#                 question.seenBy.add(request.user) # Marking as seen in Questions DB Table


#                 result.append({"uuid": question.uuid, "statement": question.statement, 
#                         "ratings": question.ratings, "difficulty" : question.difficulty, 
#                         "options": [(z.content, z.isCorrect) for z in question.options.all()], 
#                         "percentCorrect": question.percentCorrect, "subject": question.subject, "isRated": request.user in question.ratedBy.all(),
#                         "createdBy": "Smartprep Team" if question.isExpert else question.createdBy.name, "explaination": question.explaination}) 
                
#                 count += 1

            

#         return Response(result)

#     except Exception as e:
#         print(e)
#         return Response("Error", status=status.HTTP_400_BAD_REQUEST)




# @api_view(['POST', ])
# def give_feedback(request):

#     serializer = AddFeedbackSerializer(data = request.data)

#     if serializer.is_valid():
#         feedback = serializer.save()

#         feedback.user = request.user

#         feedback.save()

#         update_database_file()
#     else:
#         return Response("Error", status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
#     return Response("Thank You for your time")



# @api_view(['POST', ])
# def make_complaint(request):

#     serializer = AddComplaintsSerializer(data = request.data)

#     if serializer.is_valid():
#         complaint = serializer.save()

#         complaint.user = request.user

#         complaint.save()

#         update_database_file()
#     else:
#         return Response("Error", status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
#     return Response("Thank You for your time")


# @api_view(['GET', ])
# def report_question(request):
    
#     user = request.user

#     uuid = request.GET['uuid']
#     question = Questions.objects.get(uuid=uuid)

#     report = ReportedQuestions(user = user, question=question)

#     report.save()

#     update_database_file()

#     return Response("Thanks")




