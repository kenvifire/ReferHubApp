import 'package:ReferHubApp/view/friends.dart';
import 'package:ReferHubApp/view/markets.dart';
import 'package:ReferHubApp/view/myRefers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.store)),
                ]),
            title: Text("My Refer Hub"),
          ),
          body: TabBarView(
            children: <Widget>[
              MyRefersPage(),
              FriendsPage(),
              MarketsPage(),
            ],
          )
      ),
    );
  }
}