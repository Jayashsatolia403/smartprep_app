from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated

from rest_framework.response import Response

from .serializers import AddOptionsSerializer, AddQuestionSerializer
from .models import DailyQuestions, Exams, Questions, QuestionsOfTheDays, Subjects, PracticeQuestions, PrevQuesOfDays

from datetime import datetime
import random



# Get Daily Question : Working

@permission_classes([IsAuthenticated])
@api_view(['GET', ])
def getDailyQuestions(request):

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
        return Response("Invalid Request!")



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
        return Response("Invalid Request!")



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
        return Response("Invalid Request!")



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
        return Response("Invalid UUID")



@api_view(['GET', ])
def getPracticeQuestions(request):
    limit = request.GET['limit']

    result = []

    prevQuesObjects = PracticeQuestions.objects.filter(user=request.user)

    for i in prevQuesObjects:
        for ques in i.questions.all():
            result.append(ques.uuid)

    return Response(result[:int(limit)])


@api_view(['GET', ])
def getIP(request):
    import socket 
    ip = socket.gethostbyname(socket.gethostname())

    return Response(ip)