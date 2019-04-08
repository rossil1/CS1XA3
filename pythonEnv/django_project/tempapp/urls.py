from django.urls import path
from . import views

urlpatterns = [
	path('incr/', views.session_incr,name="session_incr"),
	path('get/',views.session_get,name="session_get"),
	path('login/', views.login_user, name='login'),
	path('logout/', views.logout_user, name='logout'),
	path('info/', views.user_info, name='info'),
]
