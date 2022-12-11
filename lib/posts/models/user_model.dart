// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

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
  //List<String>? advertIDs; //need to check

  UserModel({
    this.name,
    this.surname,
    this.email,
    this.password,
    this.passwordAgain,
    //this.advertIDs,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
