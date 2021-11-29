# Generated by Django 3.2.6 on 2021-09-27 16:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Questions', '0022_auto_20210919_1757'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='questions',
            name='exam',
        ),
        migrations.AddField(
            model_name='subjects',
            name='questions',
            field=models.ManyToManyField(blank=True, related_name='questions', to='Questions.Questions'),
        ),
        migrations.AlterField(
            model_name='questions',
            name='subject',
            field=models.CharField(max_length=50, null=True),
        ),
        migrations.AlterField(
            model_name='questionsofthedays',
            name='questions',
            field=models.ManyToManyField(blank=True, related_name='questionsOfTheDays', to='Questions.Questions'),
        ),
    ]