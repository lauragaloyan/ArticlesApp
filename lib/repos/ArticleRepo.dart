import 'package:articles_app/api/ApiHelper.dart';
import 'package:articles_app/data/Article.dart';
import 'package:articles_app/utils/StorageUtils.dart';

class ArticleRepo {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Article>> getArticles() async {
    final response = await _helper.get("b/3FE1");
    return response['articles']
        .map<Article>((article) => Article.fromJson(article))
        .toList();
  }

  Future saveArticle(Article article) async {
    var savedArticles = await fetchCachedArticles();
    savedArticles.add(article);
    await StorageUtils.writeFile(savedArticles);
  }

  Future<List<Article>> fetchCachedArticles() async {
    List<dynamic> articles = await StorageUtils.readFile();
    return List<Article>.from(articles);
  }
}
