from django.core import paginator
from django.urls import path

from .views import get_competition_by_uuid, get_practice_questions, get_previous_contests, get_questions_by_ad, get_todays_contest, addQuestion, bookmark_question, get_bookmarked_questions, getQuestionByID, give_feedback, has_user_added_question_today, host_weekly_competition, make_complaint, report_question, submit_contest
from .views import rateQuestion, getQuestionOfTheDay, getDailyQuestions

urlpatterns = [
    path('rateQues', rateQuestion, name='rateQuestion'),
    path('addQues/', addQuestion, name='addQues'),
    path('getQuesOfDay', getQuestionOfTheDay, name = 'quesOfDay'),
    path('getQues', getDailyQuestions, name='getDailyQuestions'),
    path('getQuesByID', getQuestionByID, name='getQuesByID'),
    path('bookmark_ques', bookmark_question, name='bookmark_question'),
    path('get_bookmarked_questions', get_bookmarked_questions, name='get_bookmarked_questions'),
    path('host_weekly_competition', host_weekly_competition, name='host_weekly_competition'),
    path('get_todays_contest', get_todays_contest, name="get_todays_contest"),
    path('submit_contest/', submit_contest, name='submit_contest'),
    path('get_previous_contests', get_previous_contests, name="get_previous_contests"),
    path('get_competition_by_uuid', get_competition_by_uuid, name="get_competition_by_uuid"),
    path('has_user_added_question_today', has_user_added_question_today, name="has_user_added_question_today"),
    path('get_practice_questions', get_practice_questions, name="get_practice_questions"),
    path('get_questions_by_ad', get_questions_by_ad, name="get_questions_by_ad"),
    path('give_feedback/', give_feedback, name="give_feedback"),
    path('make_complaint/', make_complaint, name="make_complaint"),
    path('report_question/', report_question, name="report_question")
]