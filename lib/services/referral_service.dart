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

  Future<List<ReferItem>> loadReferrals() async {
      final uid = _userService.getUser()!.uid;
      final data = await _db.collection(kDB).doc(uid).get();
      final referrals = data.data() as Map<String, dynamic>;

      final records = referrals['items'] as List<dynamic>;
      return records.map(mapItem).toList();
  }

  ReferItem mapItem(e) => ReferItem(title: e['title'], link: e['link'], id: e['id'],
  enabled: e['enabled'], tags: e['tags']);


  void addReferral(ReferItem item) async {
    final uid = _sl.get<UserService>().getUser()!.uid;
    String id = const Uuid().v4();
    item.id = id;
    Map<String, dynamic> record = toMap(item);
    await _db.collection(referral).doc(uid).set({
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
      'tags': [
        item.tags
      ]
    };
    return record;
  }

  void removeReferral(String uid, ReferItem item) async {
    final uid = _sl.get<UserService>().getUser()!.uid;
    final record = toMap(item);
    await _db.collection(referral).doc(uid).set({
      'items': FieldValue.arrayRemove([record])
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