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
      photos: json['photos'] as String?,
      favoriteCount: json['favoriteCount'] as int?,
    );

Map<String, dynamic> _$AdvertModelToJson(AdvertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'petType': instance.petType,
      'address': instance.address,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'price': instance.price,
      'description': instance.description,
      'photos': instance.photos,
      'favoriteCount': instance.favoriteCount,
    };
