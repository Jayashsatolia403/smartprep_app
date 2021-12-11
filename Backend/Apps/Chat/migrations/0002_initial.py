# Generated by Django 3.2.9 on 2021-12-11 15:36

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('Chat', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='personalmessage',
            name='receiver',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='receiver', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='personalmessage',
            name='sender',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='sender', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='forummessage',
            name='sender',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='senderForumMessage', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='forum',
            name='messages',
            field=models.ManyToManyField(blank=True, related_name='forumMessages', to='Chat.ForumMessage'),
        ),
        migrations.AddField(
            model_name='chat',
            name='messages',
            field=models.ManyToManyField(blank=True, related_name='messages', to='Chat.PersonalMessage'),
        ),
        migrations.AddField(
            model_name='chat',
            name='user1',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='user1', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='chat',
            name='user2',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='user2', to=settings.AUTH_USER_MODEL),
        ),
    ]