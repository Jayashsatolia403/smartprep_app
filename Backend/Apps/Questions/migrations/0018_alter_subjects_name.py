# Generated by Django 3.2.6 on 2021-09-16 09:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Questions', '0017_auto_20210916_1243'),
    ]

    operations = [
        migrations.AlterField(
            model_name='subjects',
            name='name',
            field=models.CharField(choices=[('physicsAdv', 'physicsAdv'), ('mathsAdv', 'mathsAdv'), ('chemAdv', 'chemAdv'), ('physicsMains', 'physicsMains'), ('mathsMains', 'mathsMains'), ('chemMains', 'chemMains'), ('bio', 'bio'), ('reasoningHard', 'reasoningHard'), ('reasoningEasy', 'reasoningEasy'), ('currentAffairsWorld', 'currentAffairsWorld'), ('currentAffairsIndiaEasy', 'currentAffairsIndiaEasy'), ('currentAffairsIndiaHard', 'currentAffairsIndiaHard'), ('quantApt', 'quantApt'), ('englishLangAndComprehension', 'englishLangAndComprehension'), ('basicComputer', 'basicComputer'), ('mathsGen', 'mathsGen'), ('economyAndBanking', 'economyAndBanking'), ('geographyInd', 'geographyInd'), ('geographyWorld', 'geographyWorld'), ('polityInd', 'polityInd'), ('economyIndGen', 'economyIndGen'), ('economyIndBudgetAndSchemes', 'economyIndBudgetAndSchemes'), ('environmentAndEcology', 'environmentAndEcology'), ('historyInd', 'historyInd'), ('historyWorld', 'historyWorld'), ('InternationalRelationAndSecurity', 'InternationalRelationAndSecurity'), ('sciAndTech', 'sciAndTech'), ('generalScience', 'generalScience'), ('geographyRaj', 'geographyRaj'), ('historyRaj', 'historyRaj'), ('artAndCultureRaj', 'artAndCultureRaj'), ('polityRaj', 'polityRaj'), ('currentAffairsRajHard', 'currentAffairsRajHard'), ('currentAffairsRajEasy', 'currentAffairsRajEasy'), ('artAndCultureInd', 'artAndCultureInd')], default='mathsAdv', max_length=100000),
        ),
    ]