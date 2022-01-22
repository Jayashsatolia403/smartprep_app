from rest_framework.decorators import api_view
from rest_framework import status

from rest_framework.response import Response
from django.core.paginator import InvalidPage, Paginator

from Apps.Questions.models import DailyQuestions, Exams, Submissions, WeeklyCompetitionResult, WeeklyCompetitions

from Apps.Questions.serializers import SubmitContestSerializer
from update_db_file import update_database_file


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
                "NA", 
                status=status.HTTP_404_NOT_FOUND
            )

        contest = contest[0]

        contest_questions = []
        
        try:
            contest_questions = contest.questions.all()
        except InvalidPage:
            return Response("Done")

        questions = []


        for question in contest_questions:
            questions.append({"uuid": question.uuid, "statement": question.statement, 
                        "ratings": question.ratings, "difficulty" : question.difficulty, 
                        "options": [(z.content, z.uuid) for z in question.options.all()], 
                        "percentCorrect": question.percentCorrect, "subject": question.subject})

        
        competition = {"uuid": contest.uuid, "questions" : questions}

        update_database_file()


        return Response(competition)
    
    except Exception as e:
        print(e)
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET', ])
def get_practice_questions(request):
    try:
        user = request.user

        examName = request.GET['exam']
        page = int(request.GET['page'])

        exam = Exams.objects.get(name=examName)


        if user.isFree:
            try:
                practice_questions = DailyQuestions.objects.filter(exam=exam, user=user).order_by('-id')[page-1]
            except Exception as e:
                print(e)
                return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)


            return Response([{"uuid": question.uuid, "statement": question.statement, 
                            "ratings": question.ratings, "difficulty" : question.difficulty, 
                            "options": [(z.content, z.isCorrect) for z in question.options.all()], 
                            "percentCorrect": question.percentCorrect, "subject": question.subject, "isRated": request.user in question.ratedBy.all(),
                            "createdBy": "Smartprep Team" if question.isExpert else question.createdBy.name, "explaination": question.explaination} for question in practice_questions.questions.all()])

    except Exception as e:
        print(e)
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET', ])
def get_previous_contests(request):
    exam = request.GET['exam']
    page = request.GET['page']
    page_size = request.GET['page_size']

    competitions = WeeklyCompetitions.objects.filter(exam=Exams.objects.get(name=exam)).order_by('id')

    paginator = Paginator(competitions, page_size)

    competitions_list = []

    try:
        competitions_list = paginator.page(page)
    except InvalidPage:
        return Response("Done", status=status.HTTP_404_NOT_FOUND)

    return Response([[competition.name, competition.uuid] for competition in competitions_list])


@api_view(['GET', ])
def get_competition_by_uuid(request):
    uuid = request.GET['uuid']
    page = request.GET['page']
    page_size = request.GET['page_size']

    try:
        competition = WeeklyCompetitions.objects.get(uuid=uuid)
    except Exception as e:
        print(e)
        return Response("Bad Request", status=status.HTTP_400_BAD_REQUEST)

    paginator = Paginator(competition.questions.all().order_by('id'), page_size)

    try:
        corrects = WeeklyCompetitionResult.objects.get(competition=competition, user=request.user)
    except:
        corrects = 0
    
    contest_questions = []
        
    try:
        contest_questions = paginator.page(page)
    except InvalidPage:
        return Response("Done")


    questions = []


    for question in contest_questions:
        try:
            selected_options = Submissions.objects.get(question=question).selected_options.all()
        except:
            selected_options = []

            
        questions.append({"uuid": question.uuid, "statement": question.statement, 
                        "ratings": question.ratings, "difficulty" : question.difficulty, 
                        "options": [(z.content, z.isCorrect, z in selected_options) for z in question.options.all()], 
                        "percentCorrect": question.percentCorrect, "subject": question.subject, "isRated": request.user in question.ratedBy.all(), 
                        "explaination": question.explaination})

    
    competition = {"uuid": uuid, "questions" : questions, "corrects": corrects.correct_options if corrects != 0 else corrects}


    return Response(competition)


@api_view(['POST', ])
def submit_contest(request):
    try:
        serializer = SubmitContestSerializer(data=request.data, context={'request': request, "useful_data": request.data})

        if serializer.is_valid():
            serializer.save()
        else:
            print(serializer.errors)

        update_database_file()

        return Response("Success")
    
    except Exception as e:
        print(e)
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)

