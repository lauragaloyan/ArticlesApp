import 'package:articles_app/data/Article.dart';
import 'package:articles_app/list_items/ArticleItem.dart';
import 'package:articles_app/widget/NoResultsWidget.dart';
import 'package:flutter/material.dart';

class SearchBar extends SearchDelegate {
  final List<Article> articlesList;

  SearchBar(this.articlesList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResults();
  }

  Widget _buildResults() {
    List<Article> suggestionList = [];
    if (query.isNotEmpty) {
      suggestionList.addAll(articlesList.where((element) =>
          element.title.toLowerCase().contains(query) ||
          element.userName.toLowerCase().contains(query)));
      suggestionList
          .sort((a, b) => a.elapsedTimeInHour.compareTo(b.elapsedTimeInHour));
    }

    if (suggestionList.isEmpty) {
      return NoResultsWidget();
    } else
      return ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            final item = suggestionList[index];
            return ArticleItem(
              id: item.id,
              userName: item.userName,
              elapsedTimeInHour: item.elapsedTimeInHour,
              isBookmarked: item.isBookmarked,
              userImage: item.userImage,
              title: item.title,
              description: item.description,
              images: item.images,
            );
          });
  }
}
