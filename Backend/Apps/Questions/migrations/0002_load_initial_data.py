# Generated by Django 3.2.9 on 2021-12-25 13:14

from __future__ import unicode_literals

from django.db import migrations

import uuid

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

iasHindiSubjects = ["currentAffairsWorldHardHindi", 
                   "currentAffairsIndiaEasyHindi", 
                   "currentAffairsIndiaHardHindi", 
                   "geographyIndEasyHindi", 
                   "geographyIndHardHindi", 
                   "geographyWorldHindi",
                   "polityIndEasyHindi", 
                   "polityIndHardHindi", 
                   "economyIndGenHindi", 
                   "economyIndBudgetAndSchemesHindi", 
                   "environmentAndEcologyHardHindi", 
                   "environmentAndEcologyEasyHindi", 
                   "historyIndEasyHindi",
                   "historyIndHardHindi",
                   "historyWorldHindi",
                   "InternationalRelationAndSecurityHindi", 
                   "sciAndTechHardHindi", 
                   "artAndCultureIndHindi", 
                   "constitutionAndGovernanceHindi",
                   "decisionMakingHindi",
                   "iasMiscHindi"]
    
jeeSubjects = ["physicsAdv", "mathsAdv", "chemAdv", "physicsMains", "mathsMains", "chemMains", "jeeMisc"]
jeeAdvSubjects = ["physicsAdv", "mathsAdv", "chemAdv", "jeeAdvMisc"]
jeeMainsSubjects = ["physicsMains", "mathsMains", "chemMains", "jeeMainsMisc"]

neetSubjects = ["physicsMains", "bio", "chemMains", "neetMisc", "physicsNeet", "chemNeet"]

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
                "economyRajHard",
                "economyRajEasy",
                "reasoningHard", 
                "reasoningEasy",
                "rasMisc",
                "iasMisc"]

rasHindiSubjects = [
        "currentAffairsIndiaEasyHindi", 
                "currentAffairsIndiaHardHindi", 
                "currentAffairsWorldEasyHindi", 
                "geographyIndEasyHindi", 
                "geographyWorldHindi",
                "polityIndEasyHindi",
                "geographyIndHardHindi", 
                "polityIndHardHindi", 
                "economyIndGenHindi", 
                "economyIndBudgetAndSchemesHindi",
                "environmentAndEcologyHardHindi", 
                "environmentAndEcologyEasyHindi", 
                "historyIndEasyHindi",
                "historyIndHardHindi",
                "sciAndTechEasyHindi", 
                "sciAndTechHardHindi", 
                "constitutionAndGovernanceHindi",
                "geographyRajEasyHindi", 
                "geographyRajHardHindi", 
                "historyRajHardHindi", 
                "historyRajEasyHindi", 
                "artAndCultureRajHindi", 
                "polityRajEasyHindi", 
                "polityRajHardHindi", 
                "currentAffairsRajHardHindi",
                "currentAffairsRajEasyHindi", 
                "artAndCultureIndHindi", 
                "economyRajHardHindi",
                "economyRajEasyHindi",
                "reasoningHardHindi", 
                "reasoningEasyHindi",
                "rasMiscHindi", 
                "quantAptEasyHindi", 
                "iasMiscHindi"]

ndaSubjects = ["physicsNeet", 
                "ndaHistory", 
                "chemNeet", 
                "ndaMaths", 
                "currentEvents",
                "mathsMains",
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
                "mathsMains", 
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
                    "ibpsPOSSCMisc"]

ibpsClerkSubjects = ["englishLangAndComprehensionEasy",
                        "englishLangAndComprehensionHard", 
                        "quantAptEasyHindi", 
                        "quantAptHardHindi",
                        "reasoningEasyHindi", 
                        "financialAwareness",
                        "basicComputer",
                        "financeAndAccounts",
                        "ibpsClerkSSCMisc"]

sscCGLSubjects = ["reasoningHard", 
                    "reasoningEasy", 
                    "historyIndEasy", 
                    "currentAffairsIndiaEasy", 
                    "geographyIndEasy",
                    "polityIndEasy",
                    "quantAptEasy",
                    "quantAptHard",
                    "englishLangAndComprehensionHard",
                    "englishLangAndComprehensionEasy",
                    "financeAndAccounts",
                    "statistics",
                    "ibpsPOSSCMisc"]

sscCGLHindiSubjects = ["reasoningHardHindi", 
                    "reasoningEasyHindi", 
                    "historyIndEasyHindi", 
                    "currentAffairsIndiaEasyHindi", 
                    "geographyIndEasyHindi",
                    "polityIndEasyHindi",
                    "quantAptEasyHindi",
                    "quantAptHardHindi",
                    "englishLangAndComprehensionHard",
                    "englishLangAndComprehensionEasy",
                    "financeAndAccounts",
                    "statisticsHindi",
                    "sscCGLMiscHindi"]

sscCHSLSubjects = [
                "reasoningHardHindi", 
                    "reasoningEasyHindi", 
                    "historyIndEasyHindi", 
                    "currentAffairsIndiaEasyHindi", 
                    "geographyIndEasyHindi",
                    "polityIndEasyHindi",
                    "quantAptEasyHindi",
                    "quantAptHardHindi",
                    "englishLangAndComprehensionHard",
                    "englishLangAndComprehensionEasy",
                    "ibpsClerkSSCMisc"
                    ]

ntpcSubjects = [
                    "reasoningHardHindi", 
                    "reasoningEasyHindi", 
                    "historyIndEasyHindi", 
                    "currentAffairsIndiaEasyHindi", 
                    "geographyIndEasyHindi",
                    "polityIndEasyHindi",
                    "quantAptEasyHindi",
                    "quantAptHardHindi",
                    "englishLangAndComprehensionHard",
                    "englishLangAndComprehensionEasy",
                    "financeAndAccounts",
                    "ibpsClerkSSCMisc"]



reet1Subjects = [
        "reet1Misc",
        "childDevelopmentAndEdu",
        "hindi",
        "englishLangAndComprehensionEasy",
        "quantAptEasyHindi",
        "generalScience"]

reet2Subjects = [
        "childDevelopmentAndEdu",
        "hindi",
        "englishLangAndComprehensionEasy",
        "staticGK",
        "geographyIndEasyHindi", 
        "geographyWorldHindi",
        "polityIndEasyHindi",
        "geographyIndHardHindi", 
        "polityIndHardHindi", 
        "economyIndGenHindi", 
        "historyIndEasyHindi",
        "historyIndHardHindi",
        "constitutionAndGovernanceHindi",
        "geographyRajHardHindi", 
        "historyRajHardHindi", 
        "artAndCultureRajHindi", 
        "polityRajHardHindi", 
        "currentAffairsRajHardHindi",
        "artAndCultureIndHindi", 
        "rasMiscHindi"]

reet2ScienceSubjects = [
        "quantAptEasyHindi",
        "quantAptHardHindi",
        "childDevelopmentAndEdu",
        "hindi",
        "englishLangAndComprehensionEasy",
        "bioHindi",
        "physicsHindi", 
        "chemHindi",
        "grade2ndScienceMisc",
        "generalScience"
]



sipaper1Subjects = ["hindi"]

sipaper2Subjects = [
        "reasoningEasyHindi",
        "reasoningHardHindi",
        "quantAptEasyHindi",
        "currentAffairsIndiaEasyHindi",
        "currentAffairsRajEasyHindi",
        "currentAffairsWorldEasyHindi",
        "geographyIndEasyHindi",
        "polityIndEasyHindi",
        "economyIndGenHindi",
        "historyIndEasyHindi",
        "generalScience",
        "geographyRajEasyHindi",
        "geographyRajHardHindi",
        "historyRajEasyHindi",
        "historyRajHard",
        "artAndCultureRajHindi",
        "economyRajHardHindi",
        "economyRajEasyHindi",
        "patwariMisc"
]

patwariSubjects = [
        "reasoningEasyHindi",
        "reasoningHardHindi",
        "quantAptEasyHindi",
        "currentAffairsIndiaEasyHindi",
        "currentAffairsRajEasyHindi",
        "currentAffairsWorldEasyHindi",
        "geographyIndEasyHindi",
        "polityIndEasyHindi",
        "economyIndGenHindi",
        "historyIndEasyHindi",
        "generalScience",
        "geographyRajEasyHindi",
        "geographyRajHardHindi",
        "historyRajEasyHindi",
        "historyRajHard",
        "artAndCultureRajHindi",
        "economyRajHardHindi",
        "economyRajEasyHindi",
        "hindi",
        "currentAffairsRajHard",
        "englishLangAndComprehensionEasy",
        "basicComputer",
        "economyIndBudgetAndSchemes",
        "patwariMisc"
]

grade2ndSubjects = [
        "currentAffairsIndiaEasyHindi",
        "currentAffairsRajEasyHindi",
        "currentAffairsWorldEasyHindi",
        "geographyIndEasyHindi",
        "polityIndEasyHindi",
        "economyIndGenHindi",
        "historyIndEasyHindi",
        "generalScience",
        "geographyRajEasyHindi",
        "geographyRajHardHindi",
        "historyRajEasyHindi",
        "historyRajHard",
        "artAndCultureRajHindi",
        "economyRajHardHindi",
        "economyRajEasyHindi",
        "hindi",
        "currentAffairsRajHard",
        "englishLangAndComprehensionEasy",
        "basicComputer",
        "economyIndBudgetAndSchemes",
        "teachingApt",
        "rasMiscHindi",
        "patwariMisc"
]

grade2ndScienceSubjects = ["bioHindi", "grade2ndScienceMisc", "physicsHindi", "chemHindi"]

grade2ndSSSubjects = [
        "childDevelopmentAndEdu",
        "hindi",
        "englishLangAndComprehensionEasy",
        "staticGK",
        "geographyIndEasyHindi", 
        "geographyWorldHindi",
        "polityIndEasyHindi",
        "geographyIndHardHindi", 
        "polityIndHardHindi", 
        "economyIndGenHindi", 
        "historyIndEasyHindi",
        "historyIndHardHindi",
        "constitutionAndGovernanceHindi",
        "geographyRajHardHindi", 
        "historyRajHardHindi", 
        "artAndCultureRajHindi", 
        "polityRajHardHindi", 
        "currentAffairsRajHardHindi",
        "artAndCultureIndHindi", 
        "rasMiscHindi",
        "patwariMisc"
]


rajLDCSubjects = [
        "reasoningEasyHindi",
        "reasoningHardHindi",
        "quantAptEasyHindi",
        "currentAffairsIndiaEasyHindi",
        "currentAffairsRajEasyHindi",
        "currentAffairsWorldEasyHindi",
        "geographyIndEasyHindi",
        "polityIndEasyHindi",
        "economyIndGenHindi",
        "historyIndEasyHindi",
        "generalScience",
        "geographyRajEasyHindi",
        "geographyRajHardHindi",
        "historyRajEasyHindi",
        "historyRajHard",
        "artAndCultureRajHindi",
        "economyRajHardHindi",
        "economyRajEasyHindi",
        "hindi",
        "currentAffairsRajHard",
        "englishLangAndComprehensionEasy",
        "basicComputer",
        "economyIndBudgetAndSchemes",
        "patwariMisc"
]



sscGDSubjects = [
        "staticGK",
        "sscMTSGK",
        "hindi",
        "sscMTSReasoning",
        "gdQuantApt",
        "sscMTSMisc"
]

sscMTSSubjects = [
        "staticGK",
        "gdQuantApt",
        "sscMTSGK",
        "sscMTSReasoning",
        "englishLangAndComprehensionEasy",
        "sscMTSMisc"
]

rajPoliceConstSubjects = [
        "staticGK",
        "sscMTSGK",
        "sscMTSReasoning",
        "rpcGKRaj",
        "basicComputer",
        "sscMTSMisc"
]

rrbGDSubjects = [
        "staticGK",
        "gdQuantApt",
        "sscMTSGK",
        "sscMTSReasoning",
        "sscMTSMisc"
]



def load_initial_data(apps, schema_editor):

    exams = [("ias", "ias"),("iasHindi", "iasHindi"), ("jee", "jee"),("jeeMains","jeeMains"),("jeeAdv","jeeAdv"),("neet","neet"),
               ("ras","ras"), ("rasHindi","rasHindi"), ("ibpsPO","ibpsPO"), ("ibpsClerk", "ibpsClerk"), ("sscCHSL", "sscCHSL"),
               ("sscCGL", "sscCGL"), ("sscCGLHindi", "sscCGLHindi"), ("nda","nda"), ("cds","cds"), ("ntpc","ntpc"), 
               ("reet1", "reet1"), ("reet2", "reet2"), ("reet2Science", "reet2Science"), 
               ("patwari", 'patwari'), ("grade2nd", "grade2nd"), 
               ("grade2ndScience", "grade2ndScience"), ("grade2ndSS", "grade2ndSS"), ("sscGD", "sscGD"), ("sscMTS", "sscMTS"),
               ("rajPoliceConst", "rajPoliceConst"), ("rajLDC", "rajLDC"), ("rrbGD", "rrbGD"), 
               ("sipaper1", "sipaper1"), ("sipaper2", "sipaper2")]

    subjects = [('physicsAdv', 'physicsAdv'),
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


    Questions = apps.get_model('Questions', 'Questions')
    Subjects = apps.get_model('Questions', 'Subjects')
    Options = apps.get_model('Questions', 'Options')
    Exams = apps.get_model('Questions', 'Exams')
    Forum = apps.get_model('Chat', 'Forum')
    ForumMessage = apps.get_model('Chat', 'ForumMessage')

    for i in subjects:
        subject = Subjects(name=i[0])
        subject.save()


    
    d = {"ias": iasSubjects, "iasHindi": iasHindiSubjects, "jee": jeeSubjects, "jeeMains": jeeMainsSubjects, "jeeAdv": jeeAdvSubjects,
         "neet": neetSubjects, "ras": rasSubjects, "rasHindi": rasHindiSubjects, "nda": ndaSubjects, "cds": cdsSubjects, "ibpsPO": ibpsPOSubjects,
         "ibpsClerk": ibpsClerkSubjects, "sscCGL": sscCGLSubjects, "sscCGLHindi": sscCGLHindiSubjects, "sscCHSL": sscCHSLSubjects, "ntpc": ntpcSubjects,
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

    subject_files = {
            'hindi': "hindi.txt",
            'bio': "bio_english.txt",
            'chemNeet': "chem_neet_english.txt",
            'physicsNeet': "physics_neet_english.txt",
            'quantAptEasy': "quant_apt_english.txt",
            'quantAptEasyHindi': "quant_apt_hindi.txt",
            'iasMisc': "upsc_english.txt",
            'iasMiscHindi': "upsc_hindi.txt",
            'rasMisc': "ras_english.txt",
            'rasMiscHindi': "ras_hindi.txt",
            'englishLangAndComprehensionEasy': "english.txt",
            'basicComputer': "basicComputer.txt",
            'bioHindi': "bio_hindi.txt",
            'childDevelopmentAndEdu': "childDevAndEdu.txt",
            'generalScience': "generalScience.txt",
            'ibpsPOSSCMisc': "ibps_ssc.txt",
            'ibpsClerkSSCMisc': "ibpsClerkSSCMisc.txt",
            'staticGK': "staticGK.txt",
        }


    for xs in subject_files:

        path = r"/home/jayash/Desktop/Projects/smartprep_app/Backend/final_questions/" +  subject_files[xs]
        file = open(path)

        good_data = []

        count = 0

        while True:
                statement = file.readline()

                if not statement:
                        break

                options = []
                options_len = int(file.readline())
                correctOptions = [False for _ in range(options_len)]

                
                for i in range(options_len):
                        options.append(file.readline())
                
                x = file.readline().split()

                for i in x:
                        correctOptions[int(i)] = True

                if xs != "bio" and xs != "bioHindi":
                        file.readline()

                explaination = file.readline()

                data = {"options" : options,
                        'statement' : statement, 
                        'correctOptions': correctOptions,
                        'explaination': explaination}

                good_data.append(data)

                file.readline()

                count += 1


        for data in good_data:

                options = []

                for i in range(len(data['options'])):
                        option  = Options(
                                content= data["options"][i],
                                isCorrect=data['correctOptions'][i],
                                uuid=str(uuid.uuid4()),
                        )

                        option.save()

                        options.append(option)


                question = Questions(
                        uuid=str(uuid.uuid4()),
                        statement=data["statement"],
                        subject=xs,
                        ratings=5,
                        isExpert=True,
                        difficulty=5,
                        explaination = data['explaination']
                )

                question.save()

                for option in options:
                        question.options.add(option)
                        question.save()


                subject = Subjects.objects.get(name=xs)

                subject.questions.add(question)
                subject.save()

                question.save()


    
    for i in exams:
        forum = Forum(name=i[0])
        forum.save()


        fm = ForumMessage(text = "Welcome to {} Forum".format(i[0]))

        fm.save()

        forum.messages.add(fm)
        forum.save()




class Migration(migrations.Migration):

    dependencies = [
        ('Questions', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(load_initial_data)
    ]
