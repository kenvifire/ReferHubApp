import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../tabs/referrals_tab.dart';
import '../tabs/markets_tab.dart';
import '../tabs/settings_tab.dart';

final sl = GetIt.instance;

class HomeScreen extends StatefulWidget {
  static String id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  late StreamSubscription<dynamic> _subscription;

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
            title: const Text("My Referrals",),
            centerTitle: true,
            backgroundColor: Colors.green,
            automaticallyImplyLeading: false,
          ),
          bottomNavigationBar: menu(context),
          body: SafeArea(
            child: TabBarView(
              children: [
                ReferralsTab(),
                MarketsTab(),
                SettingsTab(),
              ],
            ),
          ),

        ),
      ),
    );
  }

  Widget menu(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: const TabBar(
        // labelColor: Colors.white,
        // unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        // indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: "My Referrals",
            icon: Icon(Icons.web),
          ),
          Tab(
            text: "Market",
            icon: Icon(Icons.shopping_cart),
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
