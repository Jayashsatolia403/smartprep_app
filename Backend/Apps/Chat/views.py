from rest_framework.decorators import api_view

from rest_framework.response import Response

from .models import Chat, Forum
from .serializers import ForumMessageSerializer, PersonalMessageSerializer

from Apps.User.models import User




@api_view(['GET', ])
def getAllForumMessages(request):
    try:
        result = []

        forumName = request.GET['forum']
        forum = Forum.objects.get(forumName)

        messages = list(forum.messages.all())


        messages.reverse()
        messages = messages[:50]

        for i in messages:
            if request.user == i.sender:
                result.append({
                    'text': i.text,
                    'side': 'left',
                    'time': i.time,
                    'sender': i.sender.name
                })
            else:
                result.append({
                    'text': i.text,
                    'side': 'right',
                    'time': i.time,
                    'sender': i.sender.name
                })


        return Response(result)
    except:
        return Response("Invalid Request")


@api_view(['POST', ])
def sendForumMessage(request):
    # try:
        serializer = ForumMessageSerializer(data=request.data, context={'request': request})

        forumName = request.POST['forum']
        forum = Forum.objects.get(name = forumName)

        if serializer.is_valid():
            message = serializer.save()

            forum.messages.add(message)
            forum.save()

            return Response("Success")
        else:
            return "Oops"
    # except:
    #     return Response("Invalid Request")
    


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
            
            return Response("Success")
        else:
            return Response(serializer.errors)
    except:
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
    except:
        return Response("Invalid Request")


