# Generated by Django 3.2.9 on 2021-12-11 15:37

from __future__ import unicode_literals

from django.db import migrations, models

import random
import uuid

from Apps.Questions.models import Questions


def load_initial_data(apps, schema_editor):

    iasSubjects = ["currentAffairsWorld", 
                   "currentAffairsIndiaEasy", 
                   "currentAffairsIndiaHard", 
                   "geographyIndEasy", 
                   "geographyIndHard", 
                   "geographyWorld",
                   "polityIndEasy", 
                   "polityIndHard", 
                   "economyIndGen", 
                   "economyIndBudgetAndSchemes", 
                   "environmentAndEcologyHard", 
                   "environmentAndEcologyEasy", 
                   "historyIndEasy",
                   "historyIndHard",
                   "historyWorld",
                   "InternationalRelationAndSecurity", 
                   "sciAndTechHard", 
                   "artAndCultureInd", 
                   "constitutionAndGovernance",
                   "decisionMaking"]
    
    jeeSubjects = ["physicsAdv", "mathsAdv", "chemAdv", "physicsMains", "mathsMains", "chemMains"]
    jeeAdvSubjects = ["physicsAdv", "mathsAdv", "chemAdv"]
    jeeMainsSubjects = ["physicsMains", "mathsMains", "chemMains"]

    neetSubjects = ["physicsMains", "bio", "chemMains"]

    rasSubjects = ["currentAffairsIndiaEasy", 
                    "currentAffairsIndiaHard", 
                    "geographyIndEasy", 
                    "geographyWorld",
                    "polityIndEasy",
                    "geographyIndHard", 
                    "polityIndHard", 
                    "economyIndGen", 
                    "economyIndBudgetAndSchemes",
                    "environmentAndEcologyHard", 
                    "environmentAndEcologyEasy", 
                    "historyIndEasy",
                    "historyIndHard",
                    "sciAndTechEasy", 
                    "sciAndTechHard", 
                    "artAndCultureInd", 
                    "constitutionAndGovernance",
                    "geographyRajEasy", 
                    "geographyRajHard", 
                    "historyRajHard", 
                    "historyRajEasy", 
                    "artAndCultureRaj", 
                    "polityRajEasy", 
                    "polityRajHard", 
                    "currentAffairsRajHard",
                    "currentAffairsRajEasy", 
                    "artAndCultureInd", 
                    "economyRajHard",
                    "economyRajEasy",
                    "reasoningHard", 
                    "reasoningEasy"]

    ndaSubjects = ["ndaPhysics", 
                    "ndaHistory", 
                    "ndaChemistry", 
                    "ndaMaths", 
                    "currentEvents"]

    cdsSubjects = ["reasoningEasy", 
                    "reasoningHard", 
                    "currentAffairsIndiaEasy", 
                    "englishLangAndComprehension",
                    "geographyIndEasy", 
                    "polityIndEasy", 
                    "historyIndEasy", 
                    "sciAndTechEasy", 
                    "cdsMaths", 
                    "environmentAndEcologyEasy"]

    ibpsPOSubjects = ["englishLangAndComprehension", 
                        "quantAptHard", 
                        "reasoningHard", 
                        "reasoningEasy", 
                        "economyAndBanking",
                        "dataAnalysisAndInterpretation", 
                        "financialAwareness",
                        "basicComputer",
                        "financeAndAccounts"]

    ibpsClerkSubjects = ["englishLangAndComprehension", 
                            "quantAptEasy", 
                            "quantAptHard",
                            "reasoningEasy", 
                            "financialAwareness",
                            "basicComputer",
                            "financeAndAccounts"]

    sscCGLSubjects = ["reasoningHard", 
                        "reasoningEasy", 
                        "historyIndEasy", 
                        "currentAffairsIndiaEasy", 
                        "geographyIndEasy",
                        "polityIndEasy",
                        "quantAptEasy",
                        "englishLangAndComprehension",
                        "financeAndAccounts",
                        "statistics"]

    sscCHSLSubjects = ["reasoningHard", 
                        "reasoningEasy", 
                        "historyIndEasy", 
                        "currentAffairsIndiaEasy", 
                        "geographyIndEasy",
                        "polityIndEasy",
                        "quantAptEasy",
                        "englishLangAndComprehension"]

    ntpcSubjects = ["reasoningHard", 
            "reasoningEasy", 
            "historyIndEasy", 
            "currentAffairsIndiaEasy", 
            "geographyIndEasy",
            "polityIndEasy",
            "quantAptEasy",
            "englishLangAndComprehension"]

    catSubjects = ["reasoningHard"]

    exams = [("ias", "ias"),("jee", "jee"),("jeeMains","jeeMains"),("jeeAdv","jeeAdv"),("neet","neet"),
            ("ras","ras"), ("ibpsPO","ibpsPO"), ("ibpsClerk", "ibpsClerk"), ("sscCHSL", "sscCHSL"),
            ("sscCGL", "sscCGL"), ("nda","nda"), ("cds","cds"), ("cat","cat"), ("ntpc","ntpc")]

    subjects = [("physicsAdv", "physicsAdv"), 
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

    Questions = apps.get_model('Questions', 'Questions')
    Subjects = apps.get_model('Questions', 'Subjects')
    Options = apps.get_model('Questions', 'Options')
    Exams = apps.get_model('Questions', 'Exams')

    for i in subjects:
        subject = Subjects(name=i[0])
        subject.save()

    
    d = {"ias": iasSubjects, "jee": jeeSubjects, "jeeMains": jeeMainsSubjects, "jeeAdv": jeeAdvSubjects,
         "neet": neetSubjects, "ras": rasSubjects, "nda": ndaSubjects, "cds": cdsSubjects, "ibpsPO": ibpsPOSubjects,
         "ibpsClerk": ibpsClerkSubjects, "sscCGL": sscCGLSubjects, "sscCHSL": sscCHSLSubjects, "ntpc": ntpcSubjects, "cat": catSubjects}

    
    for i in exams:
        exam = Exams(name=i[0])
        exam.save()

    
    allExams = Exams.objects.all()


    for exam in allExams:
        for i in d[str(exam.name)]:
            subject = Subjects.objects.get(name = i)
            exam.subjects.add(subject)
            exam.save()

    correctOptions = [True, False, False, False]

    maths_file = open(r"/app/maths.txt")

    good_data = []

    while True:
        statement = maths_file.readline()
        
        if not statement:
            break
        else:
            a = maths_file.readline()
            b = maths_file.readline()
            c = maths_file.readline()
            d = maths_file.readline()


        data = {"options" : [a, b, c, d],
                'statement' : statement}

        good_data.append(data)

        maths_file.readline()
        maths_file.readline()

    for i in subjects:

        random.shuffle(correctOptions)
        random.shuffle(good_data)

        for data in good_data:

            a = Options(
                content= data["options"][0],
                isCorrect=correctOptions[0]
            )
            a.save()

            b = Options(
                content=data["options"][1],
                isCorrect=correctOptions[1]
            )
            b.save()

            c = Options(
                content=data["options"][2],
                isCorrect=correctOptions[2]
            )
            c.save()

            d = Options(
                content=data["options"][3],
                isCorrect=correctOptions[3]
            )
            d.save()


            question = Questions(
                uuid=str(uuid.uuid4()),
                statement=data["statement"],
                subject=i[0],
                ratings=5,
                isExpert=True,
                difficulty=5
            )

            question.save()

            question.options.add(a)
            question.options.add(b)
            question.options.add(c)
            question.options.add(d)

            question.save()

            subject = Subjects.objects.get(name=i[0])

            subject.questions.add(question)
            subject.save()

            question.save()

    
    

    



class Migration(migrations.Migration):

    dependencies = [
        ('Questions', '0002_initial'),
    ]

    operations = [
        migrations.RunPython(load_initial_data)
    ]
