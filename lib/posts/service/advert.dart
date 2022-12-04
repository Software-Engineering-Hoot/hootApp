import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:flutter_infinite_list/posts/utils/custom_methods.dart';
import 'package:http/http.dart' as http;

class AdvertService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<List<AdvertModel>> getAdvertWithBackEnd() async {
    var st = await http.get(Uri.parse("http://localhost:8080/adverts"));
    return (json.decode(st.body) as List)
        .map((debit) => AdvertModel.fromJson(debit as Map<String, dynamic>))
        .toList();
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
