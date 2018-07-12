import 'package:flutter/material.dart';

import 'live_chat_tab_base.dart';
// import 'posts_tab_base.dart';
// import 'events_tab_base.dart';
// import 'universities_tab_base.dart';
import 'notifications_tab_base.dart';
// import 'profile_tab_base.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new BottomNav(),
    );
  }
}

class BottomNav extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<BottomNav> with SingleTickerProviderStateMixin {
  TabController bottomNavTabController;

  @override
  void initState() {
    super.initState();
    bottomNavTabController = new TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    bottomNavTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new Material(
        color: Theme.of(context).platform == TargetPlatform.android
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.7),
        child: new TabBar(
          indicatorColor: Theme.of(context).accentColor,
          controller: bottomNavTabController,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.edit, color: Theme.of(context).splashColor),
            ),
            new Tab(
              icon: new Icon(Icons.question_answer,
                  color: Theme.of(context).splashColor),
            ),
            new Tab(
              icon: new Icon(Icons.event_note,
                  color: Theme.of(context).splashColor),
            ),
            new Tab(
              icon: new Icon(Icons.account_balance,
                  color: Theme.of(context).splashColor),
            ),
            new Tab(
              icon: new Icon(Icons.notifications_active,
                  color: Theme.of(context).splashColor),
            ),
            new Tab(
              icon:
                  new Icon(Icons.person, color: Theme.of(context).splashColor),
            ),
          ],
        ),
      ),
      body: new TabBarView(
        children: <Widget>[
          new LiveChatTabBase(),
          // new PostsTabBase(),
          // new EventsTabBase("Events"),
          // new UniversitiesTabBase("Universities"),
          new NotificationsTabBase("Posts"),
          new NotificationsTabBase("Events"),
          new NotificationsTabBase("Universities"),
          new NotificationsTabBase("Notifications"),
          new NotificationsTabBase("Profile"),
          // new ProfileTabBase("Profile"),
        ],
        controller: bottomNavTabController,
      ),
    );
  }
}