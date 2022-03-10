from django.core import paginator
from rest_framework.decorators import api_view

from django.core.paginator import InvalidPage, Paginator

from rest_framework.response import Response
from rest_framework import status

from .models import Chat, Forum
from .serializers import ForumMessageSerializer, PersonalMessageSerializer

from Apps.User.models import User

from update_db_file import update_database_file



@api_view(['GET', ])
def getAllForumMessages(request):
    try:
        result = []

        page = request.GET['page']
        page_size = request.GET['page_size']

        forumName = request.GET['forum']
        forum = Forum.objects.get(name=forumName)

        paginator = Paginator(forum.messages.all().order_by('-id'), page_size)

        try:
            messages = list(paginator.page(page))
        except InvalidPage:
            return Response("Done", status=status.HTTP_404_NOT_FOUND)

        for i in messages:
            if request.user == i.sender:
                result.append({
                    'text': i.text,
                    'side': 'right',
                    'time': i.time,
                    'sender': i.sender.name if i.sender else "Smartprep Team"
                })
            else:
                result.append({
                    'text': i.text,
                    'side': 'left',
                    'time': i.time,
                    'sender': i.sender.name if i.sender else "Smartprep Team"
                })

        result = sorted(result, key= lambda i: i['time'])


        return Response(result)
    except Exception as e:
        print(e)
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST', ])
def sendForumMessage(request):
    try:
        forumName = request.data['forum']


        serializer = ForumMessageSerializer(data=request.data, context={'request': request})
    
        print(request.POST)

        forum = Forum.objects.get(name = forumName)

        if serializer.is_valid():
            message = serializer.save()

            forum.messages.add(message)
            forum.save()

            update_database_file()

            return Response("Success")
        else:
            return "Oops"
    except Exception as e:
        print(e)
        return Response("Invalid Request", status = status.HTTP_400_BAD_REQUEST)
    


@api_view(['POST', ])
def sendPersonalMessage(request):
    try:
        receiverID = request.POST['receiverID']
        receiver = User.objects.get(id = receiverID)
        serializer = PersonalMessageSerializer(data=request.data, 
        context={'request':request, 'receiverID': receiverID})
        
        if serializer.is_valid():
            message = serializer.save()
            
            chat1 = Chat.objects.filter(user1 = request.user, user2 = receiver)
            chat2 = Chat.objects.filter(user1 = receiver, user2 = request.user)

            if len(chat1) == 1:
                saveToChat = chat1[0]
                saveToChat.messages.add(message)
            elif len(chat2) == 1:
                saveToChat = chat2[0]
                saveToChat.messages.add(message)
            else:
                saveToChat = Chat(user1 = request.user, user2 = receiver)
                saveToChat.save()
                saveToChat.messages.add(message)

            saveToChat.save()

            update_database_file()
            
            return Response("Success")
        else:
            return Response(serializer.errors)
    except Exception as e:
        print(e)
        return Response("Invalid Request")



@api_view(['GET', ])
def getAllPersonalMessages(request):
    try:
        result = []

        receiverID = request.GET['receiverID']
        receiver = User.objects.get(id = receiverID)

        chat1 = Chat.objects.filter(user1 = request.user, user2 = receiver)
        chat2 = Chat.objects.filter(user1 = receiver, user2 = request.user)
        
        if len(chat1) == 1:
            chat = chat1[0]
            messages = list(chat.messages.all())
        elif len(chat2) == 1:
            chat = chat2[0]
            messages = list(chat.messages.all())
        else:
            return Response("No Messages Yet")


        messages.reverse()
        messages = messages[:50]

        for i in messages:
            if request.user == i.sender:
                result.append({
                    'text': i.text,
                    'side': 'left',
                    'time': i.time
                })
            else:
                result.append({
                    'text': i.text,
                    'side': 'right',
                    'time': i.time
                })


        return Response(result)
    except Exception as e:
        return Response("Invalid Request", status=status.HTTP_400_BAD_REQUEST)


