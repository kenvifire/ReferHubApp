import 'package:flutter/material.dart';
import 'package:ref_hub_app/components/forms/referral_item_form.dart';
import 'package:ref_hub_app/models/referItem.dart';

class EditReferralScreen extends StatefulWidget {
  static String id = 'EditReferralScreen';
  final ReferItem? item;

  const EditReferralScreen({this.item, Key? key}) : super(key: key);

  @override
  State<EditReferralScreen> createState() => _EditReferralScreenState();
}

class _EditReferralScreenState extends State<EditReferralScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Edit Referral')),
      body: ReferItemForm(item: widget.item,),
    );
  }
}

