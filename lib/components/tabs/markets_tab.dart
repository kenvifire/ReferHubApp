
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/components/widgets/refer_item_tile.dart';
import 'package:ref_hub_app/components/widgets/text_field_tags.dart';
import 'package:ref_hub_app/constants.dart';
import 'package:ref_hub_app/models/query.dart';
import 'package:ref_hub_app/models/referItem.dart';
import 'package:textfield_tags/textfield_tags.dart';
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
  final TextfieldTagsController tagsController = TextfieldTagsController();
  late double _distanceToField;
  List<String> tags = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
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
                          child:
                          FormBuilderTextField(name: 'name',
                            decoration: InputDecoration(hintText: "Enter name"),

                          )),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                          query = new ItemQuery();
                          final name = _formKey.currentState!.fields['name']?.value;
                          final tags = tagsController.getTags;
                          if(name != null && name != "") {
                            query.name = name;
                          }
                          if(tags != null) {
                            query.tags = tags.cast<String>();
                          }
                          onRefresh();
                        },
                        icon: Icon(Icons.search, size: 25, color: Colors.white,)),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Results"),
                  TextButton(
                    
                  onPressed: () {
                    filterModalBottomSheet(context);
                  }, child: Text("Filters"),)

                ],

              ),
              SizedBox(
                height: 5,
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

  filterModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (bc) {
      return Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(Icons.cancel, color: Colors.orange, size: 25,),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("Tags"),
              TagInput(initialTags: tags, tagController: tagsController, distanceToField: _distanceToField, enabled: true)
        ],),
        Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Text("Categories")
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Text("User reviews")
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Text("Recently added")
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Text("Sort by")
              ],
            )
          ],
        ),
      );
    }).whenComplete(() {
      tags = tagsController.getTags! as List<String>;
    });
  }

}