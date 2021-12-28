from django.core import paginator
from django.urls import path

from .views import get_todays_contest, addQuestion, bookmark_question, get_bookmarked_questions, getPracticeQuestions, getQuestionByID, host_weekly_competition, submit_contest
from .views import rateQuestion, getQuestionOfTheDay, getDailyQuestions

urlpatterns = [
    path('rateQues', rateQuestion, name='rateQuestion'),
    path('addQues/', addQuestion, name='addQues'),
    path('getQuesOfDay', getQuestionOfTheDay, name = 'quesOfDay'),
    path('getQues', getDailyQuestions, name='getDailyQuestions'),
    path('getQuesByID', getQuestionByID, name='getQuesByID'),
    path('getPracticeQues', getPracticeQuestions, name='getPracticeQues'),
    path('bookmark_ques', bookmark_question, name='bookmark_question'),
    path('get_bookmarked_questions', get_bookmarked_questions, name='get_bookmarked_questions'),
    path('host_weekly_competition', host_weekly_competition, name='host_weekly_competition'),
    path('get_todays_contest', get_todays_contest, name="get_todays_contest"),
    path('submit_contest', submit_contest, name='submit_contest')
]