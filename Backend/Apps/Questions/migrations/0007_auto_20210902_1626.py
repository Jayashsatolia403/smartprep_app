# Generated by Django 3.2.6 on 2021-09-02 10:56

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('Questions', '0006_auto_20210902_1147'),
    ]

    operations = [
        migrations.CreateModel(
            name='Options',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.CharField(max_length=1000)),
                ('isCorrect', models.BooleanField(default=False)),
            ],
        ),
        migrations.RemoveField(
            model_name='questions',
            name='correctOption',
        ),
        migrations.RemoveField(
            model_name='questions',
            name='option1',
        ),
        migrations.RemoveField(
            model_name='questions',
            name='option2',
        ),
        migrations.RemoveField(
            model_name='questions',
            name='option3',
        ),
        migrations.RemoveField(
            model_name='questions',
            name='option4',
        ),
        migrations.AddField(
            model_name='questions',
            name='options',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='Questions.options'),
        ),
    ]
