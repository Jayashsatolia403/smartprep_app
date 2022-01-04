import 'package:app/article/article_view.dart';
import 'package:flutter/material.dart';

List<List<String>> urlTitles = [
  [
    "Ten Things Successful People (Who Are Actually Happy) Do Differently ",
    "https://www.linkedin.com/pulse/things-successful-people-who-actually-happy-do-dr-travis-bradberry"
  ],
  [
    "13 Things You Should Give Up If You Want To Be Successful",
    "https://medium.com/@zdravko/13-things-you-need-to-give-up-if-you-want-to-be-successful-44b5b9b06a26#.7pe14to63"
  ],
  [
    "Is achieving true happiness a possibility?",
    "https://rawsomeee.medium.com/is-achieving-true-happiness-a-possibility-209ca036a5bc"
  ],
  [
    "Don't Make A New Year Resolution!",
    "https://roybntz.medium.com/dont-make-a-new-year-resolution-83139f5c0e66"
  ]
];

class ArticlesHome extends StatefulWidget {
  const ArticlesHome({Key? key}) : super(key: key);

  @override
  _ArticlesHomeState createState() => _ArticlesHomeState();
}

class _ArticlesHomeState extends State<ArticlesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Articles")),
        ),
        body: ListView.builder(
          itemCount: urlTitles.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(urlTitles[index][0]),
              leading: const Icon(Icons.article),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArticleView(
                              url: urlTitles[index][1],
                            )));
              },
            );
          },
        ));
  }
}
