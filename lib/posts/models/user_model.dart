// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';
import 'dart:math';

import 'package:hoot/posts/models/advert_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? name;
  String? surname;
  String? email;
  String? password;
  String? passwordAgain;
  List<String>? advertIDs;
  List<String>? favAdvertIDs;
  List<String>? notifications;
  bool? isModerator;
  String? userID;
  String? phoneNumber;
  String? location;
  String? profilPic;

  UserModel({
    this.name,
    this.surname,
    this.email,
    this.password,
    this.passwordAgain,
    this.advertIDs,
    this.favAdvertIDs,
    this.phoneNumber,
    this.userID,
    this.notifications,
    this.isModerator,
    this.location,
    this.profilPic
  }) {
    advertIDs = [];
    favAdvertIDs = [];
    notifications = [];
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
