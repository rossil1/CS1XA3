from django.db import models

class User(models.Model):
    uname = models.CharField(max_length=20, primary_key=True)
    pw = models.CharField(max_length=20)

# Create your models here.
