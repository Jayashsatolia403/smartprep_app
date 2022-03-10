from os import readlink
import re
from django.db import models
from django.db.models.fields import BLANK_CHOICE_DASH
from rest_framework.serializers import ModelSerializer
from Apps.User.models import User
from django.contrib.postgres.fields import ArrayField



class Options(models.Model):
    uuid = models.CharField(max_length=50)
    content = models.CharField(max_length=1000)
    isCorrect = models.BooleanField(default=False)

    def __str__(self) -> str:
        return self.content

class Questions(models.Model):
    uuid = models.CharField(max_length=50, null=True, blank=True)
    statement = models.TextField(null=True, blank=True)
    options = models.ManyToManyField(Options, blank=True)
    difficulty = models.FloatField(null=True, blank=True)
    ratings = models.FloatField(null=True, blank=True)
    percentCorrect = models.FloatField(null=True, blank=True)
    seenBy = models.ManyToManyField(User, related_name='seenBy', blank=True)
    createdBy = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    ratedBy = models.ManyToManyField(User, related_name='ratedBy', blank=True)
    created_at = models.DateField(auto_now_add=True, null=True)
    isExpert = models.BooleanField(default=False)
    subject = models.CharField(max_length=50, null=True)
    explaination = models.TextField(null=True, blank=True)
    topic = models.CharField(max_length=50, null=True, blank=True)



    def __str__(self) -> str:
        return self.statement


class Subjects(models.Model):
    choices = [('physicsAdv', 'physicsAdv'),
        ('mathsAdv', 'mathsAdv'),
        ('chemAdv', 'chemAdv'),
        ('physicsMains', 'physicsMains'),
        ('mathsMains', 'mathsMains'),
        ('chemMains', 'chemMains'),
        ('physicsNeet', 'physicsNeet'),
        ('chemNeet', 'chemNeet'),
        ('bio', 'bio'),
        ('reasoningHard', 'reasoningHard'),
        ('reasoningEasy', 'reasoningEasy'),
        ('currentAffairsWorldEasy', 'currentAffairsWorldEasy'),
        ('currentAffairsWorldHard', 'currentAffairsWorldHard'),
        ('currentAffairsIndiaEasy', 'currentAffairsIndiaEasy'),
        ('currentAffairsIndiaHard', 'currentAffairsIndiaHard'),
        ('quantAptHard', 'quantAptHard'),
        ('quantAptEasy', 'quantAptEasy'),
        ('quantAptEasyHindi', 'quantAptEasyHindi'),
        ('englishLangAndComprehensionEasy', 'englishLangAndComprehensionEasy'),
        ('englishLangAndComprehensionHard', 'englishLangAndComprehensionHard'),
        ('basicComputer', 'basicComputer'),
        ('economyAndBanking', 'economyAndBanking'),
        ('geographyIndHard', 'geographyIndHard'),
        ('geographyIndEasy', 'geographyIndEasy'),
        ('geographyWorld', 'geographyWorld'),
        ('polityIndEasy', 'polityIndEasy'),
        ('polityIndHard', 'polityIndHard'),
        ('economyIndGen', 'economyIndGen'),
        ('economyIndBudgetAndSchemes', 'economyIndBudgetAndSchemes'),
        ('environmentAndEcologyEasy', 'environmentAndEcologyEasy'),
        ('environmentAndEcologyHard', 'environmentAndEcologyHard'),
        ('historyIndEasy', 'historyIndEasy'),
        ('historyIndHard', 'historyIndHard'),
        ('historyWorld', 'historyWorld'),
        ('InternationalRelationAndSecurity', 'InternationalRelationAndSecurity'),
        ('sciAndTechEasy', 'sciAndTechEasy'),
        ('sciAndTechHard', 'sciAndTechHard'),
        ('generalScience', 'generalScience'),
        ('geographyRajEasy', 'geographyRajEasy'),
        ('geographyRajHard', 'geographyRajHard'),
        ('historyRajEasy', 'historyRajEasy'),
        ('historyRajHard', 'historyRajHard'),
        ('artAndCultureRaj', 'artAndCultureRaj'),
        ('polityRajHard', 'polityRajHard'),
        ('polityRajEasy', 'polityRajEasy'),
        ('currentAffairsRajHard', 'currentAffairsRajHard'),
        ('currentAffairsRajEasy', 'currentAffairsRajEasy'),
        ('artAndCultureInd', 'artAndCultureInd'),
        ('economyRajHard', 'economyRajHard'),
        ('economyRajEasy', 'economyRajEasy'),
        ('constitutionAndGovernance', 'constitutionAndGovernance'),
        ('decisionMaking', 'decisionMaking'),
        ('ndaHistory', 'ndaHistory'),
        ('ndaMaths', 'ndaMaths'),
        ('cdsMaths', 'cdsMaths'),
        ('currentEvents', 'currentEvents'),
        ('dataAnalysisAndInterpretation', 'dataAnalysisAndInterpretation'),
        ('financialAwareness', 'financialAwareness'),
        ('financeAndAccounts', 'financeAndAccounts'),
        ('statistics', 'statistics'),
        ('childDevelopmentAndEdu', 'childDevelopmentAndEdu'),
        ('teachingApt', 'teachingApt'),
        ('hindi', 'hindi'),
        ('staticGK', 'staticGK'),
        ('sscMTSGK', 'sscMTSGK'),
        ('rpcGKRaj', 'rpcGKRaj'),
        ('sscMTSReasoning', 'sscMTSReasoning'),
        ('gdQuantApt', 'gdQuantApt'),
        ('iasMisc', 'iasMisc'),
        ('jeeMisc', 'jeeMisc'),
        ('jeeMainsMisc', 'jeeMainsMisc'),
        ('jeeAdvMisc', 'jeeAdvMisc'),
        ('neetMisc', 'neetMisc'),
        ('rasMisc', 'rasMisc'),
        ('ibpsPOSSCMisc', 'ibpsPOSSCMisc'),
        ('ndaMisc', 'ndaMisc'),
        ('cdsMisc', 'cdsMisc'),
        ('reet1Misc', 'reet1Misc'),
        ('patwariMisc', 'patwariMisc'),
        ('grade2ndScienceMisc', 'grade2ndScienceMisc'),
        ('sscMTSMisc', 'sscMTSMisc'),
        ('iasMiscHindi', 'iasMiscHindi'),
        ('rasMiscHindi', 'rasMiscHindi'),
        ('sscCGLMiscHindi', 'sscCGLMiscHindi'),
        ('currentAffairsWorldHardHindi', 'currentAffairsWorldHardHindi'),
        ('currentAffairsIndiaEasyHindi', 'currentAffairsIndiaEasyHindi'),
        ('currentAffairsIndiaHardHindi', 'currentAffairsIndiaHardHindi'),
        ('geographyIndEasyHindi', 'geographyIndEasyHindi'),
        ('geographyIndHardHindi', 'geographyIndHardHindi'),
        ('geographyWorldHindi', 'geographyWorldHindi'),
        ('polityIndEasyHindi', 'polityIndEasyHindi'),
        ('polityIndHardHindi', 'polityIndHardHindi'),
        ('economyIndGenHindi', 'economyIndGenHindi'),
        ('economyIndBudgetAndSchemesHindi', 'economyIndBudgetAndSchemesHindi'),
        ('environmentAndEcologyHardHindi', 'environmentAndEcologyHardHindi'),
        ('environmentAndEcologyEasyHindi', 'environmentAndEcologyEasyHindi'),
        ('historyIndEasyHindi', 'historyIndEasyHindi'),
        ('historyIndHardHindi', 'historyIndHardHindi'),
        ('historyWorldHindi', 'historyWorldHindi'),
        ('InternationalRelationAndSecurityHindi', 'InternationalRelationAndSecurityHindi'),
        ('sciAndTechHardHindi', 'sciAndTechHardHindi'),
        ('artAndCultureIndHindi', 'artAndCultureIndHindi'),
        ('constitutionAndGovernanceHindi', 'constitutionAndGovernanceHindi'),
        ('decisionMakingHindi', 'decisionMakingHindi'),
        ('currentAffairsWorldEasyHindi', 'currentAffairsWorldEasyHindi'),
        ('sciAndTechEasyHindi', 'sciAndTechEasyHindi'),
        ('geographyRajEasyHindi', 'geographyRajEasyHindi'),
        ('geographyRajHardHindi', 'geographyRajHardHindi'),
        ('historyRajHardHindi', 'historyRajHardHindi'),
        ('historyRajEasyHindi', 'historyRajEasyHindi'),
        ('artAndCultureRajHindi', 'artAndCultureRajHindi'),
        ('polityRajEasyHindi', 'polityRajEasyHindi'),
        ('polityRajHardHindi', 'polityRajHardHindi'),
        ('currentAffairsRajHardHindi', 'currentAffairsRajHardHindi'),
        ('currentAffairsRajEasyHindi', 'currentAffairsRajEasyHindi'),
        ('economyRajHardHindi', 'economyRajHardHindi'),
        ('economyRajEasyHindi', 'economyRajEasyHindi'),
        ('reasoningHardHindi', 'reasoningHardHindi'),
        ('reasoningEasyHindi', 'reasoningEasyHindi'),
        ('quantAptHardHindi', 'quantAptHardHindi'),
        ('ibpsClerkSSCMisc', 'ibpsClerkSSCMisc'),
        ('statisticsHindi', 'statisticsHindi'),
        ('bioHindi', 'bioHindi'),
        ('physicsHindi', 'physicsHindi'),
        ('chemHindi', 'chemHindi')]

    uuid = models.CharField(max_length=50)
    name = models.CharField(max_length=100000, choices=choices, default='mathsAdv')
    questions = models.ManyToManyField(Questions, related_name='questions', blank=True)

    def __str__(self) -> str:
        return self.name




class Exams(models.Model):
    choices = [("ias", "ias"),("iasHindi", "iasHindi"), ("jee", "jee"),("jeeMains","jeeMains"),("jeeAdv","jeeAdv"),("neet","neet"),
               ("ras","ras"), ("rasHindi","rasHindi"), ("ibpsPO","ibpsPO"), ("ibpsClerk", "ibpsClerk"), ("sscCHSL", "sscCHSL"),
               ("sscCGL", "sscCGL"), ("sscCGLHindi", "sscCGLHindi"), ("nda","nda"), ("cds","cds"), ("ntpc","ntpc"), 
               ("reet1", "reet1"), ("reet2", "reet2"), ("reet2Science", "reet2Science"), 
               ("patwari", 'patwari'), ("grade2nd", "grade2nd"),
               ("grade2ndScience", "grade2ndScience"), ("grade2ndSS", "grade2ndSS"), ("sscGD", "sscGD"), ("sscMTS", "sscMTS"),
               ("rajPoliceConst", "rajPoliceConst"), ("rajLDC", "rajLDC"), ("rrbGD", "rrbGD"), 
               ("sipaper1", "sipaper1"), ("sipaper2", "sipaper2")]

    uuid =  models.CharField(max_length=50)
    name = models.CharField(max_length=20, choices=choices, null=True, blank=True)
    subjects = models.ManyToManyField(Subjects, related_name="subjects", blank=True)

    def __str__(self) -> str:
        return self.name 





class QuestionsOfTheDays(models.Model):
    uuid =  models.CharField(max_length=50, null=True)
    question = models.ForeignKey(Questions, related_name="questionsOfTheDays", blank=True, on_delete=models.CASCADE, null=True)
    date = models.CharField(max_length=20, null=True)
    exam = models.ForeignKey(Exams, related_name="quesOfDayExam", blank=True, on_delete=models.CASCADE, null=True)


class DailyQuestions(models.Model):
    uuid = models.CharField(max_length=50)
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    questions = models.ManyToManyField(Questions, blank=True)
    date = models.CharField(max_length=20)
    exam = models.ForeignKey(Exams, on_delete=models.CASCADE, blank=True, null=True)
    updateTime = models.IntegerField(null=True, blank=True)

class QuestionBookmarks(models.Model):
    uuid = models.CharField(max_length=50)
    user = models.OneToOneField(User, related_name="bookmarked_user", on_delete=models.CASCADE)
    questions = models.ManyToManyField(Questions, related_name="bookmarked_questions", blank=True)



class WeeklyCompetitions(models.Model):
    uuid = models.CharField(max_length=50)
    questions = models.ManyToManyField(Questions, related_name="competition_questions", blank=True)
    name = models.CharField(max_length=100)
    round = models.IntegerField(default=0)
    date = models.DateField(auto_now_add=True)
    exam = models.ForeignKey(Exams, related_name="competitions_exams", on_delete=models.CASCADE, blank=True, null=True)

    def __str__(self) -> str:
        return self.name 



class Submissions(models.Model):
    uuid = models.CharField(max_length=50)
    user = models.ForeignKey(User, related_name="submissionUser", on_delete=models.CASCADE)
    question = models.ForeignKey(Questions, related_name="submissionQuestion", on_delete=models.CASCADE)
    selected_options = models.ManyToManyField(Options, related_name="submissionSelectedOptions", blank=True)

    


class WeeklyCompetitionResult(models.Model):
    user = models.ForeignKey(User, related_name="resultUser", on_delete=models.CASCADE)
    competition = models.ForeignKey(WeeklyCompetitions, related_name='weeklyCompetitions', on_delete=models.CASCADE)
    submissions = models.ManyToManyField(Submissions, related_name="weeklyCompetitionSubmissions", blank=True)
    correct_options = models.IntegerField(default=0)

    def __str__(self) -> str:
        return self.competition.name


class ReportedQuestions(models.Model):
    question = models.ForeignKey(Questions, related_name="reported_question", on_delete=models.CASCADE)
    user = models.ForeignKey(User, related_name="reporting_user", on_delete=models.CASCADE)


class Feedback(models.Model):
    uuid = models.CharField(max_length=50, null=True)
    subject = models.CharField(max_length=1000, null=True, blank=True)
    text = models.TextField(null=True, blank=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="feedbackUser", null=True, blank=True)


class Complaints(models.Model):
    uuid = models.CharField(max_length=50)
    subject = models.CharField(max_length=1000, null=True, blank=True)
    text = models.TextField(null=True, blank=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="complaintUser", null=True, blank=True)