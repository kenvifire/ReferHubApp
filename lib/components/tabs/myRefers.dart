import 'package:flutter/material.dart';
import 'package:ref_hub_app/models/referItem.dart';

class MyRefersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyRefersState();
  }

}

class _MyRefersState extends State<MyRefersPage> {
  final List<ReferItem> items = [ReferItem(title: 'test', link: 'testlink'),
    ReferItem(title: 'test title', link: 'test link')];

//  void _setItems() {
//    setState(() {
//      items,
//    });
//  }



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          title: Text(item.title)
        );
      },

    );
  }

}

