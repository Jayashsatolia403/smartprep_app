from django.db.models.fields.json import ContainedBy
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework import status

from rest_framework.response import Response

from .serializers import AddOptionsSerializer, AddQuestionSerializer
from .models import DailyQuestions, Exams, QuestionBookmarks, Questions, QuestionsOfTheDays, Subjects, PracticeQuestions, PrevQuesOfDays, WeeklyCompetitions

from datetime import datetime
import random



# Get Daily Question : Working

@permission_classes([IsAuthenticated])
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
            
            for ques in questions:
                result.append(ques.uuid)


            return Response(result[:limit])
        
        


        subjects = list(exam.subjects.all()) # Access all subject related to exam

        addDailyQuestion = DailyQuestions(user = request.user, date = date, exam = exam) # Add new entry in Daily Questions Table
        addDailyQuestion.save()

        addPracticeQuestions = PracticeQuestions.objects.filter(user = request.user)
        if len(addPracticeQuestions) == 0:
            addPracticeQuestions = PracticeQuestions(user = request.user)
            addPracticeQuestions.save()
        else:
            addPracticeQuestions = addPracticeQuestions[0]

        


        perSubjectLimit = limit//len(subjects) # Define Each Subject Limit to Serve Questions


        random.shuffle(subjects) # Shuffle Subjects to avoid repeatetions
        count = 1

        for subject in subjects:
            questions = subject.questions.exclude(seenBy__id = user.id)[:perSubjectLimit if perSubjectLimit != 0 else 1]

            for ques in questions:

                if count > limit: # Limit Questions
                    break

                ques.seenBy.add(request.user) # Marking as seen in Questions DB Table

                addDailyQuestion.questions.add(ques) # Storing Questions to show as Prev Seen Questions

                addPracticeQuestions.questions.add(ques) # Adding Questions to Use as Practice Questions

                result.append(ques.uuid) # Add UUID of Questions
                
                count += 1

            

        return Response(result[:limit])

    except:
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)




# Add Question : Working

@api_view(['POST', ])
def addQuestion(request):

    try:
        optionSerializer = AddOptionsSerializer(data=request.data)

        if optionSerializer.is_valid():
            options = optionSerializer.save()
            questionSerializer = AddQuestionSerializer(data=request.data)
            
            if questionSerializer.is_valid():
                question = questionSerializer.save()

                for i in options:
                    question.options.add(i)
                
                question.createdBy = request.user

                question.subject = request.data['subject']

                subject = Subjects.objects.get(name=request.data['subject'])

                subject.questions.add(question)
                subject.save()
                
                question.save()

        else:
            print(optionSerializer.errors)

        return Response("Success!")
    
    except:
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



# Get Question of The Day : Working

@api_view(['GET', ])
def getQuestionOfTheDay(request):
    try:
        dateToday = datetime.today().strftime('%Y-%m-%d')
        questions = QuestionsOfTheDays.objects.filter(date=dateToday)

        if len(questions) == 0:
            subjects = Subjects.objects.all()
            
            for subject in subjects:
                for i in subject.questions.all():
                    if (i.ratings > 4.7 and i.difficulty > 4.7) or i.isExpert:
                        if i not in PrevQuesOfDays.objects.all():
                            quesOfDay = QuestionsOfTheDays(date = dateToday)
                            quesOfDay.save()
                            quesOfDay.questions.add(i)
                            quesOfDay.save()

                            savePrevQues = PrevQuesOfDays(question=i)
                            savePrevQues.save()

                            break

        
        subject = request.GET['subject']
        
        quesOfDays = QuestionsOfTheDays.objects.filter(date = dateToday)


        for i in quesOfDays:
            questions = i.questions.all()

            for ques in questions:
                if ques.subject == subject:
                    return Response({"uuid": ques.uuid, "statement": ques.statement, 
                            "options": [(z.content, z.isCorrect) for z in ques.options.all()], 
                            "ratings": ques.ratings, "difficulty" : ques.difficulty, 
                            "percentCorrect": ques.percentCorrect, "subject": subject})

        return Response("Unknown Error : Don't worry our tech team is working in this issue and will get back to you as soon as possible.")
        
    except:
        return Response("Error", status=status.HTTP_400_BAD_REQUEST)



# Rate Question on Basis of Quality and Difficulty : Working

@api_view(['GET', ])
def rateQuestion(request):
    try:
        questionId = request.GET['id']
        difficulty = request.GET['difficulty']
        ratings = request.GET['ratings']

        question = Questions.objects.get(id = questionId)
        question.ratedBy.add(request.user)
        question.ratings = (question.ratings + int(ratings))/ len(question.ratedBy.all())
        question.difficulty = (question.difficulty + int(difficulty))/ len(question.ratedBy.all())
        question.save()

        return Response("Success!")
    
    except:
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



# Get Questions by uuid

@api_view(['GET', ])
def getQuestionByID(request):

    try:
        quesID = request.GET['quesID']

        ques = Questions.objects.get(uuid = quesID)

        return Response({"uuid": ques.uuid, "statement": ques.statement, 
                        "ratings": ques.ratings, "difficulty" : ques.difficulty, 
                        "options": [(z.content, z.isCorrect) for z in ques.options.all()], 
                        "percentCorrect": ques.percentCorrect, "subject": ques.subject})
    
    except:
        return Response("Invalid UUID", status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET', ])
def getPracticeQuestions(request):
    try:
        limit = request.GET['limit']

        result = []

        prevQuesObjects = PracticeQuestions.objects.filter(user=request.user)

        for i in prevQuesObjects:
            for ques in i.questions.all():
                result.append(ques.uuid)

        return Response(result[:int(limit)])
    except:
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)




@api_view(['GET', ])
def bookmark_question(request):
    try:
        user = request.user
        ques_id = request.GET['ques_id']

        question = Questions.objects.get(uuid=ques_id)

        question_bookmark = QuestionBookmarks.objects.filter(user=user)

        if not question_bookmark:
            question_bookmark = QuestionBookmarks(
                user=user
            )

            question_bookmark.save()

            question_bookmark.add(question)

            question_bookmark.save()
        
        else:
            question_bookmark.add(question)
            question_bookmark.save()
    except:
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET', ])
def get_bookmarked_questions(request):
    try:
        user = request.user

        bookmarked_questions = QuestionBookmarks.objects.filter(user=user)

        if not bookmarked_questions:
            bookmarked_question = QuestionBookmarks(user = request.user)
            bookmarked_question.save()
        else:
            bookmarked_question = bookmarked_questions[0]

        return Response([i.uuid for i in bookmarked_question.questions.all()])

    except:
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)




@api_view(['GET',])
def host_weekly_competition(request):
    try:
        user = request.user

        if not user or not user.is_superuser:
            return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)

        exam_questions = {
            "ias": 100,
            "jeeMains": 90,
            "jeeAdv": 54,
            "neet": 180,
            "ras": 150,
            "ibpsPO": 100,
            "ibpsClerk": 100,
            "sscCGL": 100,
            "sscCHSL": 100,
            "ndaMaths": 120,
            "ndaGAT": 150,
            "cat": 90,
        }

        questions = {
                "ias": set(),
                "jeeMains": set(),
                "jeeAdv": set(),
                "neet": set(),
                "ras": set(),
                "ibpsPO": set(),
                "ibpsClerk": set(),
                "sscCGL": set(),
                "sscCHSL": set(),
                "ndaMaths": set(),
                "ndaGAT": set(),
                "cat": set(),
            }


        
        exams = Exams.objects.all()

        exam = exams[0]

        for exam in exams:
            import uuid

            if exam.name not in questions:
                continue

            round = WeeklyCompetitions.objects.all()[-1]
            round = int(round.round)

            competition = WeeklyCompetitions(
                uuid=str(uuid.uuid4()),
                name="Smartprep {} Round #{}".format(str(exam.name), str(round+1)),
                round=round+1,
                exam=exam
            )

            competition.save()


            subjects = exam.subjects.all()
            
            limit = exam_questions[exam.name] // len(subjects)

            count = 0
            idx = 0


            for i in range(exam_questions[exam.name]):
                if i >= len(subjects)*(count+1):
                    count += 1
                    idx += 1

                i = i - len(subjects)*count

                subject = subjects[i]


                question = subject.questions.all()[idx]
                
                competition.questions.add(question)

                competition.save()


        return Response("Success")
    
    except:
        return Response('Invalid Request', status=status.HTTP_400_BAD_REQUEST)

    

@api_view(['GET',])
def get_todays_contest(request):
    try:
    
        from datetime import datetime

        exam_name = request.GET['exam']
        try:
            exam = Exams.objects.get(name=exam_name)
        except:
            return Response("Wrong Exam Name!", status=status.HTTP_400_BAD_REQUEST)


        date = datetime.today()

        contest = WeeklyCompetitions.objects.filter(exam=exam, date=date)

        if len(contest) == 0:
            return Response(
                "Sorry We don't have any competition for your exam this time but we're working on it and you can expect it very soon from us.", 
                status=status.HTTP_400_BAD_REQUEST
            )

        contest = contest[0]

        questions = []

        for question in contest.questions.all():
            questions.append(question.uuid)

        return Response(questions)
    
    except:
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



  