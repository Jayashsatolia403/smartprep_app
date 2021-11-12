from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from rest_framework.response import Response

from .serializers import RegisterationSerializer

from rest_framework.authtoken.models import Token


@permission_classes([IsAuthenticatedOrReadOnly])
@api_view(["POST", ])
def registrationView(request):
    serializer = RegisterationSerializer(data=request.data)
    data = {}

    if serializer.is_valid():
        f = serializer.save()
        token = Token.objects.filter(user=f)[0]
        data = {"name": f.name, "token": str(token.key)}
    else:
        data = serializer.errors


    return Response(data)

@api_view(['GET', ])
def getToken(request):
    token = Token.objects.all()[0]

    return Response(str(token))