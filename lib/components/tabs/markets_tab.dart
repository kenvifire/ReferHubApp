import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/components/widgets/refer_item_tile.dart';
import 'package:ref_hub_app/constants.dart';
import 'package:ref_hub_app/models/query.dart';
import 'package:ref_hub_app/models/referItem.dart';
import '../../services/referral_service.dart';

class MarketsTab extends StatefulWidget {

  @override
  State<StatefulWidget> createState()=> _MarketsState();
}

class _MarketsState extends State<MarketsTab> {
  final _sl = GetIt.instance;
  late Future<List<ReferItem>> referItems;
  final _formKey = GlobalKey<FormBuilderState>();
  ItemQuery query = ItemQuery();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: FutureBuilder<List<ReferItem>>(
          future: _sl.get<ReferralService>().query(query),
          builder: (context, snapshot) {
            return Column(
                children: [
              Flexible(
                flex: 1,
                child: FormBuilder(
                  key: _formKey,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                          child: FormBuilderTextField(name: 'name')),
                      Flexible(
                        flex: 1,
                        child: FloatingActionButton(onPressed: () {
                          query = new ItemQuery();
                          final name = _formKey.currentState!.fields['name']?.value;
                          if(name != null && name != "") {
                            query.name = name;
                          }
                          onRefresh();
                        },
                        child: Text("Search"),),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                  child: _list(snapshot)),
            ]);
          }),
    );
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
            return ReferItemTile(referItem: item, onDelete: onRefresh, onShare: () {shareModalBottomSheet(context);},);
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