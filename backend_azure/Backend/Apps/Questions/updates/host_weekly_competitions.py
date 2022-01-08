# from django.core import paginator
# from rest_framework.decorators import api_view
# from rest_framework import status

# from rest_framework.response import Response
# from django.core.paginator import InvalidPage, Paginator

# from Questions.serializers import AddComplaintsSerializer, AddFeedbackSerializer, AddOptionsSerializer, AddQuestionSerializer, SubmitContestSerializer
# from Questions.models import DailyQuestions, Exams, QuestionBookmarks, Questions, QuestionsOfTheDays, ReportedQuestions, Subjects, WeeklyCompetitionResult, WeeklyCompetitions

# from datetime import datetime
# import random



# @api_view(['GET', ])
# def host_weekly_competition(request):
#     user = request.user 

#     if not user.is_superuser:
#         return Response("Only Administrator is allowed to access this page.", status=status.HTTP_403_FORBIDDEN)

#     questions = []

#     exam_questions = {
#             "ias": 100,
#             "iasHindi": 100,
#             "jee": 60,
#             "jeeMains": 90,
#             "jeeAdv": 54,
#             "neet": 180,
#             "ras": 150,
#             "rasHindi": 150,
#             "ibpsPO": 100,
#             "ibpsClerk": 100,
#             "sscCGL": 100,
#             "sscCGLHindi": 100,
#             "sscCHSL": 100,
#             "cat": 90,
#             "ntpc": 100,
#             "reet1": 150,
#             "reet2": 150,
#             "reet2Science": 150,
#             "patwari": 150,
#             "grade2nd": 100,
#             "grade2ndScience": 150,
#             "grade2ndSS": 150,
#             "sscGD": 100,
#             "sscMTS": 100,
#             "rajPoliceConst": 150,
#             "rajLDC": 150,
#             "rrbGD": 150,
#             "sipaper1": 100,
#             "sipaper2": 100
#     }

#     questions = {
#             "ias": set(),
#             "iasHindi": set(),
#             "jee": set(),
#             "jeeMains": set(),
#             "jeeAdv": set(),
#             "neet": set(),
#             "ras": set(),
#             "rasHindi": set(),
#             "ibpsPO": set(),
#             "ibpsClerk": set(),
#             "sscCGL": set(),
#             "sscCGLHindi": set(),
#             "sscCHSL": set(),
#             "cat": set(),
#             "ntpc": set(),
#             "reet1": set(),
#             "reet2": set(),
#             "reet2Science": set(),
#             "patwari": set(),
#             "grade2nd": set(),
#             "grade2ndScience": set(),
#             "grade2ndSS": set(),
#             "sscGD": set(),
#             "sscMTS": set(),
#             "rajPoliceConst": set(),
#             "rajLDC": set(),
#             "rrbGD": set(),
#             "sipaper1": set(),
#             "sipaper2": set()
#     }

#     exam_ques_relation = {
#         "ias": {
#             "currentAffairsWorldHard": 8,
#             "geographyIndEasy": 2,
#             "geographyIndHard": 15,
#             "currentAffairsIndiaEasy": 3, 
#             "currentAffairsIndiaHard": 8, 
#             "geographyWorld": 5,
#             "polityIndEasy": 5, 
#             "polityIndHard": 15, 
#             "economyIndGen": 15, 
#             "economyIndBudgetAndSchemes": 2, 
#             "environmentAndEcologyHard": 5, 
#             "environmentAndEcologyEasy": 3, 
#             "historyIndEasy": 2,
#             "historyIndHard": 15,
#             "historyWorld": 5,
#             "InternationalRelationAndSecurity": 5, 
#             "sciAndTechHard": 4, 
#             "artAndCultureInd": 2, 
#             "constitutionAndGovernance": 5,
#             "decisionMaking": 4,
#             "iasMisc": 1000
#         }
#     }

#     iasSubjects = ["currentAffairsWorldHard", 
#                    "currentAffairsIndiaEasy", 
#                    "currentAffairsIndiaHard", 
#                    "geographyIndEasy", 
#                    "geographyIndHard", 
#                    "geographyWorld",
#                    "polityIndEasy", 
#                    "polityIndHard", 
#                    "economyIndGen", 
#                    "economyIndBudgetAndSchemes", 
#                    "environmentAndEcologyHard", 
#                    "environmentAndEcologyEasy", 
#                    "historyIndEasy",
#                    "historyIndHard",
#                    "historyWorld",
#                    "InternationalRelationAndSecurity", 
#                    "sciAndTechHard", 
#                    "artAndCultureInd", 
#                    "constitutionAndGovernance",
#                    "decisionMaking",
#                    "iasMisc"]