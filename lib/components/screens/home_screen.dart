import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../tabs/friends.dart';
import '../tabs/markets.dart';
import '../tabs/myRefers.dart';

final sl = GetIt.instance;

class HomeScreen extends StatefulWidget {
  static String id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  late StreamSubscription<dynamic> _subscription;

  final _sl = GetIt.I;


 @override
  void initState() {


    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(

        length: 3,

        child: Scaffold(
          appBar: AppBar(
            title: const Text("My Vide Logs",),
            centerTitle: true,
            automaticallyImplyLeading: false,

          ),
          bottomNavigationBar: menu(context),
          body: TabBarView(
            // physics: NeverScrollableScrollPhysics(),
            children: [
              FriendsPage(),
              MarketsPage(),
              MyRefersPage(),
            ],
          ),

        ),
      ),
    );
  }

  Widget menu(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: const TabBar(
        // labelColor: Colors.white,
        // unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        // indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: "New Video",
            icon: Icon(Icons.camera_alt),
          ),
          Tab(
            text: "My Videos",
            icon: Icon(Icons.calendar_month),
          ),
          Tab(
            text: "Settings",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }


}
