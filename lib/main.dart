import 'package:ReferHubApp/view/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ReferHubApp());
}

class ReferHubApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

