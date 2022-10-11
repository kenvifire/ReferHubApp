import 'package:flutter/material.dart';
import 'package:ref_hub_app/components/widgets/calendar_view.dart';
import 'package:ref_hub_app/models/referItem.dart';

class ReferralsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReferralsTabState();
}

class _ReferralsTabState extends State<ReferralsTab> {
  final List<ReferItem> referrals = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: referrals.length,
      itemBuilder: (context, index) {
        final item = referrals[index];
        return ReferItemTile(referItem: item);
      },
    );
  }

}

