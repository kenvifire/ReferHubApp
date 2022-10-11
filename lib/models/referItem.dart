import 'package:flutter/foundation.dart';

class ReferItem {
  late final String id;
  final String title;
  final String? link;
  final String? code;
  final List<String> tags;
  late final bool enabled;
  ReferItem({required this.id, required this.title, this.link, this.code, required this.tags, required this.enabled});

}