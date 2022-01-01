from io import SEEK_END
from rest_framework import serializers
from rest_framework.utils import field_mapping

from .models import Options, Questions, QuestionsOfTheDays, Submissions, WeeklyCompetitionResult, WeeklyCompetitions

import uuid



class QuestionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Questions
        fields = ['id', 'statement', 'options']



class AddOptionsSerializer(serializers.ModelSerializer):

    # Accepted Format = {'content' : "a b c d e T F T F T", 
    #                    'statement' : "Please Solve the Question!", 'subject' : "physics"}

    class Meta:
        model = Options
        fields = ['content', 'isCorrect']

    def parseContent(self, s):
        # Opening : >>$$$
        # Closing : $$$<<

        result = []
        isOpen = False

        start = 0
        end = 0

        for i in range(len(s)-5):
            if s[i:i+5] == ">>$$$":
                start = i+5
                isOpen = True

            elif s[i:i+5] == "$$$<<" and isOpen:
                result.append(s[start:i])
            
            if s[i] == "<":
                end = i

        
        return [result, end+1]

    
    def save(self):
        result = []
        data = self.validated_data['content']

        parsedContent = self.parseContent(data)
        contents = parsedContent[0]
        end = parsedContent[1]
        isCorrects = data[end:].rstrip().lstrip().split()

        print(contents, isCorrects)

        for a in range(len(contents)):
            newOption = Options(
                content = contents[a],
                isCorrect = True if isCorrects[a] == "T" else False
            )

            newOption.save()

            result.append(newOption)

        return result


class AddQuestionSerializer(serializers.ModelSerializer):

    class Meta:
        model = Questions
        fields = ['statement', 'options']

    
    def save(self):
        newQuestion = Questions(
            uuid = str(uuid.uuid4()),
            statement = self.validated_data['statement'],
            ratings = 0,
            difficulty = 0,
            percentCorrect = 0
        )

        newQuestion.save()
        return newQuestion


class SubmitContestSerializer(serializers.ModelSerializer):

    class Meta:
        model = WeeklyCompetitionResult
        fields = []


    def save(self):
        """
            Input Type: {
                "uuid": String,
                "options": [[selected options uuids], [selected options uuids], [], []]
            }
        """

        import json

        data = json.loads(self.context['useful_data']['data'])

        


        competition_uuid = data['uuid']
        selected_options = data['options']
        user = self.context['request'].user

        competition = WeeklyCompetitions.objects.get(uuid=competition_uuid)
        competition_questions = competition.questions.all()

        try:
            competition_result = WeeklyCompetitionResult.objects.get(user=user, competition=competition)

            for s in competition_result.submissions.all():
                s.delete()
            
            competition_result.delete()
        except:
            print("Good News")

        print(data)


        competition_result = WeeklyCompetitionResult(user = user, competition=competition)
        competition_result.save()


        for i in range(len(selected_options)):
            correct = True
            submission = Submissions(
                question = competition_questions[i],
                user = user,
                uuid = str(uuid.uuid4())
            )

            submission.save()
            correct = False

            for option_uuid in selected_options[i]:
                if option_uuid:
                    option = Options.objects.get(uuid = option_uuid)

                    if option.isCorrect == True:
                        correct = True

                    submission.selected_options.add(option)
                    submission.save()
                else:
                    correct = False

            if correct:
                competition_result.correct_options += 1
                competition_result.save()

            competition_result.submissions.add(submission)
        

        return competition_result
