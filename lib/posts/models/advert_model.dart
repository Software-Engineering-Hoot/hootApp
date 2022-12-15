// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'advert_model.g.dart';

@JsonSerializable()
class AdvertModel {
  int? id;
  String? address;
  String? description;
  String? endDate;
  int? favoriteCount;
  String? petType;
  List<String>? photos;
  double? price;
  String? startDate;
  String? title;
  int? publisherID; //userID of the owner of advert
  List<String>?
      userIds; // list of ids who adds this advert to his/her favorites

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
    this.userIds,
  });

  factory AdvertModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertModelToJson(this);
}
