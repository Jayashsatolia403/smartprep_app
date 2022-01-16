from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from .serializers import RegisterationSerializer

from rest_framework.authtoken.models import Token

def update_database_file():
    import os

    os.system("rm /home/site/wwwroot/db.sqlite3")
    os.system("cp db.sqlite3 /home/site/wwwroot/")

    print("Successfully Updated")





class GetName(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        try:
            return Response([request.user.name, request.user.email])
        except:
            return Response("Invalid Request")


class RegisterUser(APIView):
    permission_classes = [AllowAny]
    
    def post(self, request):
        serializer = RegisterationSerializer(data=request.data)
        data = {}

        if serializer.is_valid():
            f = serializer.save()
            token = Token.objects.filter(user=f)[0]
            data = {"name": f.name, "token": str(token.key), "email": str(f.email)}
        else:
            data = serializer.errors

        update_database_file()


        return Response(data)