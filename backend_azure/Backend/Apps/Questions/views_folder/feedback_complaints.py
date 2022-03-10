from rest_framework.decorators import api_view
from rest_framework import status

from rest_framework.response import Response
from Apps.Questions.serializers import AddComplaintsSerializer, AddFeedbackSerializer
from update_db_file import update_database_file


@api_view(['POST', ])
def give_feedback(request):

    serializer = AddFeedbackSerializer(data = request.data)

    if serializer.is_valid():
        feedback = serializer.save()

        feedback.user = request.user

        feedback.save()

        update_database_file()
    else:
        return Response("Error", status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    return Response("Thank You for your time")



@api_view(['POST', ])
def make_complaint(request):

    serializer = AddComplaintsSerializer(data = request.data)

    if serializer.is_valid():
        complaint = serializer.save()

        complaint.user = request.user

        complaint.save()

        update_database_file()
    else:
        return Response("Error", status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    return Response("Thank You for your time")
