import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:flutter_infinite_list/posts/utils/custom_methods.dart';

class AdvertService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> getAdvert() async {
    try {
     var advert = await _firestore.collection('HootDB').doc('Adverts').get();
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
