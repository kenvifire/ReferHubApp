
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/constants.dart';
import 'package:ref_hub_app/models/query.dart';
import 'package:ref_hub_app/models/referItem.dart';
import 'package:ref_hub_app/services/constants.dart';
import 'package:ref_hub_app/services/user_service.dart';
import 'package:uuid/uuid.dart';

final _sl = GetIt.instance;
class ReferralService {
  final _db = FirebaseFirestore.instance;
  final _userService = _sl.get<UserService>();
  final _nonTagFields = ["id", "title", "description", "link", "code", "enabled", "uid"];

  initUserData() async {
  }

  Future<List<ReferItem>> loadReferrals() async {
      final uid = _userService.getUser()!.uid;
      final data = await _db.collection(kDB).where("uid", isEqualTo: uid).get();
      
      if(data.docs.isEmpty) {
        return Future.value([]);
      } else {
        List<ReferItem> items = [];
        data.docs.forEach((doc) {
          final item = mapItem(doc.data());
          items.add(item);
        });
        
        return Future.value(items);
      }
  }

  ReferItem mapItem(e) {
     final data = e as Map<String, dynamic>;
     final tags = [];
     data.forEach((key, value) {
       if(!_nonTagFields.contains(key)) {
         tags.add(key);
       }
     });
    return ReferItem(title: e['title'], uid: e['uid'], link: e['link'], id: e['id'],
        enabled: e['enabled'], tags: tags.map((e) => e as String).toList());
  }

  Future<void> addReferral(ReferItem item) async {
    final uid = _sl.get<UserService>().getUser()!.uid;
    Map<String, dynamic> record = toMap(item);
    String id = Uuid().v4();
    record['id'] = id;
    record['uid'] = uid;
    return await _db.collection(referral).doc(id).set(record);
  }

  Map<String, dynamic> toMap(ReferItem item) {
    final record = <String, dynamic> {
      'id': item.id,
      'title': item.title,
      'link': item.link,
      'code': item.code,
      'desc': item.desc,
      'enabled': item.enabled,
      'uid': item.uid,
    };

    for(String tag in item.tags) {
      record[tag] = true;
    }
    return record;
  }

  Future<void> removeReferral(ReferItem item) async {
    await _db.collection(referral).doc(item.id).delete();
  }

  void disableReferral(ReferItem item) {
    item.enabled = true;
    updateReferral(item);
  }

  Future<void> updateReferral(ReferItem item) async {
    await _db.collection(referral).doc(item.id).set(toMap(item));
  }

  Future<List<ReferItem>> query(ItemQuery query) async {
    final snapshot = await _db.collection(referral)
        .where('tag', arrayContainsAny: query.tags)
        // .where('type', isEqualTo: query.type)
    // .where('location', isEqualTo: query.location)
    // .orderBy('score', descending: true)
    // .startAfter(query.last.data().)
    .limit(query.pageSize).get();
    if(snapshot.docs.isEmpty) {
      return Future.value([]);
    }

    List<ReferItem> items = [];
    snapshot.docs.forEach((doc) {
        items.add(mapItem(doc.data()));
    });
    return Future.value(items);
  }
}