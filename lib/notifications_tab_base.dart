import 'package:flutter/material.dart';

class NotificationsTabBase extends StatelessWidget {
  final String title;

  NotificationsTabBase(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: new AppBar(
        title: new Text(
          title,
          style: new TextStyle(
            color: Theme.of(context).hintColor,
          ),
        ),
        elevation:
            Theme.of(context).platform == TargetPlatform.android ? 4.0 : 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: new Container(
          child: new Center(
            child: new Text(title),
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border: new Border(
                    top: new BorderSide(color: Colors.grey[200]),
                  ),
                )
              : null),
    );
  }
}