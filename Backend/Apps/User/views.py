from rest_framework.decorators import api_view
from rest_framework.response import Response

from .serializers import RegisterationSerializer

from rest_framework.authtoken.models import Token


@api_view(["POST", ])
def registrationView(request):
    serializer = RegisterationSerializer(data=request.data)
    data = {}

    if serializer.is_valid():
        serializer.save()
        data = "Registration Successful! You can login to system now."
    else:
        data = serializer.errors

    return Response(data)

@api_view(['GET', ])
def getToken(request):
    token = Token.objects.all()[0]

    return Response(str(token))