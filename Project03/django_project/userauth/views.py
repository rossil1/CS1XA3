from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth import authenticate, login
from django.contrib.auth.models import User
from .models import UserData
import json

#Here, using an additional bool we simplify logins page JSON to one method

def submit(request):
    jsonReq = json.loads(request.body)
    user = jsonReq.get('username','')
    passw = jsonReq.get('password','')
    isLogin = jsonReq.get('isLogin','')

    if isLogin:
        user = authenticate(request,username=user,password=passw)

        if user is not None:
            login(request,user)
            return HttpResponse("LoggedIn")
        else:
            return HttpResponse("denied")
    else:
        test = User.objects.filter(username=user)

        if test.count() == 0:
            newUser = Userdata.objects.createUserData(user,passw,1000)
            return HttpResponse("accountCreated")
        else:
            return HttpResponse("usernameTaken")

def login(request):
    return render(request, 'login.html')


# Create your views here.
