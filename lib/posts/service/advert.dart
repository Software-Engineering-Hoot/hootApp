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
    //TODO: bu satırda ilan açan user'a ait advertslerin listesine eklenmeli
    var st = await http.get(Uri.parse("http://localhost:8080/adverts"));
    var temp = json.decode(st.body) as List;
    print(temp);
    return (temp)
        .map((debit) => AdvertModel.fromJson(debit as Map<String, dynamic>))
        .toList();
  }

  Future<AdvertModel> getAdvertDetails(AdvertModel advert) async {
    print(advert);
    var st = await http.post(
      Uri.parse('http://localhost:8080/advertdetails'),
      body: json.encode(advert),
    );

    return jsonDecode(st.body) as AdvertModel;
  }

  //TODO: postAdvert backendi tamamlandı burdan api verilip test edilmeli
  Future<bool> addAdvertWithBackEnd(AdvertModel advert) async {
    // Send a POST request to the specified URL with the data as the request body
    print(advert);
    advert.userIds = ["1"];
    advert.id = 1;
    advert.favoriteCount = 2;
    advert.publisherID = 2;
    var advertJson = advert.toJson();

    var response = await http.post(
      Uri.parse("http://localhost:8080/addadvert"),
      body: "{$advertJson}",
    );

    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
  }

  Future<bool> editAdvert(AdvertModel advert) async {
    // Send a POST request to the specified URL with the data as the request body
    var response = await http.post(
      Uri.parse("http://localhost:8080/editadvert"),
      body: json.encode(advert),
    );

    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
  }

  Future<bool> deleteAdvert(AdvertModel advert) async {
    // Send a DELETE request to the specified URL
    var response = await http.delete(
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
    var response = await http.get(
      Uri.parse('http://localhost:8080/filterbyprice/$min/$max'),
    );
    return (json.decode(response.body) as List)
        .map((debit) => AdvertModel.fromJson(debit as Map<String, dynamic>))
        .toList();
  }

  Future<List<AdvertModel>> filterByPetType(String petType) async {
    var response = await http.get(
      Uri.parse('http://localhost:8080/filterbypettype/$petType'),
    );
    return (json.decode(response.body) as List)
        .map((debit) => AdvertModel.fromJson(debit as Map<String, dynamic>))
        .toList();
  }

  Future<List<AdvertModel>> filterByLocation(String location) async {
    var response = await http.get(
      Uri.parse('http://localhost:8080/filterbyaddress/$location'),
    );
    return (json.decode(response.body) as List)
        .map((debit) => AdvertModel.fromJson(debit as Map<String, dynamic>))
        .toList();
  }
}
