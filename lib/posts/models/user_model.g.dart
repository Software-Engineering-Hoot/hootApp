// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      passwordAgain: json['passwordAgain'] as String?,
      advertIDs: (json['advertIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      favAdvertIDs: (json['favAdvertIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      phoneNumber: json['phoneNumber'] as String?,
      userID: json['userID'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'password': instance.password,
      'passwordAgain': instance.passwordAgain,
      'advertIDs': instance.advertIDs,
      'favAdvertIDs': instance.favAdvertIDs,
      'userID': instance.userID,
      'phoneNumber': instance.phoneNumber,
    };
