from django.urls import path

from.views import addQuestion, getIP, getPracticeQuestions, getQuestionByID
from .views import rateQuestion, getQuestionOfTheDay, getDailyQuestions

urlpatterns = [
    path('rateQues', rateQuestion, name='rateQuestion'),
    path('addQues/', addQuestion, name='addQues'),
    path('getQuesOfDay', getQuestionOfTheDay, name = 'quesOfDay'),
    path('getQues', getDailyQuestions, name='getDailyQuestions'),
    path('getQuesByID', getQuestionByID, name='getQuesByID'),
    path('getPracticeQues', getPracticeQuestions, name='getPracticeQues'),
    path('getIP', getIP, name='getIP')
]