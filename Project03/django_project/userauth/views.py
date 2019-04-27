from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth import authenticate, login
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
            return HttpResponse("LoginFailed")
    else:
               
    

def test(request):
    html = "<html><body>TEST</body></html>"
    return HttpResponse(html)


# Create your views here.
