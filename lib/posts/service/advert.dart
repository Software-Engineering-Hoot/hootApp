import 'dart:convert';
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
    final List<AdvertModel> advertList = [];
    await _firestore.collection('AdvertDB').get().then(
      (res) async {
        for (var element in res.docs) {
          await _firestore.collection('AdvertDB').doc(element.id).get().then(
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
    final st = await http.get(Uri.parse("http://localhost:8080/adverts"));
    final temp = json.decode(st.body) as List;
    return (temp)
        .map((debit) => AdvertModel.fromJson(debit as Map<String, dynamic>))
        .toList();
  }

  Future<AdvertModel> getAdvertDetails(AdvertModel advert) async {
    print(advert);
    final st = await http.post(
      Uri.parse('http://localhost:8080/advertdetails'),
      body: json.encode(advert),
    );

    return jsonDecode(st.body) as AdvertModel;
  }

  Future<bool> addAdvertWithBackEnd(AdvertModel advert) async {
    // Send a POST request to the specified URL with the data as the request body
    advert.publisherID = _auth.currentUser?.uid;
    final advertJson = json.encode(advert);
    final response = await http.post(
        Uri.parse("http://localhost:8080/addadvert"),
        body: advertJson,
        headers: {"Content-Type": "application/json"});

    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
  }

  Future<bool> editAdvert(AdvertModel advert) async {
    // Send a POST request to the specified URL with the data as the request body
    final response = await http.post(
      Uri.parse("http://localhost:8080/editadvert"),
      body: json.encode(advert),
    );

    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
  }

  Future<bool> deleteAdvert(AdvertModel advert) async {
    // Send a DELETE request to the specified URL
    final response = await http.delete(
      Uri.parse("http://localhost:8080/deleteadvert"),
      body: json.encode(advert),
    );

    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
  }

  Future<bool> addAdvert(AdvertModel advert) async {
    try {
      await _firestore.collection('AdvertDB').add(advert.toJson());
    } on FirebaseAuthException catch (e) {
      flutterToast(e.code, Colors.red);
      return false;
    }
    flutterToast('Insert_Advert', Colors.green);
    return true;
  }

  Future<List<AdvertModel>> filterByPrice(num min, num max) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/filterbyprice/$min/$max'),
    );
    return (json.decode(response.body) as List)
        .map((debit) => AdvertModel.fromJson(debit as Map<String, dynamic>))
        .toList();
  }

  Future<List<AdvertModel>> filterByAll(
      String city, String petType, double amount) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/filterbyprice/$city/$petType/$amount'),
    );
    print(response);
    return (json.decode(response.body) as List)
        .map((advert) => AdvertModel.fromJson(advert as Map<String, dynamic>))
        .toList();
  }

  Future<List<AdvertModel>> filterByPetType(String petType) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/filterbypettype/$petType'),
    );
    return (json.decode(response.body) as List)
        .map((debit) => AdvertModel.fromJson(debit as Map<String, dynamic>))
        .toList();
  }

  Future<List<AdvertModel>> filterByLocation(String location) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/filterbyaddress/$location'),
    );
    return (json.decode(response.body) as List)
        .map((debit) => AdvertModel.fromJson(debit as Map<String, dynamic>))
        .toList();
  }
}
