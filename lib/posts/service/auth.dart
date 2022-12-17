import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoot/posts/models/user_model.dart';
import 'package:hoot/posts/utils/custom_methods.dart';
import 'package:http/http.dart' as http;

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

      await addUserWithBackEnd(userModel);
      await _firestore.collection('UserDB').add(userModel.toJson());
      await _firestore.collection('Users').doc('Users').set({
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

  Future<bool> addUserWithBackEnd(UserModel user) async {
    // Send a POST request to the specified URL with the data as the request body
    user.userID = _auth.currentUser?.uid;
    final userJson = json.encode(user);
    final response = await http.post(
        Uri.parse("http://192.168.1.21:8080/adduser"),
        body: userJson,
        headers: {"Content-Type": "application/json"});

    // Check the response status code and return true if the request was successful
    return response.statusCode == 200;
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
