import 'package:articles_app/screens/BookmarksScreen.dart';
import 'package:flutter/material.dart';

import 'ArticlesScreen.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen();

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomNavigationBar());
  }

  Widget _buildPageView() => PageView(
        onPageChanged: (page) => _selectPage(page),
        controller: _pageController,
        children: <Widget>[
          ArticlesScreen(),
          BookmarksScreen(),
        ],
      );

  Widget _buildBottomNavigationBar() => BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.blueGrey.shade400,
        selectedItemColor: Colors.black,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.article_outlined),
              label: "Articles"),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.bookmark_border_rounded),
              label: "Bookmarks"),
        ],
      );
}
