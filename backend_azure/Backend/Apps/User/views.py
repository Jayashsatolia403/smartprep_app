from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from update_db_file import update_database_file

from .serializers import RegisterationSerializer

from rest_framework.authtoken.models import Token


from django.contrib.auth import authenticate, login
from django.contrib.auth.forms import AuthenticationForm
from django.contrib import messages
from django.shortcuts import redirect, render


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

class LoginUser(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        username = request.POST['username']
        password = request.POST['password']

        user = authenticate(request, username=username, password=password)

        if user:
            form = login(request, user)

            return redirect("payments_page")
        
        else:
            messages.info(request, f'account done not exit plz sign in')
        
        form = AuthenticationForm()

    def get(self, request):
        form = AuthenticationForm()

        return render(request, 'login.html', {'form': form})