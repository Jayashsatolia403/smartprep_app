from django.contrib.postgres.fields.array import ArrayField
from django.db import models




class Article(models.Model):
    uuid = models.CharField(max_length=50)
    title = models.CharField(max_length=50)
    content = models.CharField(max_length=10000000)
    images = ArrayField(models.ImageField(upload_to="uploads/", null = True, blank = True), null=True, blank=True)