import 'package:flutter/material.dart';
import 'package:ref_hub_app/components/forms/referral_item_form.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditReferralScreen extends StatefulWidget {
  static String id = 'EditReferralScreen';

  const EditReferralScreen({Key? key}) : super(key: key);

  @override
  State<EditReferralScreen> createState() => _EditReferralScreenState();
}

class _EditReferralScreenState extends State<EditReferralScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Edit Referral')),
      body: ReferItemForm(),
    );
  }
}

