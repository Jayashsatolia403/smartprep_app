from django.conf import settings
from django.conf.urls.static import static


from django.contrib import admin
from django.urls import path, include

from .views import checkout, PaymentSuccess, CancelPayment, payments_page

urlpatterns = [
    path('checkout', checkout, name='checkout'),
    path('success', PaymentSuccess.as_view(), name='success'),
    path('cancel', CancelPayment.as_view(), name='cancel'),
    path('', payments_page, name="payments_page"),
]