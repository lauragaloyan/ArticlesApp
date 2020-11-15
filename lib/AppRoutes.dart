import 'package:articles_app/screens/ArticleDetails.dart';
import 'package:flutter/material.dart';

import 'data/Article.dart';

class AppRoutes {
  static openArticleDetails(Article article) =>
      MaterialPageRoute(
          builder: (BuildContext context) =>
              ArticleDetailsScreen(article));
}
