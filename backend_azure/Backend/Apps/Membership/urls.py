from django.contrib import admin
from django.urls import path, include

from . import views

urlpatterns = [
    path('checkout', views.checkout, name='checkout'),
    path('success', views.PaymentSuccess.as_view(), name='success'),
    path('cancel', views.CancelPayment.as_view(), name='cancel')
]