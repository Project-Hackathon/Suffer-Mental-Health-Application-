from django.contrib.auth.models import AbstractUser
from django.db import models

# Create your models here.

class User(AbstractUser):
    pass

class Contact(models.Model):
    name = models.CharField(max_length=255)
    email = models.EmailField()
    subject = models.CharField(max_length=255)
    message = models.TextField(max_length=1000)

class Storeblog(models.Model):
    owner = models.CharField(max_length=500)
    header = models.CharField(max_length=255)
    short = models.CharField(max_length=500)
    data = models.TextField(max_length=5000)
    date = models.DateField(null=True, auto_now_add=True)

    def serialize(self):
        return {
            "id": self.id,
            "owner": self.owner,
            "header": self.header,
            "short": self.short,
            "data": self.data
        }


