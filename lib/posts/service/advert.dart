import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/utils/custom_methods.dart';

class AdvertService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //   Future<List<AdvertModel>> getAdvert() async {
  //   List<AdvertModel> advertList = [];
  //   try {
  //     final docRef = _firestore.collection("HootDB").doc("Adverts");
  //     await docRef.get().then(
  //       (DocumentSnapshot doc) {
  //         final data = doc.data() as Map<String, dynamic>;
  //         data.values.first.forEach((element) {
  //           advertList
  //               .add(AdvertModel.fromJson(element as Map<String, dynamic>));
  //         });
  //       },
  //       onError: (e) => print("Error getting document: $e"),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     flutterToast(e.code, Colors.red);
  //     return [];
  //   }
  //   flutterToast('Please_Verify', Colors.green);
  //   return advertList;
  // }

  Future<List<AdvertModel>> getAdvert() async {
    List<AdvertModel> advertList = [];
    await _firestore.collection('HootDB').get().then(
      (res) async {
        for (var element in res.docs) {
          await _firestore.collection('HootDB').doc(element.id).get().then(
            (DocumentSnapshot doc) {
              final data = doc.data() as Map<String, dynamic>;

              advertList
                  .add(AdvertModel.fromJson(data as Map<String, dynamic>));
            },
            onError: (e) => print('Error getting document: $e'),
          );
        }
        return advertList;
      },
      onError: (e) => print('Error completing: $e'),
    );
    return advertList;
  }

  Future<bool> addAdvert(AdvertModel advert) async {
    try {
      await _firestore.collection('HootDB').add(advert.toJson());
    } on FirebaseAuthException catch (e) {
      flutterToast(e.code, Colors.red);
      return false;
    }
    flutterToast('Insert_Advert', Colors.green);
    return true;
  }
}
