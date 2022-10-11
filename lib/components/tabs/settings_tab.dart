import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../services/user_service.dart';
import '../buttons/rounded_button.dart';
import '../screens/welcome_screen.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final _sl = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_sl.get<UserService>().getUser()!.email!),
        RoundedButton(
          title: 'Sign Out',
          onPressed: () {
            _sl.get<UserService>().signOut();
            Navigator.of(context).pushNamed(WelcomeScreen.id);
          },
        ),
      ],
    );
  }

}
