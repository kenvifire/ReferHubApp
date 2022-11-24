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

  initUserData() async {

  }

  Future<List<ReferItem>> loadReferrals() async {
      final uid = _userService.getUser()!.uid;
      final data = await _db.collection(kReferral).where("uid", isEqualTo: uid).get();
      
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
    final tags = (e['tags'] as List).map((item) => item as String).toList();

    // for(var ele in e['tags']) {
    //   tags.add(ele as String);
    // }
    return ReferItem(title: e['title'], uid: e['uid'], link: e['link'], id: e['id'],
        enabled: e['enabled'], tags: tags,
        category: e['category'], score: e['score'],
        updatedTime: DateTime.fromMillisecondsSinceEpoch(e['updatedTime']),
        createdTime: DateTime.fromMillisecondsSinceEpoch(e['createdTime'],),

    );
  }

  Future<void> addReferral(ReferItem item) async {
    ReferItem referItem = ReferItem.from(item);
    final uid = _sl.get<UserService>().getUser()!.uid;
    String id = Uuid().v4();
    referItem.setId(id);
    referItem.setUid(uid);
    referItem.setUpdatedTime(DateTime.now());
    referItem.setCreatedTime(DateTime.now());
    referItem.setScore(0.0);
    return await _db.collection(referral).doc(id).set(toMap(referItem));
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
      'updatedTime': item.updatedTime?.millisecondsSinceEpoch,
      'createdTime': item.createdTime?.microsecondsSinceEpoch,
      'score': item.score,
      'category': item.category,
      'tags': item.tags
    };

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
    ReferItem referItem = ReferItem.from(item);
    referItem.setUpdatedTime(DateTime.now());
    await _db.collection(referral).doc(item.id).update(toMap(referItem));
  }

  Future<List<ReferItem>> query(ItemQuery itemQuery) async {
    var ref = _db.collection(referral);
    Query query = ref.limit(itemQuery.pageSize);//.orderBy('score', descending: true)
    if(itemQuery.tags != null)  {
      query = query.where('tags', arrayContainsAny: itemQuery.tags);
    }

    if(itemQuery.name != null) {
      query = query.where('title', isEqualTo: itemQuery.name);
    }


    // .orderBy('score', descending: true)

    // if(itemQuery.last?.data() != null) {
    //   query = query.startAfter(itemQuery.last?.data());
    // }
    // .startAfter(query.last.data().)
    //.limit(query.pageSize).get();

    final snapshot = await query.get();
    if(snapshot.docs.isEmpty) {
      return Future.value([]);
    }

    List<ReferItem> items = [];
    List<String> favouriteList = await loadFavourites();
    snapshot.docs.forEach((doc) {
      ReferItem item = mapItem(doc.data());
      item.isFavourite = favouriteList.contains(item.id);
      items.add(item);
    });
    return Future.value(items);
  }

  Future<void> scoreItem(String id, double score) async {

  }

  Future<void> addToFavourite(String id) async {
    final uid = _sl.get<UserService>().getUser()!.uid;
    final ref = _db.collection(kUser);
    final doc = await ref.doc(uid).get();
    if(doc.exists) {
      print(doc.data());
      await ref.doc(uid).update({
        kFavourite: FieldValue.arrayUnion([id])
      });

    } else {
      await ref.doc(uid).set({
        kFavourite: [uid]
      });
    }
  }

  Future<List<String>> loadFavourites() async {
    final uid = _sl.get<UserService>().getUser()!.uid;
    final ref = _db.collection(kUser);
    final data = await ref.doc(uid).get();
    if(data.exists) {
      final doc = data.data() as Map<String, dynamic>;
      return (doc[kFavourite] as List).map((item) => item as String).toList();
    } else {
      return Future.value([]);
    }

  }

  Future<void> removeFromFavourite(String id) async {
    final uid = _sl.get<UserService>().getUser()!.uid;
    final ref = _db.collection(kUser);
    final data = await ref.doc(uid).get();
    if(data.exists) {
      await ref.doc(uid).update({
        kFavourite: FieldValue.arrayRemove([id])
      });
    }
  }
}