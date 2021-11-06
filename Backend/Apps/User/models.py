from django.contrib.auth.base_user import BaseUserManager

from rest_framework.authtoken.models import Token
from django.conf import settings
from django.dispatch import receiver
from django.db.models.signals import post_save
from django.contrib.postgres.fields import ArrayField


from django.db import models

from django.contrib.auth.models import AbstractBaseUser, UserManager, PermissionsMixin



class UserManager(BaseUserManager):
    def create_user(self, email, password=None):
        if email is None:
            raise TypeError('Users must have an Email Address!')

        user = self.model(email=self.normalize_email(email))
        
        user.set_password(password)
        user.save()

        return user

    def create_superuser(self, email, password):
        if password is None:
            raise TypeError('Superusers must have a password!')

        user = self.create_user(email, password)
        user.is_superuser = True
        user.is_staff = True
        user.save()

        return user

class User(AbstractBaseUser, PermissionsMixin):
    name = models.CharField(max_length=20, null = True)
    email = models.EmailField(db_index=True, unique=True)
    stripeId = models.CharField(max_length=255, null=True, blank=True)
    stripeSubscriptionId = models.CharField(max_length=255, null=True, blank=True)
    mebershipEndDate = models.DateTimeField(null=True, blank=True)
    membershipOf30 = models.BooleanField(default=False)
    membershipOf50 = models.BooleanField(default=False)
    membershipOf100 = models.BooleanField(default=False)
    isFree = models.BooleanField(default=True)
    language = models.CharField(max_length=10, null=True, blank=True)

    premiumExams = ArrayField(models.CharField(max_length=20, null=True, blank=True), null=True, blank=True)

    created_at = models.DateTimeField(auto_now_add=True, null=True)
    updated_at = models.DateTimeField(auto_now=True)

    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'

    objects = UserManager()

    def __str__(self):
        return self.email

@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)