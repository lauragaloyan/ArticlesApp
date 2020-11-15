import 'package:articles_app/screens/BookmarksScreen.dart';
import 'package:flutter/material.dart';

import 'ArticlesScreen.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen();

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {"page": ArticlesScreen(), "title": "Articles"},
      {"page": BookmarksScreen(), "title": "Bookmarks"}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}