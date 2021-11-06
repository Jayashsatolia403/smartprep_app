from rest_framework import serializers

from .models import PersonalMessage, ForumMessage
from Apps.User.models import User



class PersonalMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = PersonalMessage
        fields = ['text']
    
    def save(self):
        personalMessage = PersonalMessage(
            text = self.validated_data['text'],
            receiver = User.objects.get(id = self.context['receiverID']),
            sender = self.context['request'].user
        )

        personalMessage.save()

        return personalMessage


class ForumMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ForumMessage
        fields = ['text']
    
    def save(self):
        forumMessage = ForumMessage(
            text = self.validated_data['text'],
            sender = self.context['request'].user
        )

        forumMessage.save()

        return forumMessage