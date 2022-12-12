// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';
import 'dart:math';

import 'package:flutter_infinite_list/posts/models/advert_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? name;
  String? surname;
  String? email;
  String? password;
  String? passwordAgain;
  List<int> advertIDs;
  List<int> favAdvertIDs;
  int? userID;

  UserModel({
    this.name,
    this.surname,
    this.email,
    this.password,
    this.passwordAgain,
    this.advertIDs = const [],
    this.favAdvertIDs = const [],
  }) {
    userID = Random().nextInt(10000);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
