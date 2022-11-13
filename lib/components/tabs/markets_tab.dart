import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/components/widgets/refer_item_tile.dart';
import 'package:ref_hub_app/models/query.dart';
import 'package:ref_hub_app/models/referItem.dart';

import '../../services/referral_service.dart';
import '../screens/edit_referral_screen.dart';
class MarketsTab extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=> _MarketsState();
}

class _MarketsState extends State<MarketsTab> {
  final _sl = GetIt.instance;
  late Future<List<ReferItem>> referItems;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReferItem>>(
        future: _sl.get<ReferralService>().query(ItemQuery()),
        builder: (context, snapshot) {
          return RefreshIndicator(
              child: Column(children: [
                Flexible(child: _list(snapshot)),
              ]),
              onRefresh: onRefresh);
        });
  }

  Widget _list(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      List<ReferItem> items = snapshot.data as List<ReferItem>;

      return items.isEmpty
          ? const Center(
          child: Text("Nothing found"))
          : ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ReferItemTile(referItem: item, onDelete: onRefresh);
          });
    } else {
      return Center(
        child: Text(snapshot.hasError ? 'Load error' : 'Loading...'),
      );
    }
  }

  Future<void> onRefresh() async {
    setState(() {});
  }

}