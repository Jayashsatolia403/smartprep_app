import uuid
from rest_framework.decorators import api_view
from rest_framework import status

from rest_framework.response import Response

from Apps.Questions.models import Exams, WeeklyCompetitions


import random
from update_db_file import update_database_file


def hostWeeklyCompetition():

    exam_questions = {
        "ias": 100,
        "iasHindi": 100,
        "jee": 60,
        "jeeMains": 90,
        "jeeAdv": 54,
        "neet": 180,
        "ras": 150,
        "rasHindi": 150,
        "ibpsPO": 100,
        "ibpsClerk": 100,
        "sscCGL": 100,
        "sscCGLHindi": 100,
        "sscCHSL": 100,
        "cat": 90,
        "ntpc": 100,
        "reet1": 150,
        "reet2": 150,
        "reet2Science": 150,
        "patwari": 150,
        "grade2nd": 100,
        "grade2ndScience": 150,
        "grade2ndSS": 150,
        "sscGD": 100,
        "sscMTS": 100,
        "rajPoliceConst": 150,
        "rajLDC": 150,
        "rrbGD": 150,
        "sipaper1": 100,
        "sipaper2": 100
    }

    
    exams = Exams.objects.all()

    for exam in exams:
        import uuid

        if exam.name not in exam_questions:
            continue

        round = WeeklyCompetitions.objects.filter(exam=exam)
        if len(round) == 0:
            round = 0
        else:
            round = round[len(round)-1]
            round = int(round.round)


        competition = WeeklyCompetitions(
            uuid=str(uuid.uuid4()),
            name="Smartprep {} Round #{}".format(str(exam.name), str(round+1)),
            round=round+1,
            exam=exam,
        )

        competition.save()


        subjects = list(exam.subjects.all())


        limit = exam_questions[exam.name] // len(subjects)

        idx = 0
        i = 0
        limit = 0
        x = 0

        while i < exam_questions[exam.name]:

            if x == len(subjects):
                x = 0

            if len(subjects) == 0:
                break

            if limit > 10000:
                print("Breaking due to limit exceeed at index :", i)
                break
            else:
                limit += 1


            if i >= len(subjects)*(idx+1):
                idx += 1


            subject = subjects[x]

            try:
                subject_questions = list(subject.questions.all())
                random.shuffle(subject_questions)
                question = subject_questions[idx]

                if question in competition.questions.all():
                    continue
            except:
                if (len(subjects) != 0):
                    del subjects[x]
                else:
                    break
                continue

            
            competition.questions.add(question)

            competition.save()

            i += 1
            x += 1
        
        update_database_file()



@api_view(['GET',])
def host_weekly_competition(request):
    try:
        user = request.user

        if not user or not user.is_superuser:
            return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)

        import threading

        t = threading.Thread(target=hostWeeklyCompetition)
        t.daemon = True
        t.start()

        return Response("Success")
    
    except Exception as err:
        print(err)
        return Response('Invalid Request', status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def host_weekly_competition_by_exam(request):
    exam_questions = {
        "ias": 100,
        "iasHindi": 100,
        "jee": 60,
        "jeeMains": 90,
        "jeeAdv": 54,
        "neet": 180,
        "ras": 150,
        "rasHindi": 150,
        "ibpsPO": 100,
        "ibpsClerk": 100,
        "sscCGL": 100,
        "sscCGLHindi": 100,
        "sscCHSL": 100,
        "cat": 90,
        "ntpc": 100,
        "reet1": 150,
        "reet2": 150,
        "reet2Science": 150,
        "patwari": 150,
        "grade2nd": 100,
        "grade2ndScience": 150,
        "grade2ndSS": 150,
        "sscGD": 100,
        "sscMTS": 100,
        "rajPoliceConst": 150,
        "rajLDC": 150,
        "rrbGD": 150,
        "sipaper1": 100,
        "sipaper2": 100
    }


    examname = request.GET['exam']

    if examname not in exam_questions:
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)

    
    exam = Exams.objects.get(name=examname)

    round = WeeklyCompetitions.objects.filter(exam=exam)

    if len(round) == 0:
        round = 0
    else:
        round = round[len(round)-1]
        round = int(round.round)


    competition = WeeklyCompetitions(
        uuid=str(uuid.uuid4()),
        name="Smartprep {} Round #{}".format(str(exam.name), str(round+1)),
        round=round+1,
        exam=exam,
    )

    competition.save()


    subjects = list(exam.subjects.all())


    limit = exam_questions[exam.name] // len(subjects)

    idx = 0
    i = 0
    limit = 0
    x = 0

    while i < exam_questions[exam.name]:

        if x == len(subjects):
            x = 0

        if len(subjects) == 0:
            break

        if limit > 10000:
            print("Breaking due to limit exceeed at index :", i)
            break
        else:
            limit += 1


        if i >= len(subjects)*(idx+1):
            idx += 1


        subject = subjects[x]

        try:
            subject_questions = list(subject.questions.all())
            random.shuffle(subject_questions)
            question = subject_questions[idx]

            if question in competition.questions.all():
                continue
        except:
            if (len(subjects) != 0):
                del subjects[x]
            else:
                break
            continue

        
        competition.questions.add(question)

        competition.save()

        i += 1
        x += 1
    
    update_database_file()
