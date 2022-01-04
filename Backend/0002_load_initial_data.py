# Generated by Django 3.2.9 on 2021-12-25 13:14

from __future__ import unicode_literals

from django.db import migrations

import random
import uuid



def load_initial_data(apps, schema_editor):

    iasSubjects = ["currentAffairsWorldHard", 
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
                   "decisionMaking",
                   "iasMisc"]
    
    jeeSubjects = ["physicsAdv", "mathsAdv", "chemAdv", "physicsMains", "mathsMains", "chemMains", "jeeMisc"]
    jeeAdvSubjects = ["physicsAdv", "mathsAdv", "chemAdv", "jeeAdvMisc"]
    jeeMainsSubjects = ["physicsMains", "mathsMains", "chemMains", "jeeMainsMisc"]

    neetSubjects = ["physicsMains", "bio", "chemMains", "neetMisc"]

    rasSubjects = ["currentAffairsIndiaEasy", 
                    "currentAffairsIndiaHard", 
                    "currentAffairsWorldEasy", 
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
                    "reasoningEasy",
                    "rasMisc"]

    ndaSubjects = ["ndaPhysics", 
                    "ndaHistory", 
                    "ndaChemistry", 
                    "ndaMaths", 
                    "currentEvents",
                    "ndaMisc"]

    cdsSubjects = ["reasoningEasy", 
                    "reasoningHard", 
                    "currentAffairsIndiaEasy", 
                    "englishLangAndComprehensionHard",
                    "englishLangAndComprehensionEasy",
                    "geographyIndEasy", 
                    "polityIndEasy", 
                    "historyIndEasy", 
                    "sciAndTechEasy", 
                    "cdsMaths", 
                    "environmentAndEcologyEasy",
                    "cdsMisc"]

    ibpsPOSubjects = ["englishLangAndComprehensionHard", 
                        "quantAptHard", 
                        "reasoningHard", 
                        "reasoningEasy", 
                        "economyAndBanking",
                        "dataAnalysisAndInterpretation", 
                        "financialAwareness",
                        "basicComputer",
                        "financeAndAccounts",
                        "ibpsPOMisc"]

    ibpsClerkSubjects = ["englishLangAndComprehensionEasy",
                            "englishLangAndComprehensionHard", 
                            "quantAptEasy", 
                            "quantAptHard",
                            "reasoningEasy", 
                            "financialAwareness",
                            "basicComputer",
                            "financeAndAccounts",
                            "ibpsClerkMisc"]

    sscCGLSubjects = ["reasoningHard", 
                        "reasoningEasy", 
                        "historyIndEasy", 
                        "currentAffairsIndiaEasy", 
                        "geographyIndEasy",
                        "polityIndEasy",
                        "quantAptEasy",
                        "englishLangAndComprehensionHard",
                        "englishLangAndComprehensionEasy",
                        "financeAndAccounts",
                        "statistics",
                        "sscCGLMisc"]

    sscCHSLSubjects = ["reasoningHard", 
                        "reasoningEasy", 
                        "historyIndEasy", 
                        "currentAffairsIndiaEasy", 
                        "geographyIndEasy",
                        "polityIndEasy",
                        "quantAptEasy",
                        "englishLangAndComprehensionEasy",
                        "englishLangAndComprehensionHard",
                        "sscCHSLMisc"
                        ]

    ntpcSubjects = ["reasoningHard", 
            "reasoningEasy", 
            "historyIndEasy", 
            "currentAffairsIndiaEasy", 
            "geographyIndEasy",
            "polityIndEasy",
            "quantAptEasy",
            "englishLangAndComprehensionEasy",
            "ntpcMisc"]



    reet1Subjects = [
            "reet1Misc",
            "childDevelopmentAndEdu",
            "hindi",
            "englishLangAndComprehensionEasy",
            "quantAptEasy",
            "generalScience"]

    reet2Subjects = [
            "reet2Misc",
            "childDevelopmentAndEdu",
            "hindi",
            "englishLangAndComprehensionEasy",
            "staticGK",
            "geographyIndEasy", 
            "geographyWorld",
            "polityIndEasy",
            "geographyIndHard", 
            "polityIndHard", 
            "economyIndGen", 
            "historyIndEasy",
            "historyIndHard",
            "artAndCultureInd", 
            "constitutionAndGovernance",
            "geographyRajHard", 
            "historyRajHard", 
            "artAndCultureRaj", 
            "polityRajHard", 
            "currentAffairsRajHard",
            "artAndCultureInd", 
            "grade2ndSSMisc"]

    reet2ScienceSubjects = [
            "reet2ScienceMisc",
            "quantAptEasy",
            "quantAptHard",
            "childDevelopmentAndEdu",
            "hindi",
            "englishLangAndComprehensionEasy",
            "bio", 
            "grade2ndScienceMisc",
            "generalScience"
    ]



    sipaper1Subjects = ["hindi"]

    sipaper2Subjects = [
            "reasoningEasy",
            "reasoningHard",
            "quantAptEasy",
            "currentAffairsIndiaEasy",
            "currentAffairsRajHard",
            "currentAffairsRajEasy",
            "currentAffairsWorldEasy",
            "geographyIndEasy",
            "polityIndEasy",
            "economyIndGen",
            "economyIndBudgetAndSchemes",
            "historyIndEasy",
            "generalScience",
            "geographyRajEasy",
            "geographyRajHard",
            "historyRajEasy",
            "historyRajHard",
            "artAndCultureRaj",
            "economyRajHard",
            "economyRajEasy",
            "sipaper2Misc"
    ]

    patwariSubjects = [
            "hindi",
            "reasoningEasy",
            "reasoningHard",
            "quantAptEasy",
            "currentAffairsIndiaEasy",
            "currentAffairsRajHard",
            "currentAffairsRajEasy",
            "currentAffairsWorldEasy",
            "englishLangAndComprehensionEasy",
            "basicComputer",
            "geographyIndEasy",
            "polityIndEasy",
            "economyIndGen",
            "economyIndBudgetAndSchemes",
            "historyIndEasy",
            "generalScience",
            "geographyRajEasy",
            "geographyRajHard",
            "historyRajEasy",
            "historyRajHard",
            "artAndCultureRaj",
            "economyRajHard",
            "economyRajEasy",
            "patwariMisc"
    ]

    grade2ndSubjects = [
            "teachingApt",
            "currentAffairsIndiaEasy",
            "currentAffairsRajHard",
            "currentAffairsRajEasy",
            "currentAffairsWorldEasy",
            "geographyIndEasy",
            "polityIndEasy",
            "economyIndGen",
            "economyIndBudgetAndSchemes",
            "historyIndEasy",
            "generalScience",
            "geographyRajEasy",
            "geographyRajHard",
            "historyRajEasy",
            "historyRajHard",
            "artAndCultureRaj",
            "economyRajHard",
            "economyRajEasy",
            "grade2ndMisc"
    ]

    grade2ndScienceSubjects = ["bio", "physicsMains", "chemMains", "grade2ndScienceMisc"]

    grade2ndSSSubjects = [
            "staticGK",
            "geographyIndEasy", 
            "geographyWorld",
            "polityIndEasy",
            "geographyIndHard", 
            "polityIndHard", 
            "economyIndGen", 
            "historyIndEasy",
            "historyIndHard",
            "artAndCultureInd", 
            "constitutionAndGovernance",
            "geographyRajHard", 
            "historyRajHard", 
            "artAndCultureRaj", 
            "polityRajHard", 
            "currentAffairsRajHard",
            "artAndCultureInd", 
            "grade2ndSSMisc"
    ]

    sscGDSubjects = [
            "rpcGKInd",
            "hindi",
            "rpcReasoning",
            "gdQuantApt",
            "sscGDMisc"
    ]

    sscMTSSubjects = [
            "gdQuantApt",
            "rpcGKInd",
            "rpcReasoning",
            "englishLangAndComprehensionEasy",
            "sscMTSMisc"
    ]

    rajPoliceConstSubjects = [
            "rpcGKInd",
            "rpcReasoning",
            "rpcGKRaj",
            "basicComputer",
            "rajPoliceConstMisc"
    ]

    rajLDCSubjects = [
            "hindi",
            "reasoningEasy",
            "reasoningHard",
            "quantAptEasy",
            "currentAffairsIndiaEasy",
            "currentAffairsRajHard",
            "currentAffairsRajEasy",
            "currentAffairsWorldEasy",
            "englishLangAndComprehensionEasy",
            "basicComputer",
            "geographyIndEasy",
            "polityIndEasy",
            "economyIndGen",
            "economyIndBudgetAndSchemes",
            "historyIndEasy",
            "generalScience",
            "geographyRajEasy",
            "geographyRajHard",
            "historyRajEasy",
            "historyRajHard",
            "artAndCultureRaj",
            "economyRajHard",
            "economyRajEasy",
            "rajLDCMisc"
    ]

    rrbGDSubjects = [
            "gdQuantApt",
            "rpcGKInd",
            "rpcReasoning",
            "rrbGDMisc"
    ]


    exams = [("ias", "ias"),("jee", "jee"),("jeeMains","jeeMains"),("jeeAdv","jeeAdv"),("neet","neet"),
               ("ras","ras"), ("ibpsPO","ibpsPO"), ("ibpsClerk", "ibpsClerk"), ("sscCHSL", "sscCHSL"),
               ("sscCGL", "sscCGL"), ("nda","nda"), ("cds","cds"), ("ntpc","ntpc"), 
               ("reet1", "reet1"), ("reet2", "reet2"), ("reet2Science", "reet2Science"), ("patwari", 'patwari'), ("grade2nd", "grade2nd"), 
               ("grade2ndScience", "grade2ndScience"), ("grade2ndSS", "grade2ndSS"), ("sscGD", "sscGD"), ("sscMTS", "sscMTS"),
               ("rajPoliceConst", "rajPoliceConst"), ("rajLDC", "rajLDC"), ("rrbGD", "rrbGD"), ("sipaper1", "sipaper1"), ("sipaper2", "sipaper2")]

    subjects = [("physicsAdv", "physicsAdv"), 
            ("mathsAdv","mathsAdv"),
            ("chemAdv","chemAdv"),
            ("physicsMains","physicsMains"), 
            ("mathsMains", "mathsMains"),
            ("chemMains","chemMains"),
            ("bio", "bio"),
            ("reasoningHard", "reasoningHard"),
            ("reasoningEasy","reasoningEasy"),
            ("currentAffairsWorldEasy", "currentAffairsWorldEasy"),
            ("currentAffairsWorldHard", "currentAffairsWorldHard"),
            ("currentAffairsIndiaEasy", "currentAffairsIndiaEasy"),
            ("currentAffairsIndiaHard", "currentAffairsIndiaHard"),
            ("quantAptHard", "quantAptHard"),
            ("quantAptEasy", "quantAptEasy"),
            ("englishLangAndComprehensionEasy","englishLangAndComprehensionEasy"),
            ("englishLangAndComprehensionHard","englishLangAndComprehensionHard"),
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
            ("statistics","statistics"),
            ("childDevelopmentAndEdu", "childDevelopmentAndEdu"),
            ("teachingApt", "teachingApt"),
            ("hindi", "hindi"),
            ("staticGK", "staticGK"),
            ("rpcGKInd", "rpcGKInd"),
            ("rpcGKRaj", "rpcGKRaj"),
            ("rpcReasoning", "rpcReasoning"),
            ('gdQuantApt', "gdQuantApt"),
            ("iasMisc", "iasMisc"),
            ("jeeMisc", "jeeMisc"),
            ("jeeMainsMisc", "jeeMainsMisc"),
            ("jeeAdvMisc", "jeeAdvMisc"),
            ("neetMisc", "neetMisc"),
            ("rasMisc", "rasMisc"),
            ("ibpsPOMisc", "ibpsPOMisc"),
            ("ibpsClerkMisc", "ibpsClerkMisc"),
            ("sscCHSLMisc", "sscCHSLMisc"),
            ("sscCGLMisc", "sscCGLMisc"),
            ("ndaMisc", "ndaMisc"),
            ("cdsMisc", "cdsMisc"),
            ("ntpcMisc", "ntpcMisc"),
            ("reet1Misc", "reet1Misc"),
            ("reet2Misc", "reet2Misc"),
            ("patwariMisc", "patwariMisc"),
            ("grade2ndMisc", "grade2ndMisc"),
            ("grade2ndScienceMisc", "grade2ndScienceMisc"),
            ("grade2ndSSMisc", "grade2ndSSMisc"),
            ("sscGDMisc", "sscGDMisc"),
            ("sscMTSMisc", "sscMTSMisc"),
            ("rajPoliceConstMisc", "rajPoliceConstMisc"),
            ("rajLDCMisc", "rajLDCMisc"),
            ("rrbGDMisc", "rrbGDMisc"),
            ("sipaper1Misc", "sipaper1Misc"),
            ("sipaper2Misc", "sipaper2Misc"),
            ("reet2ScienceMisc", "reet2ScienceMisc")
]


    Questions = apps.get_model('Questions', 'Questions')
    Subjects = apps.get_model('Questions', 'Subjects')
    Options = apps.get_model('Questions', 'Options')
    Exams = apps.get_model('Questions', 'Exams')

    for i in subjects:
        subject = Subjects(name=i[0])
        subject.save()


    
    d = {"ias": iasSubjects, "jee": jeeSubjects, "jeeMains": jeeMainsSubjects, "jeeAdv": jeeAdvSubjects,
         "neet": neetSubjects, "ras": rasSubjects, "nda": ndaSubjects, "cds": cdsSubjects, "ibpsPO": ibpsPOSubjects,
         "ibpsClerk": ibpsClerkSubjects, "sscCGL": sscCGLSubjects, "sscCHSL": sscCHSLSubjects, "ntpc": ntpcSubjects,
         "reet1": reet1Subjects, "reet2": reet2Subjects, "reet2Science": reet2ScienceSubjects, "patwari": patwariSubjects, "grade2nd": grade2ndSubjects, 
         "grade2ndScience": grade2ndScienceSubjects, "grade2ndSS": grade2ndSSSubjects, "sscGD": sscGDSubjects, "sscMTS": sscMTSSubjects,
         "rajPoliceConst": rajPoliceConstSubjects, "rajLDC": rajLDCSubjects, "rrbGD": rrbGDSubjects, "sipaper1": sipaper1Subjects, "sipaper2": sipaper2Subjects}

    
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

    try:
        maths_file = open(r"/home/jayash/Desktop/Projects/smartprep_app/Backend/maths.txt")
    except:
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

    for _ in range(10):
        for i in subjects:

            random.shuffle(correctOptions)
            random.shuffle(good_data)

            for data in good_data:

                a = Options(
                    content= data["options"][0],
                    isCorrect=correctOptions[0],
                    uuid=str(uuid.uuid4())
                )
                a.save()

                b = Options(
                    content=data["options"][1],
                    isCorrect=correctOptions[1],
                    uuid=str(uuid.uuid4())
                )
                b.save()

                c = Options(
                    content=data["options"][2],
                    isCorrect=correctOptions[2],
                    uuid=str(uuid.uuid4())
                )
                c.save()

                d = Options(
                    content=data["options"][3],
                    isCorrect=correctOptions[3],
                    uuid=str(uuid.uuid4())
                )
                d.save()


                question = Questions(
                    uuid=str(uuid.uuid4()),
                    statement=data["statement"],
                    subject=i[0],
                    ratings=5,
                    isExpert=True,
                    difficulty=5,
                    explaination = "This is sample Explaination."
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
        ('Questions', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(load_initial_data)
    ]