// ignore_for_file: public_member_api_docs, sort_constructors_first

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
  String? photos;
  int? favoriteCount;

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
  });

  factory AdvertModel.fromJson(Map<String, dynamic> json) =>
      _$AdvertModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertModelToJson(this);
}
