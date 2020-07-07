// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Data _$_$DataFromJson(Map<String, dynamic> json) {
  return _$Data(
    imagePath: json['imagePath'] as String,
    posterProfileUuid: json['posterProfileUuid'] as String,
    taggedUsers: (json['taggedUsers'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$_$DataToJson(_$Data instance) => <String, dynamic>{
      'imagePath': instance.imagePath,
      'posterProfileUuid': instance.posterProfileUuid,
      'taggedUsers': instance.taggedUsers?.map((e) => e?.toJson())?.toList(),
      'title': instance.title,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
