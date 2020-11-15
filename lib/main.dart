import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/TabsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Articles',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.blueGrey.shade200,
        accentColor: Colors.blueGrey.shade700,
        canvasColor: Colors.grey.shade200,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontSize: 16,
                fontFamily: "Raleway",
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontFamily: "Raleway",
              ),
              headline6: TextStyle(
                fontSize: 18,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.normal,
              ),
            ),
      ),
      home: TabsScreen(),
      // routes: {
      // //   ArticleDetailsScreen.routeName: (context) =>
      // //       ArticleDetailsScreen()
      //  },
    );
  }
}
