// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Site _$SiteFromJson(Map<String, dynamic> json) {
  return Site(
    json['name'] as String,
    json['coords'] == null
        ? null
        : Coords.fromJson(json['coords'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SiteToJson(Site instance) => <String, dynamic>{
      'name': instance.name,
      'coords': instance.coords?.toJson(),
    };
