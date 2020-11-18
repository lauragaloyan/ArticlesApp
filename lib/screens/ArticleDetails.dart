import 'package:articles_app/data/Article.dart';
import 'package:articles_app/utils/utils.dart';
import 'package:articles_app/view_models/ArticlesViewModel.dart';
import 'package:articles_app/widget/CircleImageWidget.dart';
import 'package:flutter/material.dart';

class MenuActions {
  static const DELETE = "Delete";
  static const SHARE = "Share"; //todo fix this :D
}

class ArticleDetailsScreen extends StatefulWidget {
  final Article article;

  ArticleDetailsScreen(this.article);

  @override
  _ArticleDetailsScreenState createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  List<String> menuItems = [MenuActions.DELETE, MenuActions.SHARE];
  Article article;
  ArticlesViewModel _articlesViewModel;

  void _selectOption(String choice) {
    if (choice == MenuActions.SHARE) {
      launchEmail("dummy@gmail.com", article.title, article.description);
    } else {
      _closeScreen();
    }
    setState(() {});
  }

  void _closeScreen() {
    Navigator.of(context).pop(article.id);
  }

  @override
  void initState() {
    _articlesViewModel = ArticlesViewModel();
    article = widget.article;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomScrollView(slivers: [
              _buildSliverList(),
              if (article.images.isNotEmpty) _buildGridView()
            ]),
          ),
        ));
  }

  Widget _buildSliverList() {
    return SliverList(
        delegate: SliverChildListDelegate(
      [
        Text(article.title,
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: "Raleway")),
        Row(children: [
          Text(
            "${article.userName} - ${article.elapsedTimeInHour} hrs. ago",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Flexible(fit: FlexFit.tight, child: SizedBox()),
          CircleImageWidget(article.userImage)
        ]),
        SelectableText(article.description,
            style: Theme.of(context).textTheme.bodyText2),
      ],
    ));
  }

  Widget _buildGridView() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return GridTile(
            child: Image.network(article.images[index], fit: BoxFit.cover));
      }, childCount: article.images.length),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return InkResponse(
            child: IconButton(
                icon: const Icon(Icons.close), onPressed: () => _closeScreen()),
          );
        },
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              _articlesViewModel.markArticleAsBookmarked(article);
            }), //widget
        PopupMenuButton(
          onSelected: _selectOption,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context) {
            return menuItems.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
