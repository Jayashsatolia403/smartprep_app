# Generated by Django 3.2.9 on 2022-01-01 21:14

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Exams',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50)),
                ('name', models.CharField(blank=True, choices=[('ias', 'ias'), ('jee', 'jee'), ('jeeMains', 'jeeMains'), ('jeeAdv', 'jeeAdv'), ('neet', 'neet'), ('ras', 'ras'), ('ibpsPO', 'ibpsPO'), ('ibpsClerk', 'ibpsClerk'), ('sscCHSL', 'sscCHSL'), ('sscCGL', 'sscCGL'), ('nda', 'nda'), ('cds', 'cds'), ('ntpc', 'ntpc'), ('reet1', 'reet1'), ('reet2', 'reet2'), ('reet2Science', 'reet2Science'), ('patwari', 'patwari'), ('grade2nd', 'grade2nd'), ('grade2ndScience', 'grade2ndScience'), ('grade2ndSS', 'grade2ndSS'), ('sscGD', 'sscGD'), ('sscMTS', 'sscMTS'), ('rajPoliceConst', 'rajPoliceConst'), ('rajLDC', 'rajLDC'), ('rrbGD', 'rrbGD'), ('sipaper1', 'sipaper1'), ('sipaper2', 'sipaper2')], max_length=20, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Options',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50)),
                ('content', models.CharField(max_length=1000)),
                ('isCorrect', models.BooleanField(default=False)),
            ],
        ),
        migrations.CreateModel(
            name='Questions',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(blank=True, max_length=50, null=True)),
                ('statement', models.TextField(blank=True, null=True)),
                ('difficulty', models.FloatField(blank=True, null=True)),
                ('ratings', models.FloatField(blank=True, null=True)),
                ('percentCorrect', models.FloatField(blank=True, null=True)),
                ('created_at', models.DateField(auto_now_add=True, null=True)),
                ('isExpert', models.BooleanField(default=False)),
                ('subject', models.CharField(max_length=50, null=True)),
                ('explaination', models.TextField()),
                ('createdBy', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('options', models.ManyToManyField(blank=True, to='Questions.Options')),
                ('ratedBy', models.ManyToManyField(blank=True, related_name='ratedBy', to=settings.AUTH_USER_MODEL)),
                ('seenBy', models.ManyToManyField(blank=True, related_name='seenBy', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Submissions',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50)),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='submissionQuestion', to='Questions.questions')),
                ('selected_options', models.ManyToManyField(blank=True, related_name='submissionSelectedOptions', to='Questions.Options')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='submissionUser', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='WeeklyCompetitions',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50)),
                ('name', models.CharField(max_length=100)),
                ('round', models.IntegerField(default=0)),
                ('date', models.DateField(auto_now_add=True)),
                ('exam', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='competitions_exams', to='Questions.exams')),
                ('questions', models.ManyToManyField(blank=True, related_name='competition_questions', to='Questions.Questions')),
            ],
        ),
        migrations.CreateModel(
            name='WeeklyCompetitionResult',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('correct_options', models.IntegerField(default=0)),
                ('competition', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='weeklyCompetitions', to='Questions.weeklycompetitions')),
                ('submissions', models.ManyToManyField(blank=True, related_name='weeklyCompetitionSubmissions', to='Questions.Submissions')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='resultUser', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Subjects',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50)),
                ('name', models.CharField(choices=[('physicsAdv', 'physicsAdv'), ('mathsAdv', 'mathsAdv'), ('chemAdv', 'chemAdv'), ('physicsMains', 'physicsMains'), ('mathsMains', 'mathsMains'), ('chemMains', 'chemMains'), ('bio', 'bio'), ('reasoningHard', 'reasoningHard'), ('reasoningEasy', 'reasoningEasy'), ('currentAffairsWorldEasy', 'currentAffairsWorldEasy'), ('currentAffairsWorldHard', 'currentAffairsWorldHard'), ('currentAffairsIndiaEasy', 'currentAffairsIndiaEasy'), ('currentAffairsIndiaHard', 'currentAffairsIndiaHard'), ('quantAptHard', 'quantAptHard'), ('quantAptEasy', 'quantAptEasy'), ('englishLangAndComprehensionEasy', 'englishLangAndComprehensionEasy'), ('englishLangAndComprehensionHard', 'englishLangAndComprehensionHard'), ('basicComputer', 'basicComputer'), ('economyAndBanking', 'economyAndBanking'), ('geographyIndHard', 'geographyIndHard'), ('geographyIndEasy', 'geographyIndEasy'), ('geographyWorld', 'geographyWorld'), ('polityIndEasy', 'polityIndEasy'), ('polityIndHard', 'polityIndHard'), ('economyIndGen', 'economyIndGen'), ('economyIndBudgetAndSchemes', 'economyIndBudgetAndSchemes'), ('environmentAndEcologyEasy', 'environmentAndEcologyEasy'), ('environmentAndEcologyHard', 'environmentAndEcologyHard'), ('historyIndEasy', 'historyIndEasy'), ('historyIndHard', 'historyIndHard'), ('historyWorld', 'historyWorld'), ('InternationalRelationAndSecurity', 'InternationalRelationAndSecurity'), ('sciAndTechEasy', 'sciAndTechEasy'), ('sciAndTechHard', 'sciAndTechHard'), ('generalScience', 'generalScience'), ('geographyRajEasy', 'geographyRajEasy'), ('geographyRajHard', 'geographyRajHard'), ('historyRajEasy', 'historyRajEasy'), ('historyRajHard', 'historyRajHard'), ('artAndCultureRaj', 'artAndCultureRaj'), ('polityRajHard', 'polityRajHard'), ('polityRajEasy', 'polityRajEasy'), ('currentAffairsRajHard', 'currentAffairsRajHard'), ('currentAffairsRajEasy', 'currentAffairsRajEasy'), ('artAndCultureInd', 'artAndCultureInd'), ('economyRajHard', 'economyRajHard'), ('economyRajEasy', 'economyRajEasy'), ('constitutionAndGovernance', 'constitutionAndGovernance'), ('decisionMaking', 'decisionMaking'), ('ndaPhysics', 'ndaPhysics'), ('ndaHistory', 'ndaHistory'), ('ndaChemistry', 'ndaChemistry'), ('ndaMaths', 'ndaMaths'), ('cdsMaths', 'cdsMaths'), ('currentEvents', 'currentEvents'), ('dataAnalysisAndInterpretation', 'dataAnalysisAndInterpretation'), ('financialAwareness', 'financialAwareness'), ('financeAndAccounts', 'financeAndAccounts'), ('statistics', 'statistics'), ('childDevelopmentAndEdu', 'childDevelopmentAndEdu'), ('teachingApt', 'teachingApt'), ('hindi', 'hindi'), ('staticGK', 'staticGK'), ('rpcGKInd', 'rpcGKInd'), ('rpcGKRaj', 'rpcGKRaj'), ('rpcReasoning', 'rpcReasoning'), ('gdQuantApt', 'gdQuantApt'), ('iasMisc', 'iasMisc'), ('jeeMisc', 'jeeMisc'), ('jeeMainsMisc', 'jeeMainsMisc'), ('jeeAdvMisc', 'jeeAdvMisc'), ('neetMisc', 'neetMisc'), ('rasMisc', 'rasMisc'), ('ibpsPOMisc', 'ibpsPOMisc'), ('ibpsClerkMisc', 'ibpsClerkMisc'), ('sscCHSLMisc', 'sscCHSLMisc'), ('sscCGLMisc', 'sscCGLMisc'), ('ndaMisc', 'ndaMisc'), ('cdsMisc', 'cdsMisc'), ('ntpcMisc', 'ntpcMisc'), ('reet1Misc', 'reet1Misc'), ('reet2Misc', 'reet2Misc'), ('patwariMisc', 'patwariMisc'), ('grade2ndMisc', 'grade2ndMisc'), ('grade2ndScienceMisc', 'grade2ndScienceMisc'), ('grade2ndSSMisc', 'grade2ndSSMisc'), ('sscGDMisc', 'sscGDMisc'), ('sscMTSMisc', 'sscMTSMisc'), ('rajPoliceConstMisc', 'rajPoliceConstMisc'), ('rajLDCMisc', 'rajLDCMisc'), ('rrbGDMisc', 'rrbGDMisc'), ('sipaper1Misc', 'sipaper1Misc'), ('sipaper2Misc', 'sipaper2Misc'), ('reet2ScienceMisc', 'reet2ScienceMisc')], default='mathsAdv', max_length=100000)),
                ('questions', models.ManyToManyField(blank=True, related_name='questions', to='Questions.Questions')),
            ],
        ),
        migrations.CreateModel(
            name='ReportedQuestions',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='reported_question', to='Questions.questions')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='reporting_user', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='QuestionsOfTheDays',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50, null=True)),
                ('date', models.CharField(max_length=20, null=True)),
                ('exam', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='quesOfDayExam', to='Questions.exams')),
                ('question', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='questionsOfTheDays', to='Questions.questions')),
            ],
        ),
        migrations.CreateModel(
            name='QuestionBookmarks',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50)),
                ('questions', models.ManyToManyField(blank=True, related_name='bookmarked_questions', to='Questions.Questions')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='bookmarked_user', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Feedback',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50, null=True)),
                ('subject', models.CharField(blank=True, max_length=1000, null=True)),
                ('text', models.TextField(blank=True, null=True)),
                ('user', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='feedbackUser', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.AddField(
            model_name='exams',
            name='subjects',
            field=models.ManyToManyField(blank=True, related_name='subjects', to='Questions.Subjects'),
        ),
        migrations.CreateModel(
            name='DailyQuestions',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50)),
                ('date', models.CharField(max_length=20)),
                ('updateTime', models.IntegerField(blank=True, null=True)),
                ('exam', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='Questions.exams')),
                ('questions', models.ManyToManyField(blank=True, to='Questions.Questions')),
                ('user', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Complaints',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50)),
                ('subject', models.CharField(blank=True, max_length=1000, null=True)),
                ('text', models.TextField(blank=True, null=True)),
                ('user', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='complaintUser', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
