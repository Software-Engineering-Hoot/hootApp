import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:flutter_infinite_list/posts/utils/custom_methods.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signIn(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!user.user!.emailVerified) {
        flutterToast('Not_Verified', Colors.redAccent);
        return false;
      }
    } on FirebaseAuthException catch (e) {
      flutterToast(e.code, Colors.red);
      return false;
    }
    return true;
  }

  Future<bool> signUp(UserModel userModel) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: userModel.email!, password: userModel.password!)
          .then((value) {
        final user = FirebaseAuth.instance.currentUser;
        user?.sendEmailVerification();
      });

      await _firestore.collection('HootDB').doc('Users').set({
        'Name': userModel.name,
        'Surname': userModel.surname,
        'Email': userModel.email,
        'Password': userModel.password,
      });
    } on FirebaseAuthException catch (e) {
      flutterToast(e.code, Colors.red);
      return false;
    }
    flutterToast('Please_Verify', Colors.green);
    return true;
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      flutterToast(e.code, Colors.red);
      return false;
    }
    flutterToast('Reset_Verify', Colors.green);
    return true;
  }
}
