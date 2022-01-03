from io import SEEK_END
from django.contrib.postgres import fields
from django.db import models
from rest_framework import serializers
from rest_framework.utils import field_mapping

from .models import Complaints, Feedback, Options, Questions, QuestionsOfTheDays, Submissions, WeeklyCompetitionResult, WeeklyCompetitions

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
                end = i+5

        
        return [result, end+1]

    
    def save(self):
        result = []
        data = self.validated_data['content']

        parsedContent = self.parseContent(data)
        contents = parsedContent[0]
        end = parsedContent[1]
        isCorrects = data[end:].rstrip().lstrip().split()


        for a in range(len(contents)):
            newOption = Options(
                uuid = str(uuid.uuid4()),
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
            percentCorrect = 0,
            explaination = self.validated_data['explaination']
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


        competition_result = WeeklyCompetitionResult(user = user, competition=competition)
        competition_result.save()

        print(len(competition_questions))


        for i in range(len(competition_questions)):
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



class AddFeedbackSerializer(serializers.ModelSerializer):

    class Meta:
        model = Feedback
        fields = ['subject', 'text']

    
    def save(self):
        newFeedback = Feedback(
            uuid = str(uuid.uuid4()),
            subject = self.validated_data['subject'],
            text = self.validated_data['text']
        )

        newFeedback.save()

        return newFeedback

class AddComplaintsSerializer(serializers.ModelSerializer):

    class Meta:
        model = Complaints
        fields = ['subject', 'text']

    
    def save(self):
        newComplaints = Complaints(
            uuid = str(uuid.uuid4()),
            subject = self.validated_data['subject'],
            text = self.validated_data['text']
        )

        newComplaints.save()

        return newComplaints