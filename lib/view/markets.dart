import 'package:ReferHubApp/models/marketItem.dart';
import 'package:flutter/material.dart';

class MarketsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MarketsState();
  }

}

class _MarketsState extends State<MarketsPage> {
  final List<MarketItem> marketItems = [ MarketItem(link: 'test1', usedCount: 100),
    MarketItem(link: 'test2', usedCount: 200)];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: marketItems.length,
      itemBuilder: (context, index) {
        final item = marketItems[index];
        return ListTile(
          title: Text(item.link),
        );
      },
    );
  }

}