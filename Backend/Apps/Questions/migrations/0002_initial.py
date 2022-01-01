# Generated by Django 3.2.9 on 2022-01-01 03:32

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('Questions', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='weeklycompetitionresult',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='resultUser', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='submissions',
            name='question',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='submissionQuestion', to='Questions.questions'),
        ),
        migrations.AddField(
            model_name='submissions',
            name='selected_options',
            field=models.ManyToManyField(blank=True, related_name='submissionSelectedOptions', to='Questions.Options'),
        ),
        migrations.AddField(
            model_name='submissions',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='submissionUser', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='subjects',
            name='questions',
            field=models.ManyToManyField(blank=True, related_name='questions', to='Questions.Questions'),
        ),
        migrations.AddField(
            model_name='reportedquestions',
            name='questions',
            field=models.ManyToManyField(blank=True, related_name='reportedQuestions', to='Questions.Questions'),
        ),
        migrations.AddField(
            model_name='questionsofthedays',
            name='exam',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, related_name='quesOfDayExam', to='Questions.exams'),
        ),
        migrations.AddField(
            model_name='questionsofthedays',
            name='question',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, related_name='questionsOfTheDays', to='Questions.questions'),
        ),
        migrations.AddField(
            model_name='questions',
            name='createdBy',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='questions',
            name='options',
            field=models.ManyToManyField(blank=True, to='Questions.Options'),
        ),
        migrations.AddField(
            model_name='questions',
            name='ratedBy',
            field=models.ManyToManyField(blank=True, related_name='ratedBy', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='questions',
            name='seenBy',
            field=models.ManyToManyField(blank=True, related_name='seenBy', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='questionbookmarks',
            name='questions',
            field=models.ManyToManyField(blank=True, related_name='bookmarked_questions', to='Questions.Questions'),
        ),
        migrations.AddField(
            model_name='questionbookmarks',
            name='user',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='bookmarked_user', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='feedback',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='feedbackUser', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='exams',
            name='subjects',
            field=models.ManyToManyField(blank=True, related_name='subjects', to='Questions.Subjects'),
        ),
        migrations.AddField(
            model_name='dailyquestions',
            name='exam',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='Questions.exams'),
        ),
        migrations.AddField(
            model_name='dailyquestions',
            name='questions',
            field=models.ManyToManyField(blank=True, to='Questions.Questions'),
        ),
        migrations.AddField(
            model_name='dailyquestions',
            name='user',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
