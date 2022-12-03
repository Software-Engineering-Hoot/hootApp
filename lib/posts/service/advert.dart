import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:flutter_infinite_list/posts/utils/custom_methods.dart';

class AdvertService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<AdvertModel>> getAdvert() async {
    List<AdvertModel> advertList = [];
    try {
      final docRef = _firestore.collection("HootDB").doc("Adverts");
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // advertList.addAll(data.values as AdvertModel) ;
          return (data.values as List).map((advert) => advertList).toList();
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } on FirebaseAuthException catch (e) {
      flutterToast(e.code, Colors.red);
      return [];
    }
    flutterToast('Please_Verify', Colors.green);
    return advertList;
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
