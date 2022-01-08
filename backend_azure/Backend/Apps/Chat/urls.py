from django.urls import path

from.views import getAllForumMessages, getAllPersonalMessages, sendForumMessage, sendPersonalMessage

urlpatterns = [
    path('getAllForumMessages', getAllForumMessages, name='getAllForumMessages'),
    path('sendForumMessage/', sendForumMessage, name='sendForumMessage'),
    path('sendMessage/', sendPersonalMessage, name='sendPersonalMessage'),
    path('getAllPersonalMessages', getAllPersonalMessages, name='getAllPersonalMessages')
]