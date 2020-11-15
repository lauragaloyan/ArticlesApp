import 'package:articles_app/widget/CircleImageWidget.dart';
import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final int id;
  final String userName;
  final int elapsedTimeInHour;
  final bool isBookmarked;
  final String userImage;
  final String title;
  final String description;
  final List<String> images;
  final Function onRemoved;
  final Function onTap;

  const ArticleItem(
      {this.id,
      this.userName,
      this.elapsedTimeInHour,
      this.isBookmarked,
      this.userImage,
      this.title,
      this.description,
      this.images,
      this.onRemoved,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget _buildImageWidget() {
      return SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(right: 10, top: 10),
              width: 150,
              child: Image.network(
                images[index].toString(),
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: images.length,
        ),
      );
    }

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
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "$userName - $elapsedTimeInHour hrs ago",
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "$title",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Raleway",
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "$description",
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleImageWidget(userImage)
                ],
              ),
              if (images.isNotEmpty) _buildImageWidget()
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
