import 'dart:async';

import 'package:articles_app/api/ApiResponse.dart';
import 'package:articles_app/data/Article.dart';
import 'package:articles_app/repos/ArticleRepo.dart';

class ArticlesViewModel {
  ArticleRepo _articleRepo;
  StreamController _articleListController;

  StreamSink<ApiResponse<List<Article>>> get articleListSink =>
      _articleListController.sink;

  Stream<ApiResponse<List<Article>>> get articleListStream =>
      _articleListController.stream;

  ArticlesViewModel() {
    _articleListController = StreamController<ApiResponse<List<Article>>>();
    _articleRepo = ArticleRepo();
  }

  Future<void> getArticleList() async {
    articleListSink.add(ApiResponse.loading());
    try {
      var articles = await _articleRepo.getArticles();
      articleListSink.add(ApiResponse.completed(articles));
    } catch (e) {
      articleListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  Future<void> getBookmarkedArticles() async {
    try {
      var bookmarkedArticles = await _articleRepo.fetchCachedArticles();
      articleListSink.add(ApiResponse.completed(bookmarkedArticles));
    } catch (e) {
      articleListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  markArticleAsBookmarked(Article article) async {
    await _articleRepo.saveArticle(article);
  }

  dispose() {
    _articleListController?.close();
  }
}
