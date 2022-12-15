// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertModel _$AdvertModelFromJson(Map<String, dynamic> json) => AdvertModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      petType: json['petType'] as String?,
      address: json['address'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      favoriteCount: json['favoriteCount'] as int?,
      publisherID: json['publisherID'] as int?,
      userIds:
          (json['userIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AdvertModelToJson(AdvertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'description': instance.description,
      'endDate': instance.endDate,
      'favoriteCount': instance.favoriteCount,
      'petType': instance.petType,
      'photos': instance.photos,
      'price': instance.price,
      'startDate': instance.startDate,
      'title': instance.title,
      'publisherID': instance.publisherID,
      'userIds': instance.userIds,
    };
