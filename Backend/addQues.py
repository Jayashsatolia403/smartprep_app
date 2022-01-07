# subject_files = {
#     'hindi': "hindi.txt",
#     'bio': "bio_english.txt",
#     'chemNeet': "chem_neet_english.txt",
#     'physicsNeet': "physics_neet_english.txt",
#     'quantAptEasy': "quant_apt_english.txt",
#     'quantAptEasyHindi': "quant_apt_hindi.txt",
#     'iasMisc': "upsc_english.txt",
#     'iasMiscHindi': "upsc_hindi.txt",
#     'rasMisc': "ras_english.txt",
#     'rasMiscHindi': "ras_hindi.txt",
#     'englishLangAndComprehensionEasy': "english.txt",
#     'basicComputer': "basicComputer.txt",
#     'bioHindi': "bio_hindi.txt",
#     'childDevelopmentAndEdu': "childDevAndEdu.txt",
#     'generalScience': "generalScience.txt",
#     'ibpsPOSSCMisc': "ibps_ssc.txt",
#     'ibpsClerkSSCMisc': "ibpsClerkSSCMisc.txt",
#     'staticGK': "staticGK.txt",
# }


# for xs in subject_files:

#     path = r"final_questions/" +  subject_files[xs]
#     file = open(path)

#     good_data = []

#     count = 0

#     while True:
#         try:
#             statement = file.readline()

#             if not statement:
#                 break

#             options = []
#             options_len = int(file.readline())
#             correctOptions = [False for _ in range(options_len)]

            
#             for i in range(options_len):
#                 options.append(file.readline())
            
#             x = file.readline().split()

#             for i in x:
#                 correctOptions[int(i)] = True

#             if xs != "bio" and xs != "bioHindi":
#                 file.readline()

#             explaination = file.readline()

#             data = {"options" : options,
#                     'statement' : statement, 
#                     'correctOptions': correctOptions,
#                     'explaination': explaination}

#             good_data.append(data)

#             file.readline()

#             count += 1

#             if count == 2:
#                 break


#         except:
#             print(xs)



#     for data in good_data:

#         options = []

#         for i in range(len(data['options'])):
#             option  = Options(
#                 content= data["options"][i],
#                 isCorrect=data['correctOptions'][i],
#                 uuid=str(uuid.uuid4()),
#             )

#             option.save()

#             options.append(option)


#         question = Questions(
#             uuid=str(uuid.uuid4()),
#             statement=data["statement"],
#             subject=xs,
#             ratings=5,
#             isExpert=True,
#             difficulty=5,
#             explaination = data['explaination']
#         )

#         question.save()

#         for option in options:
#             question.options.add(option)
#             question.save()


#         subject = Subjects.objects.get(name=xs)

#         subject.questions.add(question)
#         subject.save()

#         question.save()

#         print("Success")