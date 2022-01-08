from typing import List
from rest_framework.decorators import api_view, permission_classes

from rest_framework.response import Response

from rest_framework.generics import ListAPIView

from .serializers import ArticleSerializer

from .models import Article



class ArticleListView(ListAPIView):
    queryset = Article.objects.all()
    serializer_class  = ArticleSerializer