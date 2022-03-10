from django.db import models




class Article(models.Model):
    uuid = models.CharField(max_length=50)
    title = models.CharField(max_length=50)
    content = models.CharField(max_length=10000000)
    image = models.ImageField(upload_to="uploads/", null = True, blank = True)


class QuoteOfTheDay(models.Model):
    text = models.CharField(max_length=100)
    given_by = models.CharField(max_length=50)