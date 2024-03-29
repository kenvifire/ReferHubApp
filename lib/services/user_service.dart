import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:ref_hub_app/services/referral_service.dart';
class UserService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _sl = GetIt.I;

  authWithEmailAndPassword(String email, String password) async {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred;
  }

  createWithEmailAndPassword({required String email, required String password}) async {
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      initUserData();
      return user;
  }

  void initUserData() {
    _sl.get<ReferralService>().initUserData();
  }


  User? getUser() {
    return _auth.currentUser;
  }

  void signOut() async {
    await _auth.signOut();
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

}
