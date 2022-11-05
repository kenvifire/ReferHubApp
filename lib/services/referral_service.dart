import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/constants.dart';
import 'package:ref_hub_app/models/query.dart';
import 'package:ref_hub_app/models/referItem.dart';
import 'package:ref_hub_app/services/constants.dart';
import 'package:ref_hub_app/services/user_service.dart';

final _sl = GetIt.instance;
class ReferralService {
  final _db = FirebaseFirestore.instance;
  final _userService = _sl.get<UserService>();
  final _nonTagFields = ["id", "title", "description", "link", "code", "enabled"];

  initUserData() async {
    final uid = _userService.getUser()!.uid;
    await _db.collection(kDB).doc(uid).set({
      'items':[]
    });
  }

  Future<List<ReferItem>> loadReferrals() async {
      final uid = _userService.getUser()!.uid;
      final data = await _db.collection(kDB).doc(uid).get();
      final referrals = data.data() as Map<String, dynamic>;

      final records = referrals[kItems] as List<dynamic>;
      return records.map(mapItem).toList();
  }

  ReferItem mapItem(e) {
     final data = e as Map<String, dynamic>;
     final tags = [];
     data.forEach((key, value) {
       if(!_nonTagFields.contains(key)) {
         tags.add(key);
       }
     });
    return ReferItem(title: e['title'], link: e['link'], id: e['id'],
        enabled: e['enabled'], tags: tags.map((e) => e as String).toList());
  }


  Future<void> addReferral(ReferItem item) async {
    final uid = _sl.get<UserService>().getUser()!.uid;
    Map<String, dynamic> record = toMap(item);
    return await _db.collection(referral).doc(uid).update({
      'items': FieldValue.arrayUnion([record])
      }
    );

  }

  Map<String, dynamic> toMap(ReferItem item) {
    final record = <String, dynamic> {
      'id': item.id,
      'title': item.title,
      'link': item.link,
      'code': item.code,
      'desc': item.desc,
      'enabled': item.enabled
    };

    for(String tag in item.tags) {
      record[tag] = true;
    }
    return record;
  }

  void removeReferral(String uid, ReferItem item) async {
    final uid = _sl.get<UserService>().getUser()!.uid;
    final record = toMap(item);
    await _db.collection(referral).doc(uid).set({
      kItems: FieldValue.arrayRemove([record])
    }
    );
  }

  void disableReferral(ReferItem item) {
    item.enabled = true;
    updateReferral(item);
  }

  void updateReferral(ReferItem item) {
    
  }


  void query(ItemQuery query) {
    _db.collection(referral)
        .where('tag', arrayContainsAny: query.tags)
        .where('type', isEqualTo: query.type)
    .where('location', isEqualTo: query.location)
    .orderBy('score', descending: true)
    // .startAfter(query.last.data().)
    .limit(query.pageSize);
  }
}