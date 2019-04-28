from django.urls import path
from . import views
from django.http import HttpResponse

urlpatterns = [
    path('', views.login, name="userAuth-appLogin"),
    path('submit/', views.submit, name="userAuth-infoSubmit")
]
