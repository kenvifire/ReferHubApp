import 'package:flutter/material.dart';
import 'package:ref_hub_app/components/widgets/refer_item_tile.dart';
import 'package:ref_hub_app/models/referItem.dart';
class MarketsTab extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=> _MarketsState();
}

class _MarketsState extends State<MarketsTab> {
  final List<ReferItem> marketItems = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: marketItems.length,
      itemBuilder: (context, index) {
        final item = marketItems[index];
        return ReferItemTile(referItem: item, onDelete: () {});
      },
    );
  }

}