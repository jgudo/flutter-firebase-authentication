import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<String> getCurrentUID() async {
    return _auth.currentUser!.uid;
  }

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  Future<void> signIn({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> signUp({ required String email, required String password }) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);

    notifyListeners();
  }
}
