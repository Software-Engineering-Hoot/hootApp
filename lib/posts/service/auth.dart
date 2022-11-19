import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUp(
      String name, String surname, String _email, String _password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: _email, password: _password);

    await _firestore.collection('User').doc(_auth.currentUser!.uid).set({
      'Name': name,
      'Surname': surname,
      'Email': _email,
    });

    return user.user;
  }
}
