from django.contrib import admin

from .models import DailyQuestions, Exams, Options, QuestionBookmarks, Questions, Subjects, QuestionsOfTheDays, Submissions, WeeklyCompetitionResult, WeeklyCompetitions

admin.site.register(Questions)
admin.site.register(Options)
admin.site.register(Subjects)
admin.site.register(Exams)
admin.site.register(QuestionsOfTheDays)
admin.site.register(DailyQuestions)
admin.site.register(QuestionBookmarks)
admin.site.register(WeeklyCompetitions)
admin.site.register(Submissions)
admin.site.register(WeeklyCompetitionResult)