from django.urls import path

from .views import registrationView, get_name

from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('register/', registrationView, name='register'),
    path('login/', obtain_auth_token, name='login'),
    path('get_name', get_name, name='get_name'),
]