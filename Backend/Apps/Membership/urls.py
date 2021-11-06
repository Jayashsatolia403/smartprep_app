from django.contrib import admin
from django.urls import path, include

from . import views

urlpatterns = [
    path('checkout', views.checkout, name='checkout'),
    path('success', views.success, name='success'),
]