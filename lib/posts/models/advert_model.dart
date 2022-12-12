// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:ffi';

import 'package:flutter_infinite_list/posts/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'advert_model.g.dart';

@JsonSerializable()
class AdvertModel {
  int? id;
  String? title;
  String? petType;
  String? address;
  String? startDate;
  String? endDate;
  double? price;
  String? description;
  List<String> photos;
  int? favoriteCount;
  int? publisherID; //userID of the owner of advert
  List<String> userIds; // list of ids who adds this advert to his/her favorites

  AdvertModel({
    this.id,
    this.title,
    this.petType,
    this.address,
    this.startDate,
    this.endDate,
    this.price,
    this.description,
    this.photos = const [], // Initialize the new field to an empty list
    this.favoriteCount,
    this.publisherID,
    this.userIds = const [], // Initialize the new field to an empty list
  });

  factory AdvertModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertModelToJson(this);
}
