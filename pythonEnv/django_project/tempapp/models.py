from django.db import models

from django.contrib.auth.models import User

class UserInfoManager(models.Manager):
	def create_user_info(sel,username,password,info)

class UserInfo(models.Model)
	user = models.OneToOneField(User,
				on_delete=models.CASCADE,
				primary_key = True)
	info = models.CharField(max_length=30)
	objects = UserInfoManager()

