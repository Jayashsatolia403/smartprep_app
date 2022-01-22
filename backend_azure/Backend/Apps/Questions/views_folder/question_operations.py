import uuid
from django.template import RequestContext
from rest_framework.decorators import api_view
from rest_framework import status

from rest_framework.response import Response

from Apps.Questions.models import Questions, ReportedQuestions, QuestionBookmarks, Subjects
from Apps.Questions.serializers import AddQuestionSerializer, AddOptionsSerializer


from datetime import datetime
import random
from update_db_file import update_database_file






@api_view(['GET', ])
def report_question(request):
    
    user = request.user

    uuid = request.GET['uuid']
    question = Questions.objects.get(uuid=uuid)

    report = ReportedQuestions(user = user, question=question)

    report.save()

    update_database_file()

    return Response("Thanks")



@api_view(['GET', ])
def bookmark_question(request):
    try:
        user = request.user
        ques_id = request.GET['uuid']

        question = Questions.objects.get(uuid=ques_id)

        print(question)

        question_bookmark = QuestionBookmarks.objects.filter(user=user)

        if not question_bookmark:
            question_bookmark = QuestionBookmarks(
                user=user
            )

            question_bookmark.save()
        else:
            question_bookmark = question_bookmark[0]

        question_bookmark.questions.add(question)

        question_bookmark.save()

        update_database_file()

        return Response("Success")


    except Exception as e:
        print(e)
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET', ])
def rateQuestion(request):
    try:
        questionId = request.GET['id']
        difficulty = request.GET['difficulty']
        ratings = request.GET['ratings']

        question = Questions.objects.get(uuid = questionId)
        question.ratedBy.add(request.user)
        question.ratings = (question.ratings + float(ratings))/ (len(question.ratedBy.all())+1)
        question.difficulty = (question.difficulty + float(difficulty))/ (len(question.ratedBy.all())+1)
        question.save()

        update_database_file()

        return Response("Success!")
    
    except Exception as e:
        print(e)
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



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

                from datetime import date
                user = request.user
                user.addedQuestionDate = date.today()
                user.save()

        else:
            print(optionSerializer.errors)

        update_database_file()

        return Response("Success!")
    
    except Exception as e:
        print(e)
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)
