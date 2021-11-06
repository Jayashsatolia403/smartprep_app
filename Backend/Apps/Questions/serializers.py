from rest_framework import serializers

from .models import Options, Questions

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