from django.urls import path
from . import views


 #All addresses are being fwded by django_project/urls.py, thf it has "e/rossil1/"

urlpatterns=[
	path("", views.hello, name="testreq-hello"),
	path("get/", views.gettest, name="testreq-hello"),
        path("post/",views.posttest, name="testreq-hello")
]
