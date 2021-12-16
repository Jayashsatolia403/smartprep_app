import requests as re
import json

from Apps.Questions.models import Subjects, Exams, Questions

from rest_framework.authtoken.models import Token

import random




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



# Setup Subjects DB Table : Working


for i in subjects:
    subject = Subjects(name=i[0])
    subject.save()


# Setup Exams DB Table : Working

d = {"ias": iasSubjects, "jee": jeeSubjects, "jeeMains": jeeMainsSubjects, "jeeAdv": jeeAdvSubjects,
     "neet": neetSubjects, "ras": rasSubjects, "nda": ndaSubjects, "cds": cdsSubjects, "ibpsPO": ibpsPOSubjects,
     "ibpsClerk": ibpsClerkSubjects, "sscCGL": sscCGLSubjects, "sscCHSL": sscCHSLSubjects, "ntpc": ntpcSubjects, "cat": catSubjects}



for i in exams:
    exam = Exams(name=i[0])
    exam.save()


allExams = Exams.objects.all()

for exam in allExams:
    for i in d[str(exam)]:
        subject = Subjects.objects.get(name = i)
        exam.subjects.add(subject)
        exam.save()

# Setup Questions DB Table : Working


url = "http://127.0.0.1:8000/addQues/"
token = str(Token.objects.all()[0])

correctOptions = ['T', 'F', 'F', 'F']

good_data = []

maths_file = open(r"/home/jayash/Desktop/Projects/smartprep_app/Questions/Maths/maths.txt")


while True:
        statement = maths_file.readline()
        
        if not statement:
            break
        else:
            a = ">>$$$" + maths_file.readline() + "$$$<<"
            b = ">>$$$" + maths_file.readline() + "$$$<<"
            c = ">>$$$" + maths_file.readline() + "$$$<<"
            d = ">>$$$" + maths_file.readline() + "$$$<<"


        data = {"content" : a+" "+b+" "+c+" "+d+" "+ ' '.join(correctOptions),
                'statement' : statement}

        good_data.append(data)

        maths_file.readline()
        maths_file.readline()



for i in subjects:

    random.shuffle(good_data)

    for data in good_data:

        data['subject'] = i[0]

        f = re.post(url, headers={'Authorization': "Token {}".format(token)}, data=data)

        print(json.loads(f.text))


# Setting Ratings for Testing : Working

for i in Questions.objects.all():
    i.ratings = 5
    i.difficulty = 5
    i.save()

# Get Question of The Day : Working

# url = "https://smartprep-app.herokuapp.com/getQuesOfDay?subject={}"


# for i in subjects:
#     f = re.get("https://smartprep-app.herokuapp.com/getQuesOfDay?subject={}".format(i[0]), headers={'Authorization': "Token {}".format(token)})

#     print(json.loads(f.text))



# Get Daily Questions : Working

# url = "https://smartprep-app.herokuapp.com/getQues?exam={}"

# for i in exams:
#     f = re.get("https://smartprep-app.herokuapp.com/getQues?exam={}".format(i[0]), headers={'Authorization': "Token {}".format(token)})

#     print(json.loads(f.text))


# Adding Messages to Forum : Working



