import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthentication {
  static Future<bool> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print('Login Error : $e');
      return false;
    }
  }

  static Future<bool> register({required String username, required String email, required String password}) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final uid = result.user?.uid;

      if (uid != null) {
        await FirebaseFirestore.instance.collection('user').doc(uid).set({
          'uid': uid,
          'username': username,
          'email': email,
          'tanggalGabung': DateTime.now().toIso8601String()
        });
        return true;
      }
      return false;
    } catch (e) {
      print('Register Error: $e');
      return false;
    }
  }
}