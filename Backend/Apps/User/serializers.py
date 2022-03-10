from rest_framework import serializers

from .models import User

class RegisterationSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(style = {'input_type' : 'password'}, write_only=True)

    class Meta:
        model = User
        fields = ['name', 'email', 'password', 'password2']
        extra_kwargs = {'password' : {'write_only' : True}}

    
    def save(self):
        NewUser = User(
            name = self.validated_data['name'],
            email = self.validated_data['email']
        )
        password = self.validated_data['password']
        password2 = self.validated_data['password2']

        if password != password2:
            raise serializers.ValidationError({'password': "Password Must Match."})
        
        NewUser.set_password(password)
        NewUser.save()

        from datetime import date

        NewUser.addedQuestionDate = date.today()

        NewUser.save()

        return NewUser