// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coords.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coords _$CoordsFromJson(Map<String, dynamic> json) {
  return Coords(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CoordsToJson(Coords instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
