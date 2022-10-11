import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ref_hub_app/models/referItem.dart';

class ItemQuery {
  String? type;
  List<String>? tags;
  String? location;
  DocumentSnapshot<ReferItem>? last;
  var pageSize = 10;

  ItemQuery({this.type, this.tags, this.location});

}