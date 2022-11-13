class ReferItem {
  final String? id;
  final String title;
  final String? link;
  final String? code;
  final List<String> tags;
  final String? desc;
  final String uid;
  late final bool enabled;
  ReferItem({this.id, required this.title, required this.uid, this.link, this.code, required this.tags,
    required this.enabled,
    this.desc
  });

  @override
  bool operator ==(Object other) {
    return other is ReferItem && this.id == (other).id
        && this.title == other.title
        && this.enabled == other.enabled
        && this.desc == other.desc
        && this.tags == other.tags
        && this.code == other.code
        && this.link == other.link
        && this.uid == this.uid;
  }

  @override
  int get hashCode => super.hashCode;
}