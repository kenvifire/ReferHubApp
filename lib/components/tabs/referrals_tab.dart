import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/components/widgets/calendar_view.dart';
import 'package:ref_hub_app/models/referItem.dart';
import 'package:ref_hub_app/services/referral_service.dart';

import '../screens/edit_referral_screen.dart';

class ReferralsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReferralsTabState();
}

class _ReferralsTabState extends State<ReferralsTab> {
  final List<ReferItem> referrals = [];
  final _sl = GetIt.instance;
  late Future<List<ReferItem>> referItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<ReferItem>>(
            future: _sl.get<ReferralService>().loadReferrals(),
            builder: (context, snapshot) {
              return RefreshIndicator(
                  child: Container(
                    child: _list(snapshot),
                  ),
                  onRefresh: onRefresh);
            }),
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => {
            Navigator.pushNamed(context, EditReferralScreen.id)
        })
      ],
    );
  }

  Widget _list(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          itemCount: referrals.length,
          itemBuilder: (context, index) {
            final item = referrals[index];
            return ReferItemTile(referItem: item);
          });
    } else {
      return Center(
        child: Text(snapshot.hasError ? 'Load error' : 'Loading...'),
      );
    }
  }

  Future<void> onRefresh() async {
    List<ReferItem> refreshedRecords =
        await _sl.get<ReferralService>().loadReferrals();
    setState(() {});
  }
}
