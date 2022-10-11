import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/components/screens/welcome_screen.dart';
import 'package:ref_hub_app/services/referral_service.dart';
import 'package:ref_hub_app/services/search_service.dart';
import 'package:ref_hub_app/services/user_service.dart';

import 'components/screens/home_screen.dart';
import 'components/screens/login_screen.dart';
import 'components/screens/registration_screen.dart';
import 'components/screens/reset_password_screen.dart';

final sl = GetIt.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUp();
  runApp(ReferHubApp());
}



class ReferHubApp extends StatelessWidget {
  const ReferHubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexThemeData.light(scheme: FlexScheme.deepBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      themeMode: ThemeMode.system,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        ResetPasswordScreen.id: (context) => const ResetPasswordScreen(),
      },
    );
  }
}

void setUp() {
  sl.registerSingleton<UserService>(UserService());
  sl.registerSingleton<ReferralService>(ReferralService());
  sl.registerSingleton<SearchService>(SearchService());
}

