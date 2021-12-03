from django.contrib import admin

from .models import DailyQuestions, Exams, Options, PracticeQuestions, QuestionBookmarks, Questions, Subjects, QuestionsOfTheDays, PrevQuesOfDays

admin.site.register(Questions)
admin.site.register(Options)
admin.site.register(Subjects)
admin.site.register(Exams)
admin.site.register(QuestionsOfTheDays)
admin.site.register(PrevQuesOfDays)
admin.site.register(DailyQuestions)
admin.site.register(PracticeQuestions)
admin.site.register(QuestionBookmarks)