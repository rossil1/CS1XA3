from django.db import models
from django.contrib.auth.models import User


class UserManager(models.Manager):
    def createUserData(self,uname,passw,testInp):
        user = User.objects.create_user(username=uname,
                                        password=passw)
        
        userData = self.create(user=user,dataTest=testInp)
        return userData

class UserData(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                primary_key=True)
    dataTest = models.CharField(max_length=20)

    objects = UserManager()
