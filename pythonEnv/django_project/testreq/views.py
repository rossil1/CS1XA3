from django.shortcuts import render
from django.http import HttpResponse

def gettest(request):
    	keys = request.GET
    	name = keys.get("name","")
    	age = keys.get("age","")
    	return HttpResponse("Hello " + name + " you are " + age + " years old.")

def posttest(request):
	keys = request.POST
	name = keys.get("name","")
	age = keys.get("age","")
	return HttpResonse("Hello " +name+ " you are " +age+ " years old")

def hello(request):
	return HttpResponse ("hello")
# Create your views here.
