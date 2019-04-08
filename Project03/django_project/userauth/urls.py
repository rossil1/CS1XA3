from django.urls import path
from . import views
from django.http import HttpResponse

urlpatterns = [
    path('', views.test, name="userAuth-test"),
]
