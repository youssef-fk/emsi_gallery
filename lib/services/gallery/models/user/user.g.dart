// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Data _$_$DataFromJson(Map<String, dynamic> json) {
  return _$Data(
    faceId: json['faceId'] as int,
    name: json['name'] as String,
    box: json['box'] == null
        ? null
        : RectModel.fromJson(json['box'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$DataToJson(_$Data instance) => <String, dynamic>{
      'faceId': instance.faceId,
      'name': instance.name,
      'box': instance.box?.toJson(),
    };
