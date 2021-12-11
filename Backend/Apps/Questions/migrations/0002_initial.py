# Generated by Django 3.2.9 on 2021-12-11 15:36

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('Questions', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
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
            model_name='prevquesofdays',
            name='question',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='Questions.questions'),
        ),
        migrations.AddField(
            model_name='practicequestions',
            name='questions',
            field=models.ManyToManyField(blank=True, related_name='practiceQuestions', to='Questions.Questions'),
        ),
        migrations.AddField(
            model_name='practicequestions',
            name='user',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
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
