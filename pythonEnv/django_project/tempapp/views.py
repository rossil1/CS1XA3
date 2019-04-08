from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout

import json

# Create your views here.
def session_incr(request):
	i = request.session.get('count',0)
	request.session['count'] = i+1
	return HttpResponse('')

def session_get(request):
	return HttpResponse("Current Count: " + str(request.session['count']))

def add_user(request):
	"""
	recieve { 'username': val0, 'password':val1}
	"""

	json_req = json.loads(request.body)
	uname = json_req.get('username',)
	passw = json_req.get('password',)

	if uname != '':
		user = User.create_user(username=uname, password=passw)
		return HttpResponse('Success')
	else:
		return HttpResponse('Invalid User Name')

def login_user(request):
	json_req = json.loads(request.body)
	uname = json_req.get('username',)
	passw = json_req.get('password',)

	user = authenticate(request, username=uname, password=passw)

	if user is not none:
		login(request,user)
		return HttpResponse("Valid User")
	else:
		return HttpResponse("Invalid User")

def logout_user(request):
	logout(request)
	return HttpResponse("Logged Out")

def user_info(request):
	user = request.user
	
	if user.is_authenticated:
		return HttpResponse("Hello " + user.first_name)
	else:
		return HttpResponse("I don't know you")
