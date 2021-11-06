from django.contrib import admin

from .models import PersonalMessage, Forum, ForumMessage, Chat

admin.site.register(PersonalMessage)
admin.site.register(Chat)
admin.site.register(ForumMessage)
admin.site.register(Forum)