import 'package:articles_app/api/ApiResponse.dart';
import 'package:articles_app/data/Article.dart';
import 'package:articles_app/list_items/ArticleItem.dart';
import 'package:articles_app/view_models/ArticlesViewModel.dart';
import 'package:articles_app/widget/LoadingWidget.dart';
import 'package:articles_app/widget/NoResultsWidget.dart';
import 'package:flutter/material.dart';

import '../AppRoutes.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  List<Article> articlesList = [];
  ArticlesViewModel _articlesViewModel;

  @override
  void initState() {
    super.initState();
    _articlesViewModel = ArticlesViewModel();
    _articlesViewModel.getArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Articles"), centerTitle: true),
      body: RefreshIndicator(
        // Fixme use another method for onRefresh, that returns Future
        onRefresh: () => _articlesViewModel.getArticleList(),
        child: StreamBuilder<ApiResponse<List<Article>>>(
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
          },
        ),
      ),
    );
  }

  Widget _slideRightBackground() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20),
        color: Theme.of(context).accentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.delete, color: Colors.white),
            Text("Delete",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.left)
          ],
        ),
      );

  Widget _buildDismissibleWidget(List<Article> articles, int index) {
    articlesList = articles;
    final item = articles[index];
    return Dismissible(
        key: Key(item.id.toString()),
        background: _slideRightBackground(),
        direction: DismissDirection.startToEnd,
        onDismissed: (_) => _removeArticle(item.id),
        child: ArticleItem(
          article: item,
          onRemoved: _removeArticle,
          onTap: () => _openDetails(item),
        ));
  }

  @override
  void dispose() {
    _articlesViewModel.dispose();
    super.dispose();
  }

  void _openDetails(Article article) {
    Navigator.push(context, AppRoutes.openArticleDetails(article))
        .then((result) {
      if (result != null) {
        _removeArticle(result);
      }
    });
  }

  void _removeArticle(int id) {
    setState(() {
      articlesList.removeWhere((article) => article.id == id);
    });
  }
}
