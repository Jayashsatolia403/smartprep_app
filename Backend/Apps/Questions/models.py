from django.db import models
from Apps.User.models import User
from django.contrib.postgres.fields import ArrayField



class Options(models.Model):
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



    def __str__(self) -> str:
        return self.statement


class Subjects(models.Model):
    choices = [("physicsAdv", "physicsAdv"), 
            ("mathsAdv","mathsAdv"),
            ("chemAdv","chemAdv"),
            ("physicsMains","physicsMains"), 
            ("mathsMains", "mathsMains"),
            ("chemMains","chemMains"),
            ("bio", "bio"),
            ("reasoningHard", "reasoningHard"),
            ("reasoningEasy","reasoningEasy"),
            ("currentAffairsWorld", "currentAffairsWorld"),
            ("currentAffairsIndiaEasy", "currentAffairsIndiaEasy"),
            ("currentAffairsIndiaHard", "currentAffairsIndiaHard"),
            ("quantAptHard", "quantAptHard"),
            ("quantAptEasy", "quantAptEasy"),
            ("englishLangAndComprehension","englishLangAndComprehension"),
            ("basicComputer", "basicComputer"),
            ("economyAndBanking", "economyAndBanking"), 
            ("geographyIndHard", "geographyIndHard"),
            ("geographyIndEasy", "geographyIndEasy"),
            ("geographyWorld","geographyWorld"),
            ("polityIndEasy", "polityIndEasy"),
            ("polityIndHard", "polityIndHard"),
            ("economyIndGen", "economyIndGen"),
            ("economyIndBudgetAndSchemes", "economyIndBudgetAndSchemes"),
            ("environmentAndEcologyEasy","environmentAndEcologyEasy"),
            ("environmentAndEcologyHard","environmentAndEcologyHard"),
            ("historyIndEasy", "historyIndEasy"),
            ("historyIndHard", "historyIndHard"),
            ("historyWorld", "historyWorld"),
            ("InternationalRelationAndSecurity", "InternationalRelationAndSecurity"),
            ("sciAndTechEasy","sciAndTechEasy"), 
            ("sciAndTechHard","sciAndTechHard"), 
            ("generalScience", "generalScience"), 
            ("geographyRajEasy", "geographyRajEasy"),
            ("geographyRajHard", "geographyRajHard"),
            ("historyRajEasy", "historyRajEasy"), 
            ("historyRajHard", "historyRajHard"), 
            ("artAndCultureRaj", "artAndCultureRaj"), 
            ("polityRajHard", "polityRajHard"),
            ("polityRajEasy", "polityRajEasy"),
            ("currentAffairsRajHard", "currentAffairsRajHard"), 
            ("currentAffairsRajEasy", "currentAffairsRajEasy"),
            ("artAndCultureInd", "artAndCultureInd"), 
            ("economyRajHard", "economyRajHard"), 
            ("economyRajEasy", "economyRajEasy"), 
            ("constitutionAndGovernance", "constitutionAndGovernance"), 
            ("decisionMaking","decisionMaking"),
            ("ndaPhysics", "ndaPhysics"),
            ("ndaHistory", "ndaHistory"),
            ("ndaChemistry","ndaChemistry"),
            ("ndaMaths","ndaMaths"),
            ("cdsMaths","cdsMaths"),
            ("currentEvents", "currentEvents"),
            ("dataAnalysisAndInterpretation", "dataAnalysisAndInterpretation"),
            ("financialAwareness", "financialAwareness"),
            ("financeAndAccounts", "financeAndAccounts"),
            ("statistics","statistics")]


    name = models.CharField(max_length=100000, choices=choices, default='mathsAdv')
    questions = models.ManyToManyField(Questions, related_name='questions', blank=True)

    def __str__(self) -> str:
        return self.name




class Exams(models.Model):
    choices = [("ias", "ias"),("jee", "jee"),("jeeMains","jeeMains"),("jeeAdv","jeeAdv"),("neet","neet"),
               ("ras","ras"), ("ibpsPO","ibpsPO"), ("ibpsClerk", "ibpsClerk"), ("sscCHSL", "sscCHSL"),
               ("sscCGL", "sscCGL"), ("nda","nda"), ("cds","cds"), ("cat","cat"), ("ntpc","ntpc")]

    name = models.CharField(max_length=20, choices=choices, null=True, blank=True)
    subjects = models.ManyToManyField(Subjects, related_name="subjects", blank=True)

    def __str__(self) -> str:
        return self.name 





class QuestionsOfTheDays(models.Model):
    questions = models.ManyToManyField(Questions, related_name="questionsOfTheDays", blank=True)
    date = models.CharField(max_length=20)

class PrevQuesOfDays(models.Model):
    question = models.ForeignKey(Questions, on_delete=models.CASCADE, null=True, blank=True)


class DailyQuestions(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    questions = models.ManyToManyField(Questions, blank=True)
    date = models.CharField(max_length=20)
    exam = models.ForeignKey(Exams, on_delete=models.CASCADE, blank=True, null=True)
    updateTime = models.IntegerField(null=True, blank=True)
    


class PracticeQuestions(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    questions = models.ManyToManyField(Questions, related_name="practiceQuestions", blank=True)
    skippedQuestions = ArrayField(models.CharField(max_length=50, null=True, blank=True), null=True, blank=True)
    correctQuestions = ArrayField(models.CharField(max_length=50, blank=True, null=True), blank=True, null=True)
    wrongQuestions = ArrayField(models.CharField(max_length=50, null=True, blank=True), null=True, blank=True)
    unansweredQuesions = ArrayField(models.CharField(max_length=50, null=True, blank=True), blank=True, null=True)


class QuestionBookmarks(models.Model):
    user = models.OneToOneField(User, related_name="bookmarked_user", on_delete=models.CASCADE)
    questions = models.ManyToManyField(Questions, related_name="bookmarked_questions", blank=True)



class WeeklyCompetitions(models.Model):
    uuid = models.CharField(max_length=50)
    questions = models.ManyToManyField(Questions, related_name="competition_questions", blank=True)
    name = models.CharField(max_length=100)
    round = models.IntegerField(default=0)
    date_time = models.DateTimeField(auto_now_add=True)
    exam = models.ManyToManyField(Exams, related_name="competitions_exams", blank=True)