from rest_framework.views import APIView
from rest_framework.generics import ListAPIView

from Apps.Questions.models import QuestionsOfTheDays
from .serializers import ArticleSerializer
from .models import Article

from rest_framework.permissions import AllowAny
from rest_framework.response import Response



class ArticleListView(ListAPIView):
    queryset = Article.objects.all()
    serializer_class  = ArticleSerializer


class getQuoteOfTheDay(APIView):
    permission_classes = [AllowAny]

    def get(self, request):
        quote = list(QuestionsOfTheDays.objects.all())

        return Response({
            "quote": quote[-1].text,
            "given_by": quote[-1].given_by
        })
