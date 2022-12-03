import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/utils/custom_methods.dart';

class AdvertService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<AdvertModel>> getAdvert() async {
    List<AdvertModel> advertList = [];
    try {
      var docRef = await _firestore.collection("HootDB").get().then(
        (res) {
          res.forEach((element) {
            advertList
                .add(AdvertModel.fromJson(element as Map<String, dynamic>));
          });
        },
        onError: (e) => print("Error completing: $e"),
      );
      // docRef.forEach((element) {
      //   advertList.add(AdvertModel.fromJson(element as Map<String, dynamic>));

      // });
    } on FirebaseAuthException catch (e) {
      flutterToast(e.code, Colors.red);
      return [];
    }
    flutterToast('Please_Verify', Colors.green);
    return advertList;
  }

  Future<bool> addAdvert(AdvertModel advert) async {
    try {
      await _firestore.collection('HootDB').add(advert.toJson());
    } on FirebaseAuthException catch (e) {
      flutterToast(e.code, Colors.red);
      return false;
    }
    flutterToast('Reset_Verify', Colors.green);
    return true;
  }
}
