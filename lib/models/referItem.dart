import 'package:flutter/foundation.dart';

class ReferItem {
  final String id;
  final String title;
  final String? link;
  final String? code;
  final List<String> tags;
  final String? desc;
  late final bool enabled;
  ReferItem({required this.id, required this.title, this.link, this.code, required this.tags,
    required this.enabled,
    this.desc
  });

  @override
  bool operator ==(Object other) {
    return this.id == (other as ReferItem).id
        && this.title == other.title
        && this.enabled == other.enabled
        && this.desc == other.desc
        && this.tags == other.tags
        && this.code == other.code
        && this.link == other.link;
  }

}