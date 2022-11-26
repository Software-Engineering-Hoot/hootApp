import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // if (user.user!.emailVerified) {
      //   return user.user;
      // }
      return user.user;
    } catch (e) {
      return null;
    }
  }

  Future<Response> signUp(
      String name, String surname, String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore.collection('HootDB').doc('Users').set({
        'Name': name,
        'Surname': surname,
        'Email': email,
        'Password': password,
      });
    } catch (e) {}

    return Response("body", 400);
  }
}
