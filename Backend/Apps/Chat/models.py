from django.db import models

from Apps.User.models import User

class PersonalMessage(models.Model):
    text = models.TextField(null=True, blank=True)
    sender = models.ForeignKey(User, related_name="sender", on_delete=models.CASCADE, null=True, blank=True)
    receiver = models.ForeignKey(User, related_name="receiver", on_delete=models.CASCADE, null=True, blank=True)
    time = models.DateTimeField(auto_now_add=True)

    def __str__(self) -> str:
        return str(self.text)[:20]


class Chat(models.Model):
    messages = models.ManyToManyField(PersonalMessage, related_name="messages", blank=True)
    user1 = models.ForeignKey(User, related_name="user1", on_delete=models.CASCADE, null=True, blank=True)
    user2 = models.ForeignKey(User, related_name="user2", on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self) -> str:
        return str(self.user1) + " >> " + str(self.user2)


class ForumMessage(models.Model):
    text = models.TextField(null=True, blank=True)
    sender = models.ForeignKey(User, related_name="senderForumMessage", on_delete=models.CASCADE, null=True, blank=True)
    time = models.DateTimeField(auto_now_add=True)

    def __str__(self) -> str:
        return str(self.text)[:20]



class Forum(models.Model):
    name = models.CharField(max_length=20)
    messages = models.ManyToManyField(ForumMessage, related_name='forumMessages', blank=True)

    def __str__(self) -> str:
        return str(self.name)
