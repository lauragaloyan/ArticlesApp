import 'package:articles_app/api/ApiResponse.dart';
import 'package:articles_app/data/Article.dart';
import 'package:articles_app/list_items/ArticleItem.dart';
import 'package:articles_app/view_models/ArticlesViewModel.dart';
import 'package:articles_app/widget/LoadingWidget.dart';
import 'package:articles_app/widget/NoResultsWidget.dart';
import 'package:articles_app/widget/SearchBarWidget.dart';
import 'package:flutter/material.dart';

import '../AppRoutes.dart';

// Fixme better to have single abstract class for Articles and different
//  impl-s for Web and Bookmarked articles
class BookmarksScreen extends StatefulWidget {
  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  List<Article> bookmarkedArticlesList = [];
  ArticlesViewModel _articlesViewModel;

  // Future<void> _fetchData() async {
  //   await ResultParser.fetchJson('assets/articles.json').then((jsonResult) => {
  //         articlesList = ResultParser.fromJsonList(
  //             jsonResult["articles"], (jsonMap) => Article.fromJson(jsonMap))
  //       });
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
    _articlesViewModel = ArticlesViewModel();
    _articlesViewModel.getBookmarkedArticles();
  }

  @override
  Widget build(BuildContext context) {
    Widget _slideRightBackground() {
      return Container(
        color: Theme.of(context).accentColor,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 20),
              Icon(Icons.delete, color: Colors.white),
              Text("Delete",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.left)
            ],
          ),
          alignment: Alignment.centerLeft,
        ),
      );
    }

    Widget _buildDismissibleWidget(List<Article> articles, int index) {
      bookmarkedArticlesList = articles;
      final item = articles[index];
      return Dismissible(
        key: Key(item.id.toString()),
        background: _slideRightBackground(),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) => _removeArticle(item.id),
        child: ArticleItem(
            id: item.id,
            userName: item.userName,
            elapsedTimeInHour: item.elapsedTimeInHour,
            isBookmarked: item.isBookmarked,
            userImage: item.userImage,
            title: item.title,
            description: item.description,
            images: item.images,
            onTap: () => _openDetails(item),
            onRemoved: _removeArticle),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchBar(bookmarkedArticlesList));
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: StreamBuilder(
          stream: _articlesViewModel.articleListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return LoadingWidget();
                  break;
                case Status.COMPLETED:
                  return ListView.builder(
                    itemBuilder: (context, index) =>
                        _buildDismissibleWidget(snapshot.data.data, index),
                    itemCount: snapshot.data.data.length,
                  );
                  break;
                case Status.ERROR:
                  // TODO: Handle this case.
                  break;
              }
            }
            return NoResultsWidget();
          }),
    );
  }

  @override
  void dispose() {
    _articlesViewModel.dispose();
    super.dispose();
  }

  void _removeArticle(int id) {
    setState(() {
      //todo
    });
  }

  void _openDetails(Article article) {
    Navigator.push(context, AppRoutes.openArticleDetails(article))
        .then((result) {
      if (result != null) {
        _removeArticle(result);
      }
    });
  }
}
