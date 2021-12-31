# Generated by Django 3.2.9 on 2021-12-31 22:42

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('Questions', '0004_auto_20211229_1932'),
    ]

    operations = [
        migrations.AlterField(
            model_name='exams',
            name='name',
            field=models.CharField(blank=True, choices=[('ias', 'ias'), ('jee', 'jee'), ('jeeMains', 'jeeMains'), ('jeeAdv', 'jeeAdv'), ('neet', 'neet'), ('ras', 'ras'), ('ibpsPO', 'ibpsPO'), ('ibpsClerk', 'ibpsClerk'), ('sscCHSL', 'sscCHSL'), ('sscCGL', 'sscCGL'), ('nda', 'nda'), ('cds', 'cds'), ('ntpc', 'ntpc'), ('reet1', 'reet1'), ('reet2', 'reet2'), ('patwati', 'patwari'), ('grade2nd', 'grade2nd'), ('grade2ndScience', 'grade2ndScience'), ('grade2ndSS', 'grade2ndSS'), ('sscGD', 'sscGD'), ('sscMTS', 'sscMTS'), ('rajPoliceConst', 'rajPoliceConst'), ('rajLDC', 'rajLDC'), ('rrbGD', 'rrbGD'), ('sipaper1', 'sipaper1'), ('sipaper2', 'sipaper2')], max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='subjects',
            name='name',
            field=models.CharField(choices=[('physicsAdv', 'physicsAdv'), ('mathsAdv', 'mathsAdv'), ('chemAdv', 'chemAdv'), ('physicsMains', 'physicsMains'), ('mathsMains', 'mathsMains'), ('chemMains', 'chemMains'), ('bio', 'bio'), ('reasoningHard', 'reasoningHard'), ('reasoningEasy', 'reasoningEasy'), ('currentAffairsWorldEasy', 'currentAffairsWorldEasy'), ('currentAffairsWorldHard', 'currentAffairsWorldHard'), ('currentAffairsIndiaEasy', 'currentAffairsIndiaEasy'), ('currentAffairsIndiaHard', 'currentAffairsIndiaHard'), ('quantAptHard', 'quantAptHard'), ('quantAptEasy', 'quantAptEasy'), ('englishLangAndComprehensionEasy', 'englishLangAndComprehensionEasy'), ('englishLangAndComprehensionHard', 'englishLangAndComprehensionHard'), ('basicComputer', 'basicComputer'), ('economyAndBanking', 'economyAndBanking'), ('geographyIndHard', 'geographyIndHard'), ('geographyIndEasy', 'geographyIndEasy'), ('geographyWorld', 'geographyWorld'), ('polityIndEasy', 'polityIndEasy'), ('polityIndHard', 'polityIndHard'), ('economyIndGen', 'economyIndGen'), ('economyIndBudgetAndSchemes', 'economyIndBudgetAndSchemes'), ('environmentAndEcologyEasy', 'environmentAndEcologyEasy'), ('environmentAndEcologyHard', 'environmentAndEcologyHard'), ('historyIndEasy', 'historyIndEasy'), ('historyIndHard', 'historyIndHard'), ('historyWorld', 'historyWorld'), ('InternationalRelationAndSecurity', 'InternationalRelationAndSecurity'), ('sciAndTechEasy', 'sciAndTechEasy'), ('sciAndTechHard', 'sciAndTechHard'), ('generalScience', 'generalScience'), ('geographyRajEasy', 'geographyRajEasy'), ('geographyRajHard', 'geographyRajHard'), ('historyRajEasy', 'historyRajEasy'), ('historyRajHard', 'historyRajHard'), ('artAndCultureRaj', 'artAndCultureRaj'), ('polityRajHard', 'polityRajHard'), ('polityRajEasy', 'polityRajEasy'), ('currentAffairsRajHard', 'currentAffairsRajHard'), ('currentAffairsRajEasy', 'currentAffairsRajEasy'), ('artAndCultureInd', 'artAndCultureInd'), ('economyRajHard', 'economyRajHard'), ('economyRajEasy', 'economyRajEasy'), ('constitutionAndGovernance', 'constitutionAndGovernance'), ('decisionMaking', 'decisionMaking'), ('ndaPhysics', 'ndaPhysics'), ('ndaHistory', 'ndaHistory'), ('ndaChemistry', 'ndaChemistry'), ('ndaMaths', 'ndaMaths'), ('cdsMaths', 'cdsMaths'), ('currentEvents', 'currentEvents'), ('dataAnalysisAndInterpretation', 'dataAnalysisAndInterpretation'), ('financialAwareness', 'financialAwareness'), ('financeAndAccounts', 'financeAndAccounts'), ('statistics', 'statistics'), ('childDevelopmentAndEdu', 'childDevelopmentAndEdu'), ('teachingApt', 'teachingApt'), ('hindi', 'hindi'), ('staticGK', 'staticGK'), ('rpcGKInd', 'rpcGKInd'), ('rpcGKRaj', 'rpcGKRaj'), ('rpcReasoning', 'rpcReasoning'), ('gdQuantApt', 'gdQuantApt')], default='mathsAdv', max_length=100000),
        ),
        migrations.CreateModel(
            name='ReportedQuestions',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('questions', models.ManyToManyField(blank=True, related_name='reportedQuestions', to='Questions.Questions')),
            ],
        ),
        migrations.CreateModel(
            name='Feedback',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('uuid', models.CharField(max_length=50, null=True)),
                ('text', models.TextField(blank=True, null=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='feedbackUser', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
