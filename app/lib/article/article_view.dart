import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import 'article_config.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({Key? key, required this.data}) : super(key: key);

  final ArticleConfig data;

  @override
  ArticleViewState createState() => ArticleViewState();
}

class ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.data.title),
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(0),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Flexible(
                        child: TeXView(
                          child: TeXViewColumn(children: [
                            TeXViewInkWell(
                              id: "id_0",
                              child: TeXViewColumn(children: [
                                TeXViewDocument(widget.data.content)
                              ]),
                            )
                          ]),
                        ),
                      ))))
        ]));
  }
}
