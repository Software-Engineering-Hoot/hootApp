import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hoot/posts/models/advert_model.dart';
import 'package:hoot/posts/models/user_model.dart';
import 'package:hoot/posts/utils/custom_methods.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class AdvertService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

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
    final st = await http.get(Uri.parse('http://localhost:8080/adverts'));
    final temp = json.decode(st.body) as List;
    return (temp)
        .map((advert) => AdvertModel.fromJson(advert as Map<String, dynamic>))
        .toList();
  }

  Future<UserModel> getUserDetails() async {
    final st = await http.post(
      Uri.parse('http://localhost:8080/getuser'),
      body: {'userID': '${_auth.currentUser?.uid}'},
    );

    final model =
        UserModel.fromJson(jsonDecode(st.body) as Map<String, dynamic>);

    return model;
  }

  Future<List<AdvertModel>> getUserAdverts() async {
    final body = {'userID': '${_auth.currentUser?.uid}'};
    final bodyString = json.encode(body);

    final st = await http.post(
      Uri.parse('http://localhost:8080/useradverts'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );

    print(st);
    final temp = json.decode(st.body) as List;
    print(temp);
    return (temp)
        .map((advert) => AdvertModel.fromJson(advert as Map<String, dynamic>))
        .toList();
  }

  Future<String> uploadFile(File _image) async {
    Reference storageReference = FirebaseStorage.instance.ref().child("test/");

    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask;
    print('File Uploaded');
    var returnURL = '';
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  Future<void> saveImages(File image, DocumentReference ref) async {
    String imageURL = await uploadFile(image);
    await ref.update({
      'images': FieldValue.arrayUnion([imageURL])
    });
  }

  Future<bool> addAdvertWithBackEnd(
      AdvertModel advert, List<XFile> files) async {
    for (final element in files) {
      var file = File(files.first.path);
      Reference ref =
          FirebaseStorage.instance.ref().child(file.hashCode.toString());
      TaskSnapshot snapshot = await ref.putFile(file);
      String url = await snapshot.ref.getDownloadURL();
      print(url);

      if (advert.photos == null) {
        advert.photos = [];
      }
      advert.photos?.add(url);
    }

    advert.publisherID = _auth.currentUser?.uid;
    final response = await http.post(
        Uri.parse('http://localhost:8080/addadvert'),
        body: json.encode(advert),
        headers: {'Content-Type': 'application/json'});

    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
  }

  Future<bool> addAdvertFavorite(AdvertModel advert) async {
    // Send a POST request to the specified URL with the data as the request body
    final userID = _auth.currentUser!.uid;
    final advertID = advert.id;
    final body = json.encode({'userID': userID, 'advertID': advertID});
    advert.userIds?.add(userID);
    await editAdvert(advert);
    final response = await http.post(Uri.parse('http://localhost:8080/favplus'),
        body: body, headers: {'Content-Type': 'application/json'});
    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
  }

  Future<bool> deleteAdvertFavorite(AdvertModel advert) async {
    // Send a POST request to the specified URL with the data as the request body
    final userID = _auth.currentUser!.uid;
    final advertID = advert.id;
    final body = json.encode({'userID': userID, 'advertID': advertID});
    advert.userIds?.remove(userID);
    await editAdvert(advert);
    final response = await http.post(
        Uri.parse('http://localhost:8080/favminus'),
        body: body,
        headers: {'Content-Type': 'application/json'});
    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
  }

  Future<bool> editAdvert(AdvertModel advert) async {
    // Send a POST request to the specified URL with the data as the request body
    final response = await http.post(
      Uri.parse('http://localhost:8080/editadvert'),
      body: json.encode(advert),
      headers: {'Content-Type': 'application/json'},
    );

    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
  }

  Future<bool> editUser(UserModel user) async {
    // Send a POST request to the specified URL with the data as the request body
    final response = await http.post(
      Uri.parse('http://localhost:8080/edituser'),
      body: json.encode(user),
      headers: {'Content-Type': 'application/json'},
    );

    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
  }

  Future<bool> deleteAdvert(AdvertModel advert) async {
    // Send a DELETE request to the specified URL
    final response = await http.delete(
      Uri.parse('http://localhost:8080/deleteadvert'),
      body: json.encode(advert),
      headers: {'Content-Type': 'application/json'},
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
        .map((advert) => AdvertModel.fromJson(advert as Map<String, dynamic>))
        .toList();
  }

  Future<List<AdvertModel>> filterByAll(
      String city, String petType, double amount) async {
    if (city.isEmpty) city = "all";
    if (petType.isEmpty) petType = "all";
    amount = 1000;
    print(petType);
    final response = await http.get(
      Uri.parse('http://localhost:8080/filterByAll/$city/$petType/$amount'),
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
        .map((advert) => AdvertModel.fromJson(advert as Map<String, dynamic>))
        .toList();
  }

  Future<List<AdvertModel>> filterByLocation(String location) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/filterbyaddress/$location'),
    );
    return (json.decode(response.body) as List)
        .map((advert) => AdvertModel.fromJson(advert as Map<String, dynamic>))
        .toList();
  }
}
