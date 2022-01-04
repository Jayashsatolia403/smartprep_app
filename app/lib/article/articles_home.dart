import 'package:app/article/article_view.dart';
import 'package:flutter/material.dart';

import 'article_config.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ArticleConfig>> getArticles() async {
  List<ArticleConfig> articles = [];

  String url = await rootBundle.loadString('assets/text/url.txt');

  final response = await http.get(
    Uri.parse('$url/articles'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  final json = jsonDecode(utf8.decode(response.bodyBytes));

  for (var i in json) {
    ArticleConfig data = ArticleConfig(
        title: i['title'], content: i['content'], images: [], date: i['date']);

    articles.add(data);
  }

  return articles;
}

class ArticlesHome extends StatefulWidget {
  const ArticlesHome({Key? key}) : super(key: key);

  @override
  _ArticlesHomeState createState() => _ArticlesHomeState();
}

class _ArticlesHomeState extends State<ArticlesHome> {
  final Future<List<ArticleConfig>> _articles = getArticles();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleConfig>>(
        future: _articles,
        builder: (BuildContext context,
            AsyncSnapshot<List<ArticleConfig>> snapShot) {
          if (snapShot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Center(child: Text("Articles")),
              ),
              body: ListView.builder(
                itemCount: snapShot.data!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapShot.data![index].title),
                    leading: const Icon(Icons.article),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleView(
                                    data: snapShot.data![index],
                                  )));
                    },
                  );
                },
              ),
            );
          } else {
            return const Text("Problems");
          }
        });
  }
}
