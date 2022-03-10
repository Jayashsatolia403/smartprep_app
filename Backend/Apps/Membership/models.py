from Apps.User.models import User
from django.db import models

class SessionUser(models.Model):
    sessionID = models.CharField(max_length=100)
    user = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True)