import 'package:articles_app/data/Article.dart';
import 'package:articles_app/widget/CircleImageWidget.dart';
import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final Article article;
  final Function onRemoved;
  final Function onTap;

  const ArticleItem({this.article, this.onRemoved, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        elevation: 4,
        margin: const EdgeInsets.all(6),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "${article.userName} - ${article.elapsedTimeInHour} hrs ago",
                            style: Theme.of(context).textTheme.bodyText1),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text("${article.title}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Raleway",
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "$article.description",
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleImageWidget(article.userImage)
                ],
              ),
              if (article.images.isNotEmpty) _buildImageWidget()
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildImageWidget() => SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(right: 10, top: 10),
              width: 150,
              child: Image.network(
                article.images[index].toString(),
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: article.images.length,
        ),
      );
}
