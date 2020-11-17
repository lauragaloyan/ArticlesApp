import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget();

  @override
  Widget build(BuildContext context) {
    // Fixme could be simplified
    // return Center(
    //   child: CircularProgressIndicator(
    //     valueColor:
    //     AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    //   )
    // );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
