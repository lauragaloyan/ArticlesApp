import 'package:flutter/material.dart';

class NoResultsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (_, index) {
          return Container(
              padding: const EdgeInsets.all(100),
              child: Center(child: Text("No items to show")));
        });
  }
}
