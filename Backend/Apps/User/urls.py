from django.urls import path

from .views import registrationView, getToken

from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    path('register/', registrationView, name='register'),
    path('login/', obtain_auth_token, name='login'),
    path('getToken', getToken, name='getToken')
]