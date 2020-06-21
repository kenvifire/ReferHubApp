import 'package:ReferHubApp/models/friend.dart';
import 'package:flutter/material.dart';

class FriendsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FriendsState();
  }

}

class _FriendsState extends State<FriendsPage> {
  final List<Friend> friends = [ Friend(name: 'f1', refers: 2), Friend(name: 'f2', refers: 3)];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final item = friends[index];
        return ListTile(
          title: Text(item.name),
        );
      },
    );
  }

}

