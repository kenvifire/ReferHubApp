import 'package:uuid/uuid.dart';

class ReferItem {
  String? id = Uuid().v4();
  final String title;
  final String? link;
  final String? code;
  final List<String> tags;
  final String? desc;
  late String uid;
  DateTime? createdTime = DateTime.now();
  DateTime? updatedTime = DateTime.now();
  double? score = 0.0;
  final String category;

  late final bool enabled;

  ReferItem(
      {this.id,
      required this.title,
      required this.uid,
      this.link,
      this.code,
      required this.tags,
      required this.category,
      required this.enabled,
      this.updatedTime,
      this.createdTime,
      this.score,
      this.desc});

  void setUpdatedTime(DateTime time) {
    updatedTime = time;
  }

  void setId(String id) {
    this.id = id;
  }

  void setUid(String uid) {
    this.uid = uid;
  }

  void setCreatedTime(DateTime time) {
    this.createdTime = time;
  }

  void setScore(double score) {
    this.score = score;
  }

  @override
  bool operator ==(Object other) {
    return other is ReferItem &&
        this.id == (other).id &&
        this.title == other.title &&
        this.enabled == other.enabled &&
        this.desc == other.desc &&
        this.tags == other.tags &&
        this.code == other.code &&
        this.link == other.link &&
        this.uid == other.uid &&
        this.updatedTime == other.updatedTime &&
        this.createdTime == other.createdTime &&
        this.category == other.category &&
        this.score == other.score;
  }

  @override
  int get hashCode => super.hashCode;

  factory ReferItem.from(ReferItem other) {
    return ReferItem(
        id: other.id,
        title: other.title,
        uid: other.uid,
        tags: other.tags,
        category: other.category,
        enabled: other.enabled,
        updatedTime: other.updatedTime,
        createdTime: other.createdTime,
        score: other.score);
  }
}
