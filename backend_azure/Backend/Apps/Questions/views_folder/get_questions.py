from rest_framework.decorators import api_view
from rest_framework import status

from rest_framework.response import Response
from django.core.paginator import InvalidPage, Paginator
from Apps import Questions

from Apps.Questions.models import DailyQuestions, Exams, QuestionBookmarks, QuestionsOfTheDays, Submissions, WeeklyCompetitionResult, WeeklyCompetitions

from update_db_file import update_database_file

from datetime import datetime
import random
import uuid












@api_view(['GET', ])
def getDailyQuestions(request):
    try:
        result = []
        user = request.user
        examTitle = request.GET['exam']
        exam = Exams.objects.get(name = examTitle)

        # Check if user is premium or not

        if user.membershipOf30 and examTitle in user.premiumExams:
            if examTitle == "jeeAdv":
                limit = 25
            else:
                limit = 30
        
        elif user.membershipOf50 and examTitle in user.premiumExams:
            if examTitle == "jeeAdv":
                limit = 50
            else:
                limit = 60
        
        elif user.membershipOf100 and examTitle in user.premiumExams:
            if examTitle == "jeeAdv":
                limit = 100
            else:
                limit = 120
        
        else:
            if examTitle == "jeeAdv":
                limit = 3
            elif examTitle == "jeeMains":
                limit = 7
            else:
                limit = 10

        date = datetime.today().strftime('%Y-%m-%d')


        # COMPLETED: Check If Daily Questions are already assigned for particular User

        availableDailyQuestions = DailyQuestions.objects.filter(user=user, date=date, exam=exam)

        if len(availableDailyQuestions) != 0:
            questions = availableDailyQuestions[0].questions.all()
            
            for question in questions:
                result.append({"uuid": question.uuid, "statement": question.statement, 
                        "ratings": question.ratings, "difficulty" : question.difficulty, 
                        "options": [(z.content, z.isCorrect, z.uuid) for z in question.options.all()], 
                        "percentCorrect": question.percentCorrect, "subject": question.subject, "isRated": request.user in question.ratedBy.all(),
                        "createdBy": "Smartprep Team" if question.isExpert else question.createdBy.name, "explaination": question.explaination})


            update_database_file()

            return Response(result[:limit])
        
        


        subjects = list(exam.subjects.all()) # Access all subject related to exam

        addDailyQuestion = DailyQuestions(uuid = uuid.uuid4(), user = request.user, date = date, exam = exam) # Add new entry in Daily Questions Table
        addDailyQuestion.save()

        perSubjectLimit = limit//len(subjects) # Define Each Subject Limit to Serve Questions



        random.shuffle(subjects) # Shuffle Subjects to avoid repeatetions
        count = 1

        break_limit = 0

        while count <= limit:

            if break_limit > 10000:
                break

            for subject in subjects:
                try:
                    questions = subject.questions.exclude(seenBy__id = user.id)[:perSubjectLimit if perSubjectLimit != 0 else 1]
                except:
                    continue

                for question in questions:

                    if count > limit: # Limit Questions
                        break

                    question.seenBy.add(request.user) # Marking as seen in Questions DB Table

                    addDailyQuestion.questions.add(question)

                    result.append({"uuid": question.uuid, "statement": question.statement, 
                            "ratings": question.ratings, "difficulty" : question.difficulty, 
                            "options": [(z.content, z.isCorrect, z.uuid) for z in question.options.all()], 
                            "percentCorrect": question.percentCorrect, "subject": question.subject, "isRated": request.user in question.ratedBy.all(),
                            "createdBy": "Smartprep Team" if question.isExpert else question.createdBy.name, "explaination": question.explaination}) 
                    
                    count += 1

            
        update_database_file()

        return Response(result[:limit])

    except Exception as e:
        print(e)
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET', ])
def getQuestionOfTheDay(request):
    try:
        exam_name = request.GET['exam']

        dateToday = datetime.today().strftime('%Y-%m-%d')
        

        exam = Exams.objects.get(name=exam_name)

        try:
            quesOfDay = QuestionsOfTheDays.objects.get(date = dateToday, exam=exam)
            ques = quesOfDay.question

            update_database_file()


            return Response({"uuid": ques.uuid, "statement": ques.statement, 
                        "options": [(z.content, z.isCorrect) for z in ques.options.all()], 
                        "ratings": ques.ratings, "difficulty" : ques.difficulty, 
                        "percentCorrect": ques.percentCorrect, "subject": ques.subject, "isRated": request.user in ques.ratedBy.all(),
                        "createdBy": "Smartprep Team" if ques.isExpert else ques.createdBy.name, "explaination": ques.explaination})
        except:
            subjects = list(exam.subjects.all())

            random.shuffle(subjects)

            for subject in subjects:

                if not subject.questions.all():
                    continue

                done = False

                for i in subject.questions.all():
                    if (i.ratings > 4.7 and i.difficulty > 4.7) or i.isExpert:
                        if not QuestionsOfTheDays.objects.filter(question=i):

                            import uuid
                            
                            quesOfDay = QuestionsOfTheDays(date = dateToday, uuid = str(uuid.uuid4()), exam=exam)
                            quesOfDay.save()
                            quesOfDay.question = i
                            quesOfDay.save()

                            done = True

                            break

                if done:
                    break

            
            
            quesOfDay = QuestionsOfTheDays.objects.get(date = dateToday, exam=exam)

            ques = quesOfDay.question

            update_database_file()


            return Response({"uuid": ques.uuid, "statement": ques.statement, 
                        "options": [(z.content, z.isCorrect) for z in ques.options.all()], 
                        "ratings": ques.ratings, "difficulty" : ques.difficulty, 
                        "percentCorrect": ques.percentCorrect, "subject": subject.name, "isRated": request.user in ques.ratedBy.all(),
                        "createdBy": "Smartprep Team" if ques.isExpert else ques.createdBy.name, "explaination": ques.explaination})
  
    except Exception as e:
        print(e)
        return Response("Error", status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET', ])
def getQuestionByID(request):

    try:
        quesID = request.GET['quesID']

        ques = Questions.objects.get(uuid = quesID)

        return Response({"uuid": ques.uuid, "statement": ques.statement, 
                        "ratings": ques.ratings, "difficulty" : ques.difficulty, 
                        "options": [(z.content, z.isCorrect, z.uuid) for z in ques.options.all()], 
                        "percentCorrect": ques.percentCorrect, "subject": ques.subject, "explaination": ques.explaination})
    
    except Exception as e:
        print(e)
        return Response("Invalid UUID", status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET', ])
def get_bookmarked_questions(request):
    try:
        user = request.user
        page = request.GET['page']
        page_size = request.GET['page_size']

        bookmarked_questions = QuestionBookmarks.objects.filter(user=user)

        if not bookmarked_questions:
            bookmarked_questions = QuestionBookmarks(user = request.user)
            bookmarked_questions.save()
        else:
            bookmarked_questions = bookmarked_questions[0]
        
        bookmarked_questions = bookmarked_questions.questions.all().order_by('-id')

        paginator = Paginator(bookmarked_questions, page_size)

        update_database_file()

        try:
            result = paginator.page(page)
        except InvalidPage:
            return Response("Done", status=status.HTTP_404_NOT_FOUND)


        return Response([{"uuid": question.uuid, "statement": question.statement, 
                        "ratings": question.ratings, "difficulty" : question.difficulty, 
                        "options": [(z.content, z.isCorrect) for z in question.options.all()], 
                        "percentCorrect": question.percentCorrect, "subject": question.subject, 
                        "isRated": request.user in question.ratedBy.all(), "explaination": question.explaination} for question in result])

    except Exception as e:
        print(e)
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET', ])
def get_questions_by_ad(request):
    try:
        user = request.user

        result = []

        exam_name = request.GET['exam']
        exam = Exams.objects.get(name=exam_name)

        subjects = list(exam.subjects.all()) # Access all subject related to exam

        random.shuffle(subjects) # Shuffle Subjects to avoid repeatetions
        count = 1

        while count < 3:
            for subject in subjects:
                if (count == 3):
                    break


                try:
                    question = subject.questions.exclude(seenBy__id = user.id)[1]
                except:
                    continue

                question.seenBy.add(request.user) # Marking as seen in Questions DB Table


                result.append({"uuid": question.uuid, "statement": question.statement, 
                        "ratings": question.ratings, "difficulty" : question.difficulty, 
                        "options": [(z.content, z.isCorrect) for z in question.options.all()], 
                        "percentCorrect": question.percentCorrect, "subject": question.subject, "isRated": request.user in question.ratedBy.all(),
                        "createdBy": "Smartprep Team" if question.isExpert else question.createdBy.name, "explaination": question.explaination}) 
                
                count += 1

            

        return Response(result)

    except Exception as e:
        print(e)
        return Response("Error", status=status.HTTP_400_BAD_REQUEST)
