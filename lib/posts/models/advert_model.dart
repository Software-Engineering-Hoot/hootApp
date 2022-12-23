// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'advert_model.g.dart';

@JsonSerializable()
class AdvertModel {
  String? id;
  String? address;
  String? description;
  String? endDate;
  int? favoriteCount;
  String? petType;
  List<String>? photos;
  double? price;
  String? startDate;
  String? title;
  String? publisherID; //userID of the owner of advert
  List<String>? userIDs;

  AdvertModel({
    this.id,
    this.title,
    this.petType,
    this.address,
    this.startDate,
    this.endDate,
    this.price,
    this.description,
    this.photos,
    this.favoriteCount,
    this.publisherID,
    this.userIDs,
  }) {
    userIDs = [];
  }

  factory AdvertModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertModelToJson(this);
}
